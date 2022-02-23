void pathFollowingPlayer() {
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
  
  player = new Boid(10, 10, false);
  ArrayList<Movement> controllers = new ArrayList<Movement>();
  controllers.add(follow);
  controllers.add(look);
  player.setControllers(controllers);
  player.maxSpeed = 250f;
  player.drag = 0.1f;
  objects.add(player);
  objects.add(player.crumbs);
}

void pathFollowingMonster() {
  monster = new Boid(400, 400, false);
  monster.c = color(255, 10, 10, 155);
  ArrayList<Movement> controllers = new ArrayList<Movement>();
  monster.setControllers(controllers);
  monster.maxSpeed = 250f;
  monster.drag = 0.1f;
  objects.add(monster);
  objects.add(monster.crumbs);
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
      rooms.reset("node" + abs(round((player.getPosition().x - 0.5 * imageScale)/imageScale)) + ":" + abs(round((player.getPosition().y - 0.5 * imageScale)/imageScale)),
        ("node" + targetX + ":" + targetY));
      while (null == Asearch.shortestPath() && null != Asearch.openSet())
        Asearch.update();
      follow.path = new PointPath(Asearch.shortestPath());
      follow.currentParam = 0.0;
    }
  }
}

void followMonsterSetup() {
  AsearchMonster = new AStarPath<Point>(new Euclidean());
  AsearchMonster.reset(roomsGraph.get("node" + round((monster.getPosition().x - 0.5 * imageScale)/imageScale) + ":" + round((monster.getPosition().y - 0.5 * imageScale)/imageScale)),
        roomsGraph.get("node" + round((player.getPosition().x - 0.5 * imageScale)/imageScale) + ":" + round((player.getPosition().y - 0.5 * imageScale)/imageScale)));
  while (null == AsearchMonster.shortestPath() && null != AsearchMonster.openSet())
    AsearchMonster.update();
  PointPath path = new PointPath( AsearchMonster.shortestPath() );
  // Charge
  followMonster = new SteeringFollowing(path);
  followMonster.maxSpeed = 125f;
  followMonster.epsilon = 2.0;
  followMonster.currentParam = 0.0;
  // Slow
  followMonsterSlow = new SteeringFollowing(path);
  followMonsterSlow.maxSpeed = 50f;
  followMonsterSlow.epsilon = 2.0;
  followMonsterSlow.currentParam = 0.0;
}
