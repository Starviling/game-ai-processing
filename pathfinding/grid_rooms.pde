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
