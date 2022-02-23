import java.util.ArrayDeque;

// Leaves bread crumbs behind
class KinematicBreadcrumbs {
 
  ArrayDeque<PVector> breadcrumbs = new ArrayDeque<PVector>();
  int crumbLimit = 20;
  
  Boid boid;
  PVector lastPosition;
  float distance;
  
  float interval = 15f;
  float size = 4f;
  
  KinematicBreadcrumbs(Boid boid) {
    this.boid = boid;
    
    lastPosition = boid.character.position;
    for (int i = 0; i < crumbLimit; i++) {
      breadcrumbs.add(lastPosition);
    }
    
    distance = 0.0f;
  }
  
  void update(float dt) {
    distance += PVector.sub(lastPosition, boid.character.position).mag();
    lastPosition = boid.character.position.copy();
    
    if(distance >= interval) {
      breadcrumbs.remove();
      breadcrumbs.add(lastPosition);

      distance = 0.0f;
    }
  }
  
  void render() {
    fill(0,180,255);
    stroke(0,180,255);
    
    for(PVector crumb : breadcrumbs)
      circle(crumb.x, crumb.y, size);
  }
}
