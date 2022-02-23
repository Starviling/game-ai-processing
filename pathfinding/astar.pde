import java.util.Collections;

class StarTag<T> extends Tag<T> {
  // Used to store ctg or cfs
  float totalEstimatedCost;
  float heuristicV;
  float cost;
  
  StarTag(Node<T> node, float cfs, float heuristicV, float total, Edge<T> edge) {
    super(node, cfs, edge);
    this.heuristicV = heuristicV;
    this.totalEstimatedCost = total;
    if (null != edge)
      this.cost = cfs + edge.weight;
    else 
      this.cost = 0;
  }
  
  @Override
  int compareTo(Tag<T> o) {
    StarTag<T> oCast = (StarTag<T>) o;
    if(this.totalEstimatedCost < oCast.totalEstimatedCost)
      return -1;
    else if(this.totalEstimatedCost > oCast.totalEstimatedCost)
      return 1;
    else
      return 0;
  }
}

class AStarPath<T> implements GraphSearch<T> {
  Heuristic<T> heuristic; 
  Node<T> goal;
  Node<T> start;
  int iterations = 0;
  HashMap<Node<T>,StarTag<T>> tags;
  
  PriorityQueue<StarTag<T>> open;
  HashMap<Node<T>,StarTag<T>> closed;
  
  AStarPath(Heuristic<T> heuristic) {
    this.heuristic = heuristic;
  }
  
  void reset(Node<T> start, Node<T> goal) {
    this.goal = goal;
    this.start = start;
    
    tags = new HashMap<Node<T>,StarTag<T>>();
  
    open = new PriorityQueue<StarTag<T>>();
    closed = new HashMap<Node<T>,StarTag<T>>();
    
    StarTag<T> tag = new StarTag<T>(start, 0, heuristic.value(start.value, goal.value), heuristic.value(start.value, goal.value), null);
    tags.put(start, tag);
    open.add(tag);
  }
  
  void update() {
    if(!tags.containsKey(goal)) {
       StarTag<T> tag = open.poll();
       this.iterations++;
       if(null != tag && tag.node != goal) {
         if (tag.node == start || !tag.node.occupied) {
            for(Edge<T> edge : tag.node.outgoing) {
               // The cost from start -> this makes it very important to have proper weights on graph
               float endNodeCost = tag.c + edge.weight;
               // The end node record
               StarTag<T> endNodeRecord = closed.get(edge.end);
               // Check if this existed in the closed set
               if (null != endNodeRecord) {
                 if (endNodeRecord.c <= endNodeCost)
                   continue;
                  
                 closed.remove(edge.end);
               }
               // Check if this existed in the open set
               else if(open.contains(tags.get(edge.end))) {
                 endNodeRecord = tags.get(edge.end);
                 
                 // If the route isn't better, skip
                 if (endNodeRecord.c <= endNodeCost)
                   continue;
               }
               // This means that we haven't visited this node before
               else {
                 // The heuristic (from node to end) stored in tag
                 float ctg = heuristic.value(edge.end.value, goal.value);
                 endNodeRecord = new StarTag<T>(edge.end, tags.get(edge.start).c + edge.weight, ctg, endNodeCost + ctg, edge);
                
                 tags.put(edge.end, endNodeRecord);
                 open.add(endNodeRecord);
                 continue;
               }
              
               endNodeRecord.c = tags.get(edge.start).c + edge.weight;
               endNodeRecord.cost = endNodeCost;
               endNodeRecord.edge = edge;
               endNodeRecord.totalEstimatedCost = endNodeCost + endNodeRecord.heuristicV;
  
               if (!open.contains(tags.get(edge.end)))
                 open.add(endNodeRecord);
  
             }
          }
          // Remove from open and add to closed (removed via poll earlier)
           closed.put(tag.node, tag);
       }
       
    }
  }
  
  List<Edge<T>> shortestPath() {
    if(tags.containsKey(goal)) {
      ArrayList<Edge<T>> path = new ArrayList<Edge<T>>();
      
      StarTag<T> tag = tags.get(goal);
      
      while(null != tag.edge) {
        path.add(tag.edge);
        tag = tags.get(tag.edge.start);
      }
      Collections.reverse(path);
      return path;
    } else {
      return null;
    }
  }
  
  Collection<Node<T>> openSet() {
    if(null != open) {
      ArrayList<Node<T>> list = new ArrayList<Node<T>>();
    
      for(StarTag<T> tag : open)
        list.add(tag.node);
    
      return list;
    } else {
      return null;
    }
  }
  
  Collection<Node<T>> closedSet() {
    if(null != closed) {
      ArrayList<Node<T>> list = new ArrayList<Node<T>>();
    
      for(StarTag<T> tag : closed.values())
        list.add(tag.node);
    
      return list;
    } else {
      return null;
    }
  }
  
  int getIterations() {
    return iterations;
  }
}
