static interface DecisionTreeNode {
   void evaluate(DecisionContext context);
}

class DecisionNode implements DecisionTreeNode {
  String attribute;
  HashMap<String, DecisionTreeNode> children;
  
  DecisionNode(String attribute) {
    this.attribute = attribute;
    children = new HashMap<String, DecisionTreeNode>();
  }
  
  void addChild(String value, DecisionTreeNode child) {
    children.put(value, child); 
  }
  
  void evaluate(DecisionContext context) {
    String value = context.getState().get(attribute); 
    children.get(value).evaluate(context);
  }
}

class ActionNode implements DecisionTreeNode {
  Action action;
  
  ActionNode(Action action) {
    this.action = action;
  }
  
  void evaluate(DecisionContext context) {
     context.sendAction(action); 
  }
}

void decisionTree() {
  ArrayList<Movement> chargeMove = new ArrayList<Movement>();
  ArrayList<Movement> slowMove = new ArrayList<Movement>();
  ArrayList<Movement> wanderMove = new ArrayList<Movement>();
  
  // This needs to be updated when following the player
  followMonsterSetup();
  
  // Look behavior used
  SteeringLook look = new SteeringLook();
  look.maxAngular = 10.0f * PI;
  look.maxRotation = 2.0 * PI;
  look.targetRadius = 0.0001f * PI;
  look.slowRadius = 0.2 * PI;
  look.timeToTarget = 0.25f;
  
  // Charge behavior
  chargeMove.add(followMonster);
  chargeMove.add(look);
  
  // Slow behavior
  slowMove.add(followMonsterSlow);
  slowMove.add(look);
  
  // Wander behavior
  wanderMove.add(new WanderOther(roomsGraph));
  wanderMove.add(look);
  
  Action charge = new Action( chargeMove, "charge" );
  Action slow = new Action( slowMove, "slow" );
  Action wander = new Action( wanderMove, "wander" );
  Action none = new Action(null, "none");
  
  // Nodes within the tree
  DecisionNode withinRange = new DecisionNode("withinRange");
  DecisionNode timeOutRange = new DecisionNode("timeOutRange");
  DecisionNode timeInRange = new DecisionNode("timeInRange");
  
  // Build the tree
  timeOutRange.addChild("True", new ActionNode(charge));
  timeOutRange.addChild("False", new ActionNode(wander));
  timeInRange.addChild("True", new ActionNode(charge));
  timeInRange.addChild("False", new ActionNode(slow));
  withinRange.addChild("True", timeInRange);
  withinRange.addChild("False", timeOutRange);
  
  decisionTree = withinRange;
}
