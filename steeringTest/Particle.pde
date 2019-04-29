class Particle {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float mass;
  float maxforce;  
  float maxspeed;
  float health; 
  float xoff;       
  float yoff;
  
  String oscAddr;
  float oscMsg;

  
  DNA dna;
  
 Particle(PVector l, DNA dna_) {
   r = random(40, 80); 
   mass = r;
   maxspeed = 3;
   maxforce = 20;
   position = l.copy();
   dna = dna_;
   health = 200;
   acceleration = new PVector(0, 0);
   velocity = new PVector(0, 0);
   // OSC Address
   float count = floor(random(0,7));
   oscAddr = "/freq" + str(count);
   print(oscAddr);
 }
 
 void applyForce(PVector force) {
   acceleration.add(force).div(mass);
 }
 
  
 void separateP(ArrayList<Particle> particle){
  float desiredSeparation = r *2 ;
  PVector sum = new PVector();
  int count = 0;
  for(Particle other : particle) {
   float d = PVector.dist(position, other.position);
   if((d > 0) && (d < desiredSeparation)) {
     PVector diff = PVector.sub(position, other.position);
     diff.normalize();
     diff.div(d);
     sum.add(diff);
     count++;
   }
  }
  if( count > 0) {
   sum.setMag(maxspeed);
   PVector steer = PVector.sub(sum, velocity);
   steer.mult(5);
   applyForce(steer);
  }
 }

 
 void separate(ArrayList<Object> object){
  float desiredSeparation = r * 4;
  PVector sum = new PVector();
  int count = 0;
  for(Object o : object) {
   float d = PVector.dist(position, o.position);
   if((d > 0) && (d < desiredSeparation)) {
     PVector diff = PVector.sub(position, o.position);
     diff.normalize();
     diff.div(d);
     sum.add(diff);
     count++;
   }
  }
  if( count > 0) {
   sum.setMag(maxspeed);
   PVector steer = PVector.sub(sum, velocity);
   steer.mult(20);
   applyForce(steer);
  }
 }
 
 void update() {
  velocity.add(acceleration);
  velocity.limit(maxspeed);
  position.add(velocity);
  acceleration.mult(0);
  // Health decreases every frame
  health -= 0.05;
  
  // OSC Messages
  oscMsg = map(noise(position.x), 0, 1, 200, 300);
  
  // Random Movement
  float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
  float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
  PVector noise = new PVector(vx,vy);
    xoff += 0.01;
    yoff += 0.01;
  applyForce(noise);
 }
 
 void display() {
  noFill();
  stroke(255, health);
  pushMatrix();
  translate(position.x, position.y);
  ellipse(0, 0, r, r);
  popMatrix();
 }
 
  // Death
  boolean dead() {
    if (health <= 0) {
      return true;
    } 
    else {
      return false;
    }
  }
  
   // Reproduce
  Particle reproduce() {
    fill(255);
    // asexual reproduction
    if (random(1) < 0.0002) {
      // Child is exact copy of single parent
      DNA childDNA = dna.copy();
      // Child DNA can mutate
      childDNA.mutate(0.1);
      osc();
      return new Particle(position, childDNA);
      
    } 
    else {
      return null;
    }
  }
    
    
  // Boundaries
  void boundaries() {

    float d = 100;

    PVector force = new PVector(0, 0);

    if (position.x < d) {
      force.x = 1;
    } 
    else if (position.x > width -d) {
      force.x = -1;
    } 

    if (position.y < d) {
      force.y = 1;
    } 
    else if (position.y > height-d) {
      force.y = -1;
    } 

    force.setMag(4);

    applyForce(force);
  }
  
   // Wraparound
  void borders() {
    if (position.x < 0) position.x = 0;
    if (position.y < 0) position.y = 0;
    if (position.x > width) position.x = width;
    if (position.y > height) position.y = height;
  }
  
  
  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // Are we touching any food objects?
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodposition = food.get(i);
      float d = PVector.dist(position, foodposition);
      // If we are, juice up our strength!
      if (d < r/2) {
        health += 100; 
        r += 10;
        food.remove(i);
      }
    }
  }
  
   // OSC STUFF  
    void osc(){
    
    // Frequency
    OscMessage oscStuff = new OscMessage(oscAddr);
    oscStuff.add(oscMsg);
    osc.send(oscStuff, supercollider);
    
    OscMessage oscBorn = new OscMessage("/born");
    oscBorn.add(oscMsg);
    osc.send(oscBorn, supercollider);
    }
 
  }
  
