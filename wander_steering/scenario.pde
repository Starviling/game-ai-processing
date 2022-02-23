Boid singleB;
ArrayList<Boid> wanderList;
ArrayList<Boid> boidList;

int FRAME_RATE = 60;

// Set up stuff
void setup() {
  
  // Set frame rate
  frameRate(FRAME_RATE);
  boidList = new ArrayList<Boid>();
  
  // Basic motion implementation
  //firstBasicMotion();
  
  // Arrive behavior implementation
  //firstArrive();
  
  // Other Arrive behavior implementation
  //secondArrive();
  
  // Wander behavior implementation
  //firstWander();
  
  // Other Wander behavior implementation using face
  //secondWander();
  
  //Other Other Wander behavior implementation using look
  //thirdWander();

  // Flock behavior implementation
  // This is a boid with arrive implementation since the flock doesn't seem to follow the erratic wander very well
  flockCode();
  
}

public void firstBasicMotion() {
  singleB = new Boid(0, height, false);
  singleB.addMovement(new BasicMovement());
  boidList.add(singleB);
}

public void firstArrive() {
  singleB = new Boid(width/2, height/2, true);
  singleB.addMovement(new Arrive());
  singleB.addMovement(new SteeringFace());
  singleB.c = color(225,50,10,255);
  boidList.add(singleB);
}

public void secondArrive() {
  singleB = new Boid(width/2, height/2, true);
  singleB.addMovement(new KinematicArrive());
  //singleB.addMovement(new Arrive());
  //singleB.addMovement(new SteeringLook());
  singleB.c = color(10,10,10,100);
  boidList.add(singleB);
}

public void firstWander() {
  singleB = new Boid(width/2, height/2, true);
  singleB.addMovement(new Wander());
  singleB.addMovement(new SteeringLook());
  singleB.c = color(50, 150, 10, 100);
  boidList.add(singleB);
}

public void secondWander() {
  singleB = new Boid(width/2, height/2, true);
  singleB.addMovement(new WanderOther());
  singleB.c = color(50, 0, 10, 250);
  boidList.add(singleB);
}

public void thirdWander() {
  singleB = new Boid(width/2, height/2, true);
  singleB.addMovement(new WanderOtherLook());
  singleB.c = color(50, 150, 200, 150);
  boidList.add(singleB);
}

public void flockCode() {
  singleB = new Boid(width/2, height/2, true);
  singleB.addMovement(new Arrive());
  singleB.addMovement(new SteeringFace());
  singleB.maxSpeed = 75f;
  singleB.borderUse = 1;
  boidList.add(singleB);
  int boidLeaders = 1;
  int boidFollowers = boidLeaders * 3;
  for (int i = 0; i < boidFollowers; i++) {
    Boid followingBoid = new Boid(width/2, height/2, false);
    followingBoid.addMovement(new FlockMember(boidList));
    followingBoid.maxSpeed = 75f;
    followingBoid.borderUse = 1;
    boidList.add(followingBoid);
  }
  for (int i = 0; i < boidLeaders; i++) {
    Boid wanderingBoid = new Boid(width/2, height/2, true);
    wanderingBoid.c = color(100, 255, 255, 255);
    WanderOtherLook wanderBehavior = new WanderOtherLook();
    wanderBehavior.wanderOffset = 50f;
    wanderBehavior.wanderRadius = 25f;
    wanderingBoid.maxSpeed = 75f;
    wanderingBoid.addMovement(wanderBehavior);
    wanderingBoid.borderUse = 1;
    boidList.add(wanderingBoid);
  }
}

public void settings() {
  // Set the frame size
  size(980, 720);
  smooth(2);
}

// Draw stuff
void draw() {
  // Calculate the dt for usage
  
  // Fill the background
  float dt = 1.0f / (float) FRAME_RATE;
  background(255);
  
  for (Boid object : boidList) {
    object.run(dt);
  }
}
