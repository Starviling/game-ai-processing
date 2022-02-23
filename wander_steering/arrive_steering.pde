class Arrive implements Movement {
  // Info on travel speed/accel
  Kinematic target = null;
  float maxAcceleration = 100f;
  float maxSpeed = 250f;
  
  // Radius indicating arrival
  float targetRadius = 10f;
  // Radius to start slowing down
  float slowRadius = 150f;
  // Time over which to achieve target speed
  float timeToTarget = 0.01f;
  
  void updateTarget() {
    if(mousePressed) {
      target = new Kinematic(new PVector(mouseX, mouseY), .0f);
    }
  }
  
  // Get steering to be paired with a facing movement
  SteeringOutput getSteering(Kinematic character) {
    updateTarget();
    if (null == target)
      return null;
    SteeringOutput result = new SteeringOutput();
    
    // Get the direction
    PVector direction = PVector.sub(target.position, character.position);
    float distance = direction.mag();
    
    
    // Determine the target speed
    float targetSpeed;
    // If we are already there
    if (distance < targetRadius)
      targetSpeed = 0;
    else if (distance > slowRadius)
      targetSpeed = maxSpeed;
    else
      targetSpeed = maxSpeed * distance / slowRadius; 
    
    // Determine the target velocity
    PVector targetVelocity = direction;
    targetVelocity.normalize();
    targetVelocity.mult(targetSpeed);
    
    // Acceleration tries to get to the target velocity
    result.linear = PVector.sub(targetVelocity, character.velocity);
    result.linear.div(timeToTarget);
    
    // Check if the acceleration too fast
    if (result.linear.mag() > maxAcceleration) {
      result.linear.normalize();
      result.linear.mult(maxAcceleration);
    }
    
    // Output the steering
    result.angular = 0;
    return result;
    
  }
}

class KinematicArrive implements Movement {
   
  Kinematic target = null;
  float timeToTarget = 0.5f;
  float stopRadius = 10;
  
  float maxSpeed = 250f;
  float smoothing = .05f;
  
  void updateTarget() {
    if(mousePressed)
      target = new Kinematic(new PVector(mouseX, mouseY), .0f);
  }
  
  SteeringOutput getSteering(Kinematic character) {
    updateTarget();
    
    if(null == target)
      return null;
    
    SteeringOutput result = new SteeringOutput();
    result.linear = PVector.sub(target.position, character.position);
    
    if(result.linear.mag() <= stopRadius) {
      character.velocity = new PVector(0f, 0f);
      return null;
    }
    
    result.linear.div(timeToTarget);
    
    if(result.linear.mag() > maxSpeed)
      result.linear.normalize().mult(maxSpeed);
    
    character.orientation = getNewOrientation(character.orientation, result.linear, smoothing);
    character.velocity = result.linear;
    
    return null;
  }
}
