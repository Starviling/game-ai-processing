import java.util.HashSet;
import java.util.Set;

class GameState {
  HashMap<String, String> data;
  
  GameState() {
    data = new HashMap<String, String>();
  }
  
  void add(String key, String value) {
    data.put(key, value);
  }
  
  String get(String key) {
    return data.get(key); 
  }
}

class GameSpec {
  HashMap<String, HashSet<String>> attributes;
  HashMap<String, Action> actions;
  
  GameSpec() {
    attributes = new HashMap<String, HashSet<String>>(); 
    actions = new HashMap<String, Action>();
  }
  
  void addAttribute(String key, String value) {
    if(!attributes.containsKey(key))
      attributes.put(key, new HashSet<String>());
    
    attributes.get(key).add(value);
  }
  
  void addAction(Action action) {
    actions.put(action.id, action); 
  }
  
  Set<String> getAttributes() {
    return attributes.keySet(); 
  }
  
  Set<String> getValues(String key) {
    return attributes.get(key); 
  }
  
  Set<String> getActionIds() {
    return actions.keySet(); 
  }
  
  Action getAction(String id) {
    return actions.get(id); 
  }
}

class Action {
  ArrayList<Movement> movement;
  String id;
  
  Action(ArrayList<Movement> movement, String id) {
    this.movement = movement;
    this.id = id;
  }
  
  ArrayList<Movement> getMovement() {
    return movement;
  }
  
  String getId() {
    return id; 
  }
}

// Context for executing behavior tree
class DecisionContext {
  Boid boid;
  GameState state;
  
  DecisionContext(Boid boid, GameState state) {
    this.boid = boid;
    this.state = state;
  }
  
  GameState getState() {
    return state; 
  }
  
  void sendAction(Action action) {
    ArrayList<Movement> movement = action.getMovement(); 
    if(null != movement)
      boid.controllers = movement; 
  }
}
