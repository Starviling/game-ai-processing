// Implementation of wander behavior - requires a secondary behavior to be attached to face properly
class Wander implements Movement {
  // Holds the max rate at which wander orientates
  float wanderRate = 0.5f;
  // Holds the current orientation of wander target
  float wanderOrientation = 0;
  float maxAcceleration = 100f;
  float maxRotation = PI;
  
  Kinematic wanderTarget = new Kinematic();
  
  float sampleDifference() {
    return random(1.0f) - random(1.0f);
  }
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = new SteeringOutput();
    wanderOrientation += sampleDifference() * wanderRate;
    wanderTarget.orientation = wanderOrientation + character.orientation;
    
    result.linear = PVector.mult(PVector.fromAngle(wanderTarget.orientation).normalize(), maxAcceleration);
    
    return result;
  }
}




// Secondary implementation of wander where it is essentially fused with face
class WanderOther extends SteeringFaceOther {
  // Holds the radius and forward offset of the wander
  float wanderOffset = 10f;
  float wanderRadius = 50f;
  // Holds the max rate at which wander orientates
  float wanderRate = 0.5f;
  // Holds the current orientation of wander target
  float wanderOrientation = 0;
  float maxAcceleration = 100f;
  
  // Seek the target
  SteeringSeek seeker = new SteeringSeek();
  
  float sampleDifference() {
    return random(1.0f) - random(1.0f);
  }
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = new SteeringOutput();
    
    // Calculate target to delegate to face
    wanderOrientation += sampleDifference() * wanderRate;                          // Update wander orientation
    float targetOrientation = wanderOrientation + character.orientation;           // Calculate the combined target orientation

    super.target.position = PVector.add(character.position, PVector.mult(PVector.fromAngle(character.orientation).normalize(), wanderOffset));            // Calculate the center of the wander circle
    super.target.position.add(PVector.mult(PVector.fromAngle(targetOrientation).normalize(), wanderRadius));                                              // Calculate the target location
    seeker.target = super.target;
    
    // Delgate to other align algorithm
    result = super.getSteering(character);
    
    // Set linear accel to full
    result.linear = seeker.getSteering(character).linear;
    
    
    return result;
  }
}






// Tertiary implementation of wander where it is essentially fused with look
class WanderOtherLook extends SteeringLook {
  // Holds the radius and forward offset of the wander
  float wanderOffset = 10f;
  float wanderRadius = 50f;
  // Holds the max rate at which wander orientates
  float wanderRate = 0.5f;
  // Holds the current orientation of wander target
  float wanderOrientation = 0;
  float maxAcceleration = 100f;
  
  // Seek the target
  SteeringSeek seeker = new SteeringSeek();
  
  float sampleDifference() {
    return random(1.0f) - random(1.0f);
  }
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = new SteeringOutput();
    
    // Calculate target to delegate to face
    wanderOrientation += sampleDifference() * wanderRate;                          // Update wander orientation
    float targetOrientation = wanderOrientation + character.orientation;           // Calculate the combined target orientation

    super.target.position = PVector.add(character.position, PVector.mult(PVector.fromAngle(character.orientation).normalize(), wanderOffset));            // Calculate the center of the wander circle
    super.target.position.add(PVector.mult(PVector.fromAngle(targetOrientation).normalize(), wanderRadius));                                              // Calculate the target location
    seeker.target = super.target;
    
    // Delgate to other align algorithm
    result = super.getSteering(character);
    
    // Set linear accel to full
    result.linear = seeker.getSteering(character).linear;
    
    
    return result;
  }
}
