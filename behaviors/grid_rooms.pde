boolean[][] empty(int w, int h) {
  boolean[][] map = new boolean[h][w];
  
  for(int y=0; y < h; ++y)
    for(int x=0; x < w; ++x)
      map[y][x] = false;
      
  return map;
}

HashMap<String, Node<Point>> generateCustomMapTwo(int xLength, int yLength, boolean[][] obstacles) {
  boolean[][] map;
  map = empty(xLength, yLength);
  
  // Initialize graph
  HashMap<String, Node<Point>> graph = new HashMap<String, Node<Point>>();
  
  for(int y=0; y < yLength; ++y) {
    for(int x=0; x < xLength; ++x) {
      Node cell = new Node<Point>(new Point(x,y));
      cell.occupied = obstacles[y][x];
      graph.put("node" + x + ":" + y, cell);
    }
  }
  
  // Construct UP edges
  for(int y=0; y < yLength - 1; ++y)
    for(int x=0; x < xLength; ++x)
      if(!map[y + 1][x])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + x + ":" + (y + 1)), 1.0f);
  
  // Construct DOWN edges
  for(int y=1; y < map.length; ++y)
    for(int x=0; x < map[y].length; ++x)
      if(!map[y - 1][x])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + x + ":" + (y - 1)), 1.0f);
      
  // Construct LEFT edges
  for(int y=0; y < map.length; ++y)
    for(int x=1; x < map[y].length; ++x)
      if(!map[y][x - 1])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + (x - 1) + ":" + y), 1.0f);
      
  // Construct RIGHT edges
  for(int y=0; y < map.length; ++y)
    for(int x=0; x < map[y].length - 1; ++x)
      if(!map[y][x + 1])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + (x + 1) + ":" + y), 1.0f);
      
  float root = sqrt(2.0f);
  
  // Construct UP-LEFT edges
  for(int y=0; y < map.length - 1; ++y)
    for(int x=1; x < map[y].length; ++x)
      if(!map[y + 1][x - 1])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + (x - 1) + ":" + (y + 1)), root);
  
  // Construct UP-RIGHT edges
  for(int y=0; y < map.length - 1; ++y)
    for(int x=0; x < map[y].length - 1; ++x)
      if(!map[y + 1][x + 1])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + (x + 1) + ":" + (y + 1)), root);

  // Construct DOWN-LEFT edges
  for(int y=1; y < map.length; ++y)
    for(int x=1; x < map[y].length; ++x)
      if(!map[y - 1][x - 1])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + (x - 1) + ":" + (y - 1)), root);
  
  // Construct DOWN-RIGHT edges
  for(int y=1; y < map.length; ++y)
    for(int x=0; x < map[y].length - 1; ++x)
      if(!map[y - 1][x + 1])
        graph.get("node" + x + ":" + y).edgeTo(graph.get("node" + (x + 1) + ":" + (y - 1)), root);
  
  return graph;
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
