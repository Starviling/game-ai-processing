class GreedyBestFirst<T> implements GraphSearch<T> {
  Heuristic<T> heuristic; 
  
  Node<T> goal;
  int iterations = 0;
  HashMap<Node<T>,Tag<T>> tags;
  
  PriorityQueue<Tag<T>> open;
  HashSet<Node<T>> closed;
  
  GreedyBestFirst(Heuristic<T> heuristic) {
    this.heuristic = heuristic;
  }
  
  void reset(Node<T> start, Node<T> goal) {
    this.goal = goal;
    
    tags = new HashMap<Node<T>,Tag<T>>();
  
    open = new PriorityQueue<Tag<T>>();
    closed = new HashSet<Node<T>>();
    
    Tag<T> tag = new Tag<T>(start, heuristic.value(start.value, goal.value), null);
    tags.put(start, tag);
    open.add(tag);
  }
  
  void update() {
    if(!tags.containsKey(goal)) {
       Tag<T> tag = open.poll();
       iterations++;
       if(null != tag && !closed.contains(tag.node) && !tag.node.occupied) {
          for(Edge<T> edge : tag.node.outgoing) {
            if(!tags.containsKey(edge.end)) {
              float ctg = heuristic.value(edge.end.value, goal.value);
              Tag<T> next_tag = new Tag<T>(edge.end, ctg, edge);
              
              tags.put(edge.end, next_tag);
              open.add(next_tag);
            }
            
            if(edge.end == goal)
              break;
          }
          
          closed.add(tag.node);
       }
    }
  }
  
  List<Edge<T>> shortestPath() {
    if(tags.containsKey(goal)) {
      ArrayList<Edge<T>> path = new ArrayList<Edge<T>>();
      
      Tag<T> tag = tags.get(goal);
      
      while(null != tag.edge) {
        path.add(tag.edge);
        tag = tags.get(tag.edge.start);
      }
      
      return path;
    } else {
      return null;
    }
  }
  
  Collection<Node<T>> openSet() {
    if(null != open) {
      ArrayList<Node<T>> list = new ArrayList<Node<T>>();
    
      for(Tag<T> tag : open)
        list.add(tag.node);
    
      return list;
    } else {
      return null;
    }
  }
  
  Collection<Node<T>> closedSet() {
    return closed; 
  }
  
  int getIterations() {
    return iterations;
  }
}
