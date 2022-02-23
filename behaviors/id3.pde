class DataSet {
  ArrayList<GameState> instances;
  ArrayList<Action> labels;
  
  DataSet() {
    instances = new ArrayList<GameState>();
    labels = new ArrayList<Action>();
  }
  
  void add(GameState instance, Action label) {
     instances.add(instance);
     labels.add(label);
  }
  
  int size() {
    return instances.size(); 
  }
  
  GameState getInstance(int index) {
    return instances.get(index); 
  }
  
  Action getLabel(int index) {
    return labels.get(index);
  }
}


double entropy(DataSet data, GameSpec spec) {
  
  // Compute empirical distribution
  ArrayList<String> actions = new ArrayList<String>(spec.getActionIds());
  float[] distribution = new float[actions.size()];
  
  
  for(int i=0; i < distribution.length; ++i) {
     String action = actions.get(i);
     
     for(int j=0; j < data.size(); ++j)
       if(data.getLabel(j).getId() == action)
         distribution[i] += 1;
     
     distribution[i] /= (float) data.size();
  }
  
  // Compute entropy
  float entropy = 0.0f;
  
  for(int i=0; i < distribution.length; ++i)
    // This log calculation will cause imprescision, but is accurate enough for the purposes of this project
    // log calculates e^x in processing
    if(distribution[i] > 0.0f && distribution[i] < 1.0f)
      entropy -= distribution[i] * log(distribution[i])/log(2);
  
  return entropy;
}


float informationGain(String attribute, DataSet data, GameSpec spec) {
  float gain = 0.0f;
  
  for(String value : spec.getValues(attribute)) {
    DataSet subset = new DataSet();
    
    for(int i=0; i < data.size(); ++i) {
      GameState state = data.getInstance(i);
      
      if(state.get(attribute) == value)
        subset.add(state, data.getLabel(i));
    }
    
    if(subset.size() > 0)
      gain -= subset.size() * entropy(subset, spec);
  }
  
  return gain;
}


DecisionTreeNode id3(DataSet data, GameSpec spec) {
  return id3(data, spec, new HashSet<String>());
}


DecisionTreeNode id3(DataSet data, GameSpec spec, HashSet<String> used) {
  
  // Compute most common action
  String bestAction = null;
  int maxCount = 0;
  
  
  ArrayList<String> actions = new ArrayList<String>(spec.getActionIds());
  int[] counts = new int[actions.size()];
  
  for(String action : spec.getActionIds()) {
    int count = 0;
    
    for(int i=0; i < data.size(); ++i)
      if(data.getLabel(i).getId() == action)
        count += 1;
    
    if(count > maxCount) {
      bestAction = action;
      maxCount = count;
    }
  }
  
  // Test if all actions are the same, or we have run out of attributes
  if(used.size() >= spec.getAttributes().size() || data.size() == maxCount)
    return new ActionNode(spec.getAction(bestAction));
  
  // Evaluate attribute splits
  String bestAttribute = null;
  float maxInfoGain = Float.NEGATIVE_INFINITY;
  
  for(String attribute : spec.getAttributes()) {
    if(!used.contains(attribute)) {
      float infoGain = informationGain(attribute, data, spec);
    
      if(infoGain >= maxInfoGain) {
        bestAttribute = attribute;
        maxInfoGain = infoGain;
      }
    }
  }
  
  // Generate subtrees
  DecisionNode node = new DecisionNode(bestAttribute);
  
  used = new HashSet(used);
  used.add(bestAttribute);
  
  for(String value : spec.getValues(bestAttribute)) {
    DataSet subset = new DataSet();
    
    for(int i=0; i < data.size(); ++i) {
      GameState state = data.getInstance(i);
      
      if(state.get(bestAttribute).equals(value))
        subset.add(state, data.getLabel(i));
    }
    
    if(subset.size() > 0)
      node.addChild(value, id3(subset, spec, used));
    else
      node.addChild(value, new ActionNode(spec.getAction(bestAction)));
  }
  
  return node;
}

// Test method to see what the nodes in a tree is
void printNode (DecisionNode node) {
  System.out.println(node.attribute + ": " + node.children.values().size());
  for (DecisionTreeNode child : node.children.values()) {
    if (child instanceof DecisionNode) {
      printNode((DecisionNode) child);
    } else {
      System.out.println(((ActionNode) child).action.getId());
    }
  }
}

void treeLearning() {
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
  
  GameSpec spec = new GameSpec();
  spec.addAction(new Action(wanderMove, "wander"));
  spec.addAction(new Action(chargeMove, "charge"));
  spec.addAction(new Action(slowMove, "slow"));
  
  spec.addAttribute("timeInRange", "True");
  spec.addAttribute("timeInRange", "False");
  spec.addAttribute("timeOutRange", "True");
  spec.addAttribute("timeOutRange", "False");
  spec.addAttribute("withinRange", "True");
  spec.addAttribute("withinRange", "False");
  
  // Open the file from the createWriter() example
  BufferedReader reader = createReader(fileData);
  String line = null;
  DataSet data = new DataSet();
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, " ");
      String[] states = split(pieces[0], ",");
      String[] actions = split (pieces[1], ",");
      GameState behaviorState = new GameState();
      for (String state : states) {
        String[] chunk = split(state, "_");
        behaviorState.add(chunk[0], chunk[1]);
      }
      
      // To simplify the the program, the only action that can be taken will be in relation to moving, not orientation
      data.add(behaviorState, spec.getAction(actions[1]));
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  decisionTree = id3(data, spec);
} 
