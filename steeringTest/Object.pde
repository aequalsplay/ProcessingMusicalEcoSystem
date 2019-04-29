class Object {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector desired;
  float r;
  float mass;
  float health; 
  float maxforce;  
  float maxspeed;
  float xoff;       
  float yoff;
  
  DNA dna;
  
 Object(PVector l, DNA dna_) {
   r = 100; 
   mass = r;
   maxspeed = 2;
   maxforce = 1;
   position = l.copy();
   health = 200;
   dna = dna_;
   acceleration = new PVector(0, 0);
   velocity = new PVector(0, 0);
 }
 
 void applyForce(PVector force) {
   acceleration.add(force).div(mass);
 }
 
  void seek(ArrayList<Particle> particle) {
   
    float desiredseparation = r*2;
    PVector steer = new PVector();
    int count = 0;
    
    // For every boid in the system, check if it's too close
    for (Particle other : particle) {
      float d = PVector.dist(position, other.position);
      PVector desired = PVector.sub(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d > desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector steering = PVector.sub(desired, velocity);
        steering.normalize();
        steering.div(d);        // Weight by distance
        steer.sub(steering);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div(count);
      // Our desired vector is the average scaled to maximum speed
      steer.normalize();
      steer.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.sub(velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
    
  }
  
  
 
 void update() {
  velocity.add(acceleration);
  velocity.limit(maxspeed);
  position.add(velocity);
  acceleration.mult(0);
  
  //health -= 0.1;

  
  // Random Movement
  float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
  float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
  PVector noise = new PVector(vx,vy);
    xoff += 0.01;
    yoff += 0.01;
  applyForce(noise);
 }
 
 void display() {
  fill(map(health, 0, 1, 150, 255));
  stroke(255, health);
  pushMatrix();
  translate(position.x, position.y);
  ellipse(0, 0, r, r);
  popMatrix();
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

    force.normalize();
    force.mult(0.1);

    applyForce(force);
  }

   // Wraparound
  void borders() {
    if (position.x < 0) position.x = 0;
    if (position.y < 0) position.y = 0;
    if (position.x > width) position.x = width;
    if (position.y > height) position.y = height;
  }
  
  
  
  
  
 // // FOOD 
  
 //  // Get food
 //void eat(Food f) {
 //   ArrayList<PVector> food = f.getFood();
 //   // Are we touching any food objects?
 //   for (int i = food.size()-1; i >= 0; i--) {
 //     PVector foodposition = food.get(i);
 //     float d = PVector.dist(position, foodposition);
 //     // If we are, juice up our strength!
 //     if (d < r/2) {
 //       health += 100; 
 //       r+=10;
 //       food.remove(i);
 //     }
 //   }
 // }
  }
      
    
  
