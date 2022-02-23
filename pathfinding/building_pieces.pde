// Steering behavior output
class SteeringOutput {
  // velocity for kine
  // accel for dynamic
  PVector linear;
  // aja angular
  float angular;
  
  SteeringOutput() {
    this.linear = new PVector(0.0f, 0.0f);
    this.angular = 0.0f;
  }
  
  SteeringOutput(PVector velocity, float rotation) {
    this.linear = velocity;
    this.angular = rotation;
  }
}

// Holds movement
interface Movement {
  SteeringOutput getSteering(Kinematic character);
}

// Holds the position and orientation of entity
class Kinematic {
  PVector position;
  float orientation;
  PVector velocity;
  float rotation;
  
  Kinematic() {
    this.position = new PVector(.0f, .0f);
    this.orientation = .0f;
    this.velocity = new PVector(.0f, .0f);
    this.rotation = .0f;
  }     
  
  Kinematic(PVector position, float orientation) {
    this.position = position;
    this.orientation = orientation;
    this.velocity = new PVector(.0f, .0f);
    this.rotation = .0f;
  }
  
  Kinematic(PVector position, float orientation, float rotation) {
    this.position = position;
    this.orientation = orientation;
    this.velocity = new PVector(.0f, .0f);
    this.rotation = rotation;
  }   
}
