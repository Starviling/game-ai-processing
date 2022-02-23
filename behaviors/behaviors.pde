import java.util.List;
import java.util.Collection;
import java.util.PriorityQueue;
import java.util.HashSet;
import java.util.HashMap;
import java.util.stream.Collectors;

// Basic setup
int FRAME_RATE = 60;
Graph image;

// For handling the division scheme
float imageScale = 20.0;
int graphSizeX = 30;
int graphSizeY = 30;
HashMap<String, Node<Point>> roomsGraph;
Graph rooms;
boolean[][] obstacles;

// For pathfinding
GraphSearch<Point> Asearch;
GraphSearch<Point> AsearchMonster;
SteeringFollowing follow;
SteeringFollowing followMonster;
SteeringFollowing followMonsterSlow;
Boid player;
Boid monster;

// For decision regarding time
Timer within;
Timer outside;

// Tree creation
DecisionTreeNode decisionTree = null;
BehaviorTreeNode behaviorTree = null;

// The filedata being saved and read
String fileData = "id3Data.txt";

// Objects to draw
ArrayList<GameObject> objects;

// For decision tree learning saving data
ArrayList<Action> actionsTaken;
PrintWriter output;

// Set up everything from the start
void setup() {
  start();
  
  // Decision tree the basis
  //decisionTree();
  
  // Behavior tree will define printwriter
  //behaviorTree();
  
  // If the file id3Data.txt does not exist, then this will fail
  treeLearning();
  //printNode((DecisionNode) decisionTree);

  // Configure processing
  size(650,650);
  frameRate(FRAME_RATE);
  smooth(2);
}

// Start of the game
void start() {
  objects = new ArrayList<GameObject>();
  within = null;
  outside = null;
  
  pathFollowingPlayer();
  pathFollowingMonster();
}

// Close files before exiting
void exit() {
  if (null != output)
    output.close();
  super.exit();
}



// Main loop
void draw(){
  float dt = 1.0f / (float) FRAME_RATE;
  
  // Do planning update
  if (null != image)
    image.update();
  if (null != rooms)
    updateTarget();
  
  // Restart when player gets too close to monster
  if (PVector.sub(player.getPosition(), monster.getPosition()).mag() <= 25f) {
    start();
  }
  
  // Build decision context
  GameState state = new GameState();
  
  // State for range
  if (PVector.sub(player.getPosition(), monster.getPosition()).mag() > 200f) {
    state.add("withinRange", "False");
    within = null;
    if (outside == null)
      outside = new Timer(millis());
  } else {
    state.add("withinRange", "True");
    outside = null;
    if (within == null)
      within = new Timer(millis());
  }
  
  // State for time
  if (within == null && (millis() - outside.start) > 10000) {
    state.add("timeOutRange", "True");
  } else {
    state.add("timeOutRange", "False");
  }
  if (outside == null && (millis() - within.start) > 7500) {
    state.add("timeInRange", "True");
  } else {
    state.add("timeInRange", "False");
  }
  
  // Set up evaluation
  DecisionContext context = new DecisionContext(monster, state);
  
  // Run decision making algorithm
  if(null != decisionTree) {
    decisionTree.evaluate(context);
  } else if(null != behaviorTree) {
    // Behavior tree will print action into output
    behaviorTree.run(context);
  }
  
  // Save the current information to the file
  if (null != output) {
    int i = 0;
    int total = state.data.size();
    for (HashMap.Entry<String, String> e : state.data.entrySet()) {
      output.print(e.getKey() + "_" + e.getValue());
      i++;
      if (i < total)
        output.print(",");
    }
    output.print(" ");
    for (i = 0; i < actionsTaken.size(); i++) {
      output.print(actionsTaken.get(i).getId());
      if (i < actionsTaken.size() - 1)
        output.print(",");
    }
    output.print('\n');
    output.flush();
    actionsTaken.clear();
  }
  
  Node<Point> monsterStart = roomsGraph.get("node" + round((monster.getPosition().x - 0.5 * imageScale)/imageScale) + ":" + round((monster.getPosition().y - 0.5 * imageScale)/imageScale));
  Node<Point> monsterEnd = roomsGraph.get("node" + round((player.getPosition().x - 0.5 * imageScale)/imageScale) + ":" + round((player.getPosition().y - 0.5 * imageScale)/imageScale));
  if (monsterStart != null && monsterEnd != null) {
    AsearchMonster.reset(monsterStart, monsterEnd);
    while (null == AsearchMonster.shortestPath() && null != AsearchMonster.openSet())
      AsearchMonster.update();
    followMonster.path = new PointPath(AsearchMonster.shortestPath());
    followMonster.currentParam = 0.0;
    followMonsterSlow.path = new PointPath(AsearchMonster.shortestPath());
    followMonsterSlow.currentParam = 0.0;
  }
  
  // Fill background
  background(255);
  
  // Update game objects
  for(GameObject obj : objects)
    obj.update(dt);
  
  // Render game objects
  for(GameObject obj : objects) {
    //println("Game Opject: " + obj.getPosition());
    obj.render();
  }
  
  // Draw grid
  if (null != image) {
    translate(image.scale, 0);
    scale(1, -1);
    translate(0, -height);
    image.render();
  }
}
