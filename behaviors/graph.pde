interface GraphSearch<T> {
  void reset(Node<T> start, Node<T> goal);
  void update();
  List<Edge<T>> shortestPath();
  Collection<Node<T>> openSet();
  Collection<Node<T>> closedSet();
  int getIterations();
}

class Node<T> {
  boolean occupied;
  T value;
  List<Edge<T>> incoming;
  List<Edge<T>> outgoing;
  
  Node(T value) {
    this.occupied = false;
    this.value = value;
    this.incoming = new ArrayList<Edge<T>>();
    this.outgoing = new ArrayList<Edge<T>>();
  }
  
  void edgeTo(Node<T> node, float weight) {
    Edge<T> edge = new Edge<T>(this, node, weight);
    this.outgoing.add(edge);
    node.incoming.add(edge);
  }
}



class Edge<T> {
  float weight;
  Node<T> start;
  Node<T> end;
  
  Edge(Node<T> start, Node<T> end, float weight) {
    this.start = start;
    this.end = end;
    this.weight = weight;
  }
}


class Point {
  float x;
  float y;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}



class Graph extends GameObject{
  
  float scale = 20f;

  HashMap<String, Node<Point>> graph;
  
  GraphSearch<Point> search;
  Node<Point> start = null;
  Node<Point> goal = null;
  
  boolean detailed;
  
  Graph(HashMap<String, Node<Point>> graph, GraphSearch search, boolean detailed) {
    this.graph = graph;
    this.search = search;
    this.detailed = detailed;
  }
  
  void reset(String start, String goal) {
    this.start = graph.get(start);
    this.goal = graph.get(goal);
    
    search.reset(this.start, this.goal);
  }
  
  void update() {
    search.update();
  }
  
  void render() {
    
    // Draw map
    stroke(0,0,0);
    
    // Draw open and closed sets if available
    Collection<Node<Point>> open = search.openSet();
    
    if(null != open && detailed) {
      noStroke();
      fill(0, 180, 255);
      
      for(Node<Point> node : open)
        circle(node.value.x * scale + 0.5 * scale, 
          node.value.y * scale  + 0.5 * scale, 0.8 * scale);
    }
    
    Collection<Node<Point>> closed = search.closedSet();
    
    if(null != closed && detailed) {
      noStroke();
      fill(100, 100, 100);
      
      for(Node<Point> node : closed)
        circle(node.value.x * scale + 0.5 * scale, 
          node.value.y * scale  + 0.5 * scale, 0.8 * scale);
    }
    
    // Draw path if available
    List<Edge<Point>> path = search.shortestPath();
    
    if(null != path) {
      //System.out.println(search.getIterations());
      for (Node<Point> n : graph.values()) {
        if (!n.occupied) {
          fill(0,0,0);
          circle(n.value.x * scale + 0.5 * scale, 
              n.value.y * scale  + 0.5 * scale, 0.1 * scale);
          if (detailed) {
            stroke(200, 200, 200);
            for (Edge<Point> edge : n.outgoing) {
              float sx = edge.start.value.x * scale + 0.5 * scale;
              float sy = edge.start.value.y * scale + 0.5 * scale;
              float ex = edge.end.value.x * scale + 0.5 * scale;
              float ey = edge.end.value.y * scale + 0.5 * scale; 
              line(sx, sy, ex, ey);
            }
          }
        } else {
          fill(200,0,200);
          circle(n.value.x * scale + 0.5 * scale, 
              n.value.y * scale  + 0.5 * scale, 0.75 * scale);
        }
      }
      
      strokeWeight(5);
      stroke(230, 230, 0);
      
      for(Edge<Point> edge : path) {
        float sx = edge.start.value.x * scale + 0.5 * scale;
        float sy = edge.start.value.y * scale + 0.5 * scale;
        float ex = edge.end.value.x * scale + 0.5 * scale;
        float ey = edge.end.value.y * scale + 0.5 * scale; 
        line(sx, sy, ex, ey);
      }
      
      strokeWeight(1);
    }
    
    // Draw start and goal
    if(null != start) {
      noStroke();
      fill(255,0,0);
      circle(start.value.x * scale + 0.5 * scale, 
        start.value.y * scale  + 0.5 * scale, 0.8 * scale);
    }
    
    if(null != goal) {
      noStroke();
      fill(0,255,0);
      circle(goal.value.x * scale + 0.5 * scale, 
        goal.value.y * scale + 0.5 * scale, 0.8 * scale);
    }
    
  }
}



class Tag<T> implements Comparable<Tag<T>> {
  Node<T> node;
  
  // Used to store ctg or cfs
  float c;
  Edge<T> edge;
  
  Tag(Node<T> node, float c, Edge<T> edge) {
    this.node = node;
    this.c = c;
    this.edge = edge;
  }
  
  int compareTo(Tag<T> o) {
    if(this.c < o.c)
      return -1;
    else if(this.c > o.c)
      return 1;
    else
      return 0;
  }
}
