import java.util.List;
import java.util.Collection;
import java.util.PriorityQueue;
import java.util.HashSet;
import java.util.HashMap;

int FRAME_RATE = 60;
Graph image;

// For handling the division scheme
float imageScale = 20.0;
int graphSizeX = 30;
int graphSizeY = 30;
HashMap<String, Node<Point>> roomsGraph;
Graph rooms;
boolean[][] obstacles;
GraphSearch<Point> Asearch;
SteeringFollowing follow;
Boid boid;

ArrayList<GameObject> objects = new ArrayList<GameObject>();

void setup() {
  
  // Confugure search
  //GraphSearch<Point> search = new GreedyBestFirst<Point>(new Manhattan());
  //GraphSearch<Point> search = new GreedyBestFirst<Point>(new Euclidean());
  //GraphSearch<Point> search = new DijkstraPath<Point>();
  //GraphSearch<Point> search = new AStarPath<Point>(new Manhattan());
  //GraphSearch<Point> search = new AStarPath<Point>(new Euclidean());
  GraphSearch<Point> search = new AStarPath<Point>(new Power());
  
  // Build graph for Europian Union
  //HashMap<String, Node<Point>> graph = generateCustomMapOne();
  //image = new Graph(graph, search, true);
  //image.reset("ireland", "cyprus");
  
  // Generate obstacles will create for a 30x30
  //HashMap<String, Node<Point>> graph = generateCustomMapTwo(30, 30, generateObstacles());
  //image = new Graph(graph, search, true);
  //image.reset("node1:2", "node19:15");
  
  // Build graph for random graph
  HashMap<String, Node<Point>> graph = generateCustomRandomMap(10000, 0.5);
  image = new Graph(graph, search, true);
  image.reset("node1", "node2");

  //pathFollowing();

  // Configure processing
  size(650,650);
  frameRate(FRAME_RATE);
  smooth(2);
}

void pathFollowing() {
  Asearch = new AStarPath<Point>(new Euclidean());
  
  obstacles = generateObstacles(graphSizeX, graphSizeY);
  roomsGraph = generateCustomMapTwo(graphSizeX, graphSizeY, generateObstacles(graphSizeX, graphSizeY));
  rooms = new Graph(roomsGraph, Asearch, false);
  rooms.reset("node1:2", "node19:15");
  
  while (null == Asearch.shortestPath() && null != Asearch.openSet())
    Asearch.update();
  
  PointPath path = new PointPath( Asearch.shortestPath() );
  objects.add(path);
  objects.add(rooms);
    
  follow = new SteeringFollowing(path);
  follow.epsilon = 2.0;
  follow.currentParam = 0.0;
  
  SteeringLook look = new SteeringLook();
  look.maxAngular = 10.0f * PI;
  look.maxRotation = 2.0 * PI;
  look.targetRadius = 0.0001f * PI;
  look.slowRadius = 0.2 * PI;
  look.timeToTarget = 0.25f;
  
  boid = new Boid(10, 10, false);
  boid.addMovement(follow);
  boid.addMovement(look);
  boid.maxSpeed = 250f;
  boid.drag = 0.1f;
  objects.add(boid);
  objects.add(boid.crumbs);
}

void updateTarget() {
  if(mousePressed) {
    int targetX = abs(round((mouseX - 0.5 * imageScale)/imageScale));
    int targetY = abs(round((mouseY - 0.5 * imageScale)/imageScale));
    
    if (targetX >= graphSizeX) {
      targetX = graphSizeX - 1;
    }
    if (targetY >= graphSizeY)
      targetY = graphSizeY - 1;

    if (!obstacles[targetX][targetY]) {
      rooms.reset("node" + round((boid.getPosition().x - 0.5 * imageScale)/imageScale) + ":" + round((boid.getPosition().y - 0.5 * imageScale)/imageScale),
        ("node" + targetX + ":" + targetY));
      while (null == Asearch.shortestPath() && null != Asearch.openSet())
        Asearch.update();
      follow.path = new PointPath(Asearch.shortestPath());
      follow.currentParam = 0.0;
    }
  }
}

