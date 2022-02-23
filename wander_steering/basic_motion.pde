// Seeks using kinematic seek
class BasicMovement implements Movement {
   
  ArrayDeque<Kinematic> targets = new ArrayDeque<Kinematic>();
  float maxSpeed = 200f;
  float smoothing = .25f;
  
  float heightIn = height * 0.25;
  float widthIn = width * 0.25;
  
  BasicMovement() {
    targets.add(new Kinematic(new PVector(widthIn, height - heightIn), .0f));
    targets.add(new Kinematic(new PVector(width - widthIn, height - heightIn), .0f));
    targets.add(new Kinematic(new PVector(width - widthIn, heightIn), .0f));
    targets.add(new Kinematic(new PVector(widthIn, heightIn), .0f));
  }
  
  SteeringOutput getSteering(Kinematic character) {
    float distance = PVector.sub(targets.peek().position, character.position).mag();
    if (distance < 5) {
      println(distance);
      targets.add(targets.remove());
    }
    
    SteeringOutput result = new SteeringOutput();
    //result.linear = PVector.sub(targets.peek().position, character.position);
    //result.linear.normalize().mult(maxSpeed);
    character.velocity = PVector.sub(targets.peek().position, character.position);
    character.velocity.normalize().mult(maxSpeed);
    character.orientation = getNewOrientation(character.orientation, character.velocity, smoothing);
    
    return result;
  }
}
