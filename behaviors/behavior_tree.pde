static enum Status {
  FAIL, SUCCEED, RUNNING
}

static interface BehaviorTreeNode {
  Status run(DecisionContext context); 
}

class Selector implements BehaviorTreeNode {
  ArrayList<BehaviorTreeNode> children;
  
  Selector() {
    children = new ArrayList<BehaviorTreeNode>(); 
  }
  
  void addChild(BehaviorTreeNode child) {
    children.add(child); 
  }
  
  Status run(DecisionContext context) {
    for(BehaviorTreeNode child : children) {
      Status status = child.run(context);
      
      if(status == Status.SUCCEED || status == Status.RUNNING)
        return status;
    }
    
    return Status.FAIL;
  }
}

class Sequence implements BehaviorTreeNode {
  ArrayList<BehaviorTreeNode> children;
  
  Sequence() {
    children = new ArrayList<BehaviorTreeNode>(); 
  }
  
  void addChild(BehaviorTreeNode child) {
    children.add(child); 
  }
  
  Status run(DecisionContext context) {
    for(BehaviorTreeNode child : children) {
      Status status = child.run(context);
      
      if(status == Status.FAIL || status == Status.RUNNING)
        return status;
    }
    
    return Status.SUCCEED;
  }
}

class RandomNode implements BehaviorTreeNode {
  ArrayList<BehaviorTreeNode> children;
  
  RandomNode() {
    children = new ArrayList<BehaviorTreeNode>(); 
  }
  
  void addChild(BehaviorTreeNode child) {
    children.add(child); 
  }
  
  Status run(DecisionContext context) {
    BehaviorTreeNode selected = children.get((int) random(children.size()));    
    selected.run(context);
    return Status.SUCCEED;

  }
}

class Inverter implements BehaviorTreeNode {
  BehaviorTreeNode child;
  
  Inverter(BehaviorTreeNode child) {
    this.child = child; 
  }
  
  Status run(DecisionContext context) {
    switch(child.run(context)){
      case FAIL: return Status.SUCCEED;
      case SUCCEED: return Status.FAIL;
      default: return Status.RUNNING;
    }
  }
}

class Condition implements BehaviorTreeNode {
  String attribute;
  String value;
  
  Condition(String attribute, String value) {
    this.attribute = attribute;
    this.value = value;
  }
  
  Status run(DecisionContext context) {
    if(context.getState().get(attribute) == value)
      return Status.SUCCEED;
    else
      return Status.FAIL;
  }
}


class Behavior implements BehaviorTreeNode {
  Action action;
  
  Behavior(Action action) {
    this.action = action; 
  }
  
  Status run(DecisionContext context) {
    context.sendAction(action);
    actionsTaken.add(action);
    return Status.RUNNING;
  }
}

void behaviorTree() {
  // For the machine learning to imitate
  output = createWriter(fileData);
  actionsTaken = new ArrayList<Action>();
  
  ArrayList<Movement> chargeMove = new ArrayList<Movement>();
  ArrayList<Movement> slowMove = new ArrayList<Movement>();
  ArrayList<Movement> wanderMove = new ArrayList<Movement>();
  ArrayList<Movement> normalLook = new ArrayList<Movement>();
  
  // This needs to be updated when following the player
  followMonsterSetup();
  
  // Look behavior used
  SteeringLook look = new SteeringLook();
  look.maxAngular = 10.0f * PI;
  look.maxRotation = 2.0 * PI;
  look.targetRadius = 0.0001f * PI;
  look.slowRadius = 0.2 * PI;
  look.timeToTarget = 0.25f;
  normalLook.add(look);
  
  // Charge behavior
  chargeMove.add(followMonster);
  //chargeMove.add(look);
  
  // Slow behavior
  slowMove.add(followMonsterSlow);
  //slowMove.add(look);
  
  // Wander behavior
  wanderMove.add(new WanderOther(roomsGraph));
  //wanderMove.add(look);
  
  Action charge = new Action( chargeMove, "charge" );
  Action slow = new Action( slowMove, "slow" );
  Action wander = new Action( wanderMove, "wander" );
  Action lookMethod = new Action(normalLook, "look" );
  Action none = new Action(null, "none");
  
  // Behavior tree building
  Selector movementSelector = new Selector();
  Selector inRadiusSelector = new Selector();
  Selector outRadiusSelector = new Selector();
  Sequence rootSequence = new Sequence();
  Sequence rangeSequence = new Sequence();
  Sequence timeInRangeSequence = new Sequence();
  Sequence outRadiusSequence = new Sequence();
  RandomNode lookRandom = new RandomNode();
  
  timeInRangeSequence.addChild(new Condition("timeInRange", "True"));
  timeInRangeSequence.addChild(new Behavior(charge));
  
  inRadiusSelector.addChild(timeInRangeSequence);
  inRadiusSelector.addChild(new Behavior(slow));
  
  rangeSequence.addChild(new Condition("withinRange", "True"));
  rangeSequence.addChild(inRadiusSelector);
  
  outRadiusSequence.addChild(new Condition("timeOutRange", "True"));
  outRadiusSequence.addChild(new Behavior(charge));
  
  outRadiusSelector.addChild(outRadiusSequence);
  outRadiusSelector.addChild(new Behavior(wander));
  
  movementSelector.addChild(rangeSequence);
  movementSelector.addChild(outRadiusSelector);
  movementSelector.addChild(new Behavior(none));
 
  lookRandom.addChild(new Behavior(lookMethod));
  lookRandom.addChild(new Behavior(none));
  
  rootSequence.addChild(lookRandom);
  rootSequence.addChild(movementSelector);
  
  behaviorTree = rootSequence;
}
