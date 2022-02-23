HashMap<String, Node<Point>> generateCustomRandomMap(float totalNodes, float nodeRange) {
  HashMap<String, Node<Point>> graph = new HashMap<String, Node<Point>>();
  int scale = 20;
  randomSeed(100);
  for (int i = 1; i <= totalNodes; i++) {
    graph.put("node" + i, new Node<Point>(new Point(random(0, 1.0f) * scale, random(0, 1.0f) * scale)));
  }
  
  // Follows pseudo code for naive algorithm random graph generation
  for (Node<Point> p : graph.values()) {
    Collection<Node<Point>> other = new ArrayList<Node<Point>>();
    other.addAll(graph.values());
    other.remove(p);
    for (Node<Point> q : other) {
      float dist = distance(p,q);
      if (dist <= nodeRange) {
        p.edgeTo(q, dist);
        q.edgeTo(p, dist);
      }
    }
  }
  
  return graph;
}