void draw(){
  float dt = 1.0f / (float) FRAME_RATE;
  
  // Do planning update
  if (null != image)
    image.update();
  if (null != rooms)
    updateTarget();
  
  
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

boolean[][] generateObstacles(int graphSizeX, int graphSizeY) {
  // Build graph for Grid Rooms
  boolean[][] obstacles = empty(graphSizeX,graphSizeY);
  obstacles[10][8] = true;
  obstacles[10][9] = true;
  obstacles[10][10] = true;
  obstacles[10][11] = true;
  obstacles[10][12] = true;
  obstacles[10][13] = true;
  obstacles[10][14] = true;
  obstacles[10][15] = true;
  obstacles[9][15] = true;
  obstacles[8][15] = true;
  obstacles[7][15] = true;
  obstacles[6][15] = true;
  obstacles[5][15] = true;
  obstacles[4][15] = true;
  obstacles[3][15] = true;
  obstacles[2][15] = true;
  
  obstacles[6][1] = true;
  obstacles[6][2] = true;
  obstacles[6][3] = true;
  obstacles[6][4] = true;
  obstacles[6][5] = true;
  obstacles[6][6] = true;
  obstacles[6][7] = true;
  obstacles[6][8] = true;
  obstacles[6][9] = true;
  obstacles[6][10] = true;
  obstacles[6][11] = true;
  obstacles[6][12] = true;
  obstacles[6][14] = true;
  obstacles[6][15] = true;
  obstacles[6][16] = true;
  obstacles[6][17] = true;
  obstacles[6][18] = true;
  obstacles[6][19] = true;
  obstacles[6][20] = true;
  obstacles[6][21] = true;
  obstacles[6][22] = true;
  obstacles[6][23] = true;
  obstacles[6][24] = true;
  obstacles[6][25] = true;
  obstacles[6][26] = true;
  obstacles[6][27] = true;
  obstacles[6][28] = true;
  
  obstacles[8][9] = true;
  obstacles[9][9] = true;
  obstacles[10][9] = true;
  obstacles[11][9] = true;
  obstacles[12][9] = true;
  obstacles[13][9] = true;
  obstacles[14][9] = true;
  obstacles[15][9] = true;
  obstacles[16][9] = true;
  obstacles[17][9] = true;
  obstacles[18][9] = true;
  obstacles[19][9] = true;
  obstacles[20][9] = true;
  obstacles[21][9] = true;
  obstacles[22][9] = true;
  obstacles[23][9] = true;
  obstacles[24][9] = true;
  obstacles[25][9] = true;
  obstacles[26][9] = true;
  obstacles[27][9] = true;
  obstacles[28][9] = true;
  obstacles[29][9] = true;
  
  obstacles[12][14] = true;
  obstacles[12][15] = true;
  obstacles[12][16] = true;
  obstacles[12][17] = true;
  obstacles[12][18] = true;
  obstacles[12][19] = true;
  obstacles[12][20] = true;
  obstacles[12][21] = true;
  obstacles[12][22] = true;
  obstacles[12][23] = true;
  obstacles[12][24] = true;

  obstacles[20][14] = true;
  obstacles[20][15] = true;
  obstacles[20][16] = true;
  obstacles[20][17] = true;
  obstacles[20][18] = true;
  obstacles[20][19] = true;
  obstacles[20][20] = true;
  obstacles[20][21] = true;
  obstacles[20][22] = true;
  obstacles[20][23] = true;
  obstacles[20][24] = true;
  obstacles[20][25] = true;
  obstacles[20][26] = true;
  obstacles[20][27] = true;
  obstacles[20][28] = true;
  
  obstacles[17][20] = true;
  obstacles[18][20] = true;
  obstacles[19][20] = true;
  obstacles[20][20] = true;
  obstacles[21][20] = true;
  obstacles[22][20] = true;
  obstacles[25][20] = true;
  obstacles[26][20] = true;
  obstacles[27][20] = true;
  obstacles[28][20] = true;
  obstacles[29][20] = true;

  return obstacles;
}
