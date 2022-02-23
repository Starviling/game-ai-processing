class Separation implements Movement {
  
  ArrayList<Boid> objects;
  
  float radius = 75f;
  float strength = 100000f;
  float maxLinear = 1000f;
  
  Separation(ArrayList<Boid> objects) {
    this.objects = objects;
  }
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = new SteeringOutput();
    
    for(Boid object : objects) {
      PVector direction = PVector.sub(character.position, object.getPosition());
      float distance = direction.mag();
      
      if(distance <= radius && distance > .0001) {
        // float force = strength / distance;  // Linear
        float force = strength / (distance * distance);  // Quadratic
        result.linear.add(direction.mult(force));
      }
    }
    
    if(result.linear.mag() > maxLinear) {
      result.linear.normalize();
      result.linear.mult(maxLinear);
    }
    
    return result;
  }
}

class Cohesion extends SteeringSeek {
   float neighborDist = 100f;
   ArrayList<Boid> objects;
  
   
   Cohesion(ArrayList<Boid> objects) {
     this.objects = objects;
   }
   
   SteeringOutput getSteering(Kinematic character) {
     SteeringOutput result = new SteeringOutput();
     PVector sum = new PVector(0, 0);
     for (Boid object : objects) {
       PVector direction = PVector.sub(character.position, object.getPosition());
       float distance = direction.mag();
       
       int count = 0;
       if ((distance > 0) && (distance < neighborDist)) {
         sum.add(object.getPosition());
         count++;
       }
       if (count > 0) {
         sum.div(count);
         Kinematic temp = new Kinematic();
         temp.position = sum;
         super.target = temp;
         return super.getSteering(character);
       }
     }
     return result;
   }
   
}

class SteeringVelocityMatch implements Movement {

  Kinematic target = null;
  
  float timeToTarget = 0.05f;
  float maxLinear = 500f;
  float neighborDist = 100f;
  ArrayList<Boid> objects;
  
   
  SteeringVelocityMatch(ArrayList<Boid> objects) {
    this.objects = objects;
  }
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = new SteeringOutput();

    int count = 0;

    for (Boid object : objects) {
      // Calculate for those within velocity matching range
      PVector direction = PVector.sub(character.position, object.getPosition());
      float distance = direction.mag();
      
      if ((distance > 0) && (distance < neighborDist)) {
        target = object.character;
        PVector objLin = PVector.sub(target.velocity, character.velocity);
        objLin.div(timeToTarget);
        
        if(objLin.mag() > maxLinear) {
          objLin.normalize();
          objLin.mult(maxLinear);
        }
        result.linear.add(objLin);
        count++;
      }
    }
    if (count != 0)
      result.linear.div(count);

    return result;
  }
}

class FlockMember extends SteeringLook {
  
  Separation separate;
  Cohesion cohesion;
  SteeringVelocityMatch velocityMatch;
  ArrayList<Boid> objects;
  
  
  float sepMult = 1f;
  float cohMult = 1f;
  float velMult = 1f;
  
  FlockMember(ArrayList<Boid> objects) {
    this.separate = new Separation(objects);
    this.cohesion = new Cohesion(objects);
    this.velocityMatch = new SteeringVelocityMatch(objects);
    this.objects = objects;
  }
  
  SteeringOutput getSteering(Kinematic character) {
    SteeringOutput result = super.getSteering(character);
    
    SteeringOutput sep = this.separate.getSteering(character);
    SteeringOutput coh = this.cohesion.getSteering(character);
    SteeringOutput vel = this.velocityMatch.getSteering(character);
    
    sep.linear.mult(sepMult);
    coh.linear.mult(cohMult);
    vel.linear.mult(velMult);
    
    result.linear = PVector.add(vel.linear, PVector.add(sep.linear, coh.linear));
    
    return result;
  }
}
