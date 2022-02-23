abstract class Path extends GameObject {
  abstract PVector getPosition(float param);
  abstract float getParam(PVector position, float lastParam);
}


class PointPath extends Path {
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  float imageScale = 20.0;
  float scale = 2;
  float range = 1.0;
 
  PointPath(List<Edge<Point>> path) {
    if (path.size() >= 1)
      points.add( new PVector(((Point)path.get(0).start.value).x * imageScale + 0.5 * imageScale, ((Point)path.get(0).start.value).y * imageScale + 0.5 * imageScale) );
    for (Edge e : path) {
      //System.out.println(((Point)e.end.value).x + ":" + ((Point)e.end.value).y);
      points.add( new PVector(((Point)e.end.value).x * imageScale + 0.5 * imageScale, ((Point)e.end.value).y * imageScale + 0.5 * imageScale) );
    }
  }
 
  void addPoint(PVector point) {
    points.add(point);
  }
  
  PVector getPosition(float param) {
    int index = round(param / scale);
    
    if(index < points.size())
      return points.get(index);
    else
      if (points.size() >= 1)
        return points.get(points.size() - 1);
    return null;
  }
  
  float getParam(PVector position, float lastParam) {
    int minIndex = round((lastParam - range) / scale);
    minIndex = max(minIndex, 0);
    
    int maxIndex = round((lastParam + range) / scale) + 1;
    maxIndex = min(maxIndex, points.size());
    
    float minDistance = Float.POSITIVE_INFINITY;
    float param = 0.0;
    
    for(int i=minIndex; i < maxIndex; ++i){
       float distance = PVector.sub(points.get(i), position).mag();
       
       if(distance < minDistance){
         minDistance = distance;
         param = scale * (float) i;
       }
    }
    
    return param;
  }
  
  void render() {
    //fill(0,180,255);
    //stroke(0,180,255);
    //for(PVector point : points) {
    //  circle(point.x, point.y, 10);
    //}
  }
}

class SteeringFollowing extends KinematicArrive {
 
  Path path;
  float epsilon = 1.0;
  float currentParam = 0.0;
  
  SteeringFollowing(PointPath path) {
    this.path = path; 
  }
  
  SteeringOutput getSteering(Kinematic character) {
    currentParam = path.getParam(character.position, currentParam);
    PVector target = path.getPosition(currentParam + epsilon);
    
    super.target = new Kinematic(target, 0.);
    return super.getSteering(character);
  }
}
