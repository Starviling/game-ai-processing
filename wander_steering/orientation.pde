// Gets the new orientation
float getNewOrientation(float orientation, PVector velocity, float smoothing) {
  if(velocity.magSq() >= .001f) {
    float target = atan2(-velocity.y, velocity.x);
    
    if(.0f < smoothing) {
      float delta = (target - orientation);
      
      if(PI < delta)
        delta -= TWO_PI;
      else if(-PI > delta)
        delta += TWO_PI;
        
      return orientation + delta * smoothing;
    }
    
    return target;
  }
  
  return orientation;
}

// Align the boid
class SteeringAlign implements Movement {
  
  Kinematic target = new Kinematic();
  
  float maxAngular = 2.0f * PI;
  float maxRotation = PI;
  
  float targetRadius = 0.001f * PI;
  float slowRadius = 0.25 * PI;
  float timeToTarget = 0.5f;
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = new SteeringOutput();
    float delta = target.orientation - character.orientation;
    
    if(PI < delta)
      delta -= TWO_PI;
    else if(-PI > delta)
      delta += TWO_PI;
    
    float absDelta = abs(delta);
    
    if(absDelta <= targetRadius)
      return result;
      
    float targetRotation = maxRotation;
    
    if(absDelta <= slowRadius)
      targetRotation *= absDelta / slowRadius; 
    
    targetRotation *= delta / absDelta;
    
    result.angular = targetRotation - character.rotation;
    result.angular /= timeToTarget;
    
    float absAngular = abs(result.angular);
    
    if(absAngular > maxAngular) {
      result.angular /= absAngular;
      result.angular *= maxAngular;
    }
    
    return result;
  }
}

// Face the target
class SteeringFace extends SteeringAlign {

  Kinematic faceTarget = null;
  
  void updateTarget() {
    if(mousePressed)
      faceTarget = new Kinematic(new PVector(mouseX, mouseY), .0f);
  }
  
  SteeringOutput getSteering(Kinematic character) {
    updateTarget();
    
    if(null == faceTarget)
      return null;
    
    PVector direction = PVector.sub(faceTarget.position, character.position);
    
    if(direction.magSq() < .001f)
      return null;
      
    super.target.orientation = atan2(-direction.y, direction.x);
    return super.getSteering(character);
  }
}

// Face the target
class SteeringFaceOther extends SteeringAlign {
  
  SteeringOutput getSteering(Kinematic character) {
    
    PVector direction = PVector.sub(super.target.position, character.position);
    
    if(direction.magSq() < .001f)
      return null;
      
    super.target.orientation = atan2(-direction.y, direction.x);
    return super.getSteering(character);
  }
}

class SteeringLook extends SteeringAlign {

  SteeringOutput getSteering(Kinematic character) {
     if(character.velocity.mag() >= 0.01f)
       target.orientation = atan2(-character.velocity.y, character.velocity.x);
     
     return super.getSteering(character);
  }
}


class SteeringSeek implements Movement {

  Kinematic target = null;
  
  float maxLinear = 500f;
  
  SteeringOutput getSteering(Kinematic character) {
    if(null == target)
      return null;
      
    SteeringOutput result = new SteeringOutput();
     
    result.linear = PVector.sub(target.position, character.position);
    result.linear.normalize().mult(maxLinear);
    
    return result;
  }
}
