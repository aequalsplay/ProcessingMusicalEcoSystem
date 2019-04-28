class Bloop {
  
  // Steering global variables
   PVector position;
   PVector velocity;
   PVector acceleration;
   PVector desired;
   
  // DNA will determine size and maxspeed
   DNA dna;
   float r;
   float maxspeed;
   float maxforce;
   float health;    
   


  // OSC - global variables
  String oscAddr;
  float oscMsg;
  int count;
   
  // Constructor Function
  // Create a "bloop" creature
  Bloop(PVector l, DNA dna_) {
    
    // Physics Engine
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = l.copy();
    maxforce = 0.1; 
    health = 200;
    dna = dna_;
    
    r = map(dna.genes[0], 0, 1, 30, 70);
    maxspeed = map(dna.genes[0], 0, 1, 10, 0);
    
    
    
    
    count = floor(random(0, 7));
    oscAddr = "/freq" + str(count);
    
   //print(oscAddr);
  }
  
  
 
  void run() {
   
    update();
    borders();
    display();
   
  }

  // A bloop can find food and eat it
  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // Are we touching any food objects?
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodposition = food.get(i);
      float d = PVector.dist(position, foodposition);
      // If we are, juice up our strength!
      if (d < r/2) {
        health += 100; 
        r+=10;
        food.remove(i);
      }
      
    }
  }

  // At any moment there is a teeny, tiny chance a bloop will reproduce
  Bloop reproduce() {
    // asexual reproduction
    if (random(1) < 0.0007) {
      // Child is exact copy of single parent
      DNA childDNA = dna.copy();
      // Child DNA can mutate
      childDNA.mutate(0.01);
      osc();
      return new Bloop(position, childDNA);
      
    } 
    else {
      return null;
    }
  }

 // Apply forces 
 void applyForce(PVector force) {
     acceleration.add(force);
   }
 
 // Seek other bloop objects
void seek(ArrayList<Bloop> bloops) {
   for(Bloop other : bloops){
    desired = PVector.sub(other.position,position);
   }
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce); 
    applyForce(steer);
  }
  
 // Update Bloop position 
 void update() {
   velocity.add(acceleration);
   velocity.limit(maxspeed);
   position.add(velocity);
   acceleration.mult(0); 
      
    // Health decreeases without food
    health -= 0.2;
    
    oscMsg = map(noise(position.x), 0, 1, 200, 300);
    //print(oscMsg);
    
 
  }
  // Wraparound
  void borders() {
    if (position.x < 0) position.x = 0;
    if (position.y < 0) position.y = 0;
    if (position.x > width) position.x = width;
    if (position.y > height) position.y = height;
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    stroke(255,health);
    fill(255, health);
    ellipse(position.x, position.y, r, r);
   
  }

  // Death
  boolean dead() {
    if (health < 0.0) {
      return true;
    } 
    else {
      return false;
    }
    
    
  }
  
  
    // OSC STUFF  
    void osc(){
    
    // Frequency
    OscMessage oscStuff = new OscMessage(oscAddr);
    oscStuff.add(oscMsg);
    osc.send(oscStuff, supercollider);
    
    OscMessage oscBorn = new OscMessage("/born");
    oscBorn.add(1);
    osc.send(oscBorn, supercollider);
    }
  
  
  
}
