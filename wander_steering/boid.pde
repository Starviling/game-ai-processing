// The Boid class
class Boid {

  Kinematic character;
  ArrayList<Movement> controllers;
  float r;
  float maxSpeed = 250f;
  float drag = .0f;
  color c;
  float borderUse;
  boolean leader;
  boolean returnToField;
  SteeringSeek returnPoint;
  
  KinematicBreadcrumbs crumbs;

  Boid(float x, float y, boolean leader) {
    controllers = new ArrayList<Movement>();
    this.character = new Kinematic(new PVector(x, y), PI * 0.5f);
    this.crumbs = new KinematicBreadcrumbs(this);
    r = 20.0;
    c = color(255, 0, 255, 255);
    borderUse = 0;
    this.leader = leader;
    this.returnPoint = new SteeringSeek();
    this.returnPoint.target = new Kinematic(new PVector(width/2, height/2), 0);
  }
  
  void addMovement(Movement controller) {
     controllers.add(controller);
  }
  
  PVector getPosition() {
    return character.position; 
  }
  
  PVector getVelocity() {
     return character.velocity;
  }
  
  boolean isLeader() {
    return leader;
  }

  void run(float dt) {
    // Update Boid and Trail
    update(dt);
    crumbs.update(dt);
    if (borderUse == 0)
      borders();
    else if (borderUse == 1)
      otherBorder();
    
    // Render Boid and Trail
    crumbs.render();
    render();
  }

  // Method to update position
  void update(float dt) {
    SteeringOutput totalSteering = new SteeringOutput();
    if (!returnToField) {
      for(Movement controller : controllers) {
          SteeringOutput steering = controller.getSteering(character);
          
          if(null != steering) {
            totalSteering.linear.add(steering.linear);
            totalSteering.angular += steering.angular;
          }
      }
    } else {
      totalSteering = returnPoint.getSteering(character);
    }
    
    character.velocity.mult(1.0f - drag);
    character.rotation *= 1.0f - drag;
    
    character.velocity.add(PVector.mult(totalSteering.linear, dt));
    character.rotation += totalSteering.angular * dt;
    
    character.position.add(PVector.mult(character.velocity, dt));
    character.orientation += character.rotation * dt;
    
    if(character.velocity.mag() > maxSpeed)
       character.velocity.normalize().mult(maxSpeed); 
      
    if (PI < character.orientation)
      character.orientation -= TWO_PI;
    else if (-PI > character.orientation)
      character.orientation += TWO_PI;
  }

  void render() {
    // Draw the boid
    fill(c);
    stroke(255);
    pushMatrix();
    translate(character.position.x, character.position.y);
    rotate(radians(90) - character.orientation);
    beginShape(TRIANGLES);
    vertex(0, -r*3);
    vertex(-r, 0);
    vertex(r, 0);
    endShape();
    circle(0, 0, r*2);
    //ellipse(0, r*2, r*2, r*2);
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (character.position.x < -r) character.position.x = width+r;
    if (character.position.y < -r) character.position.y = height+r;
    if (character.position.x > width+r) character.position.x = -r;
    if (character.position.y > height+r) character.position.y = -r;
  }
  
  void otherBorder() {
    //if (character.position.x < 0) {
    //  character.position.x = 0;
    //  character.velocity.x = -character.velocity.x;
    //  character.orientation = PI - character.orientation;

    //}
    //if (character.position.y < 0) {
    //  character.position.y = 0;
    //  character.velocity.y = -character.velocity.y;
    //  character.orientation = PI - character.orientation;
    //}
    //if (character.position.x > width) {
    //  character.position.x = width;
    //  character.velocity.x = -character.velocity.x;
    //  character.orientation = PI - character.orientation;
    //}
    //if (character.position.y > height) {
    //  character.position.y = height;
    //  character.velocity.y = -character.velocity.y;
    //  character.orientation = PI - character.orientation;
    //}
    float heightIn = height * 0.15;
    float widthIn = width * 0.15;
    if (character.position.x < widthIn || character.position.y < heightIn || character.position.x > width - widthIn || character.position.y > height - heightIn) {
      returnToField = true;
    } else {
      returnToField = false;
    }
    
  }
}
