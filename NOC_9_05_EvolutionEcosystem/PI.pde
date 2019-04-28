class Pi {

  
// Global Variables for Steering
PVector position;
PVector velocity;
PVector acceleration;
float maxspeed;
float maxforce;
float r;
PVector desired;


// Global Variables for Pi
String pi;
int[] digits;
int[] counts = new int[10];
int index = 0;


// Constructor Function
  Pi(float x, float y) {
    
  // Physics Engine
  acceleration = new PVector(0,0);
  velocity = new PVector(0,0);
  position = new PVector(x,y);
  r = 3.0;
  maxspeed = 4;
  maxforce = 0.1;
  
  // Load Pi data
  pi = loadStrings("pi-1million.txt")[0];
  // Split values in .txt file into indidual strings in 'sdigits' array
  String[] sdigits = pi.split("");
  // Save strings as integers in 'digits' array
  digits = int(sdigits);
  
}

 // Apply forces 
 void applyForce(PVector force) {
     acceleration.add(force);
   }
 
 // Seek Bloops objects
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
  
 // Update Pi position 
 void update() {
   velocity.add(acceleration);
   velocity.limit(maxspeed);
   position.add(velocity);
   acceleration.mult(0);
  }
  
  
  // Draw Pi
 void piDraw() {
  
  
  translate(position.x, position.y);
  pushMatrix();
  stroke(255);
  noFill();
  ellipse(0,0,200,200);
  popMatrix();
  int digit = digits[index];
  int nextDigit = digits[index+1];
  index++;
  
  float diff = TWO_PI/10;
  
  float a1 = map(digit,0,10,0,TWO_PI) + random(-diff,diff);
  float a2 = map(nextDigit,0,10,0,TWO_PI) + random(-diff,diff);
  
  float x1 = 100 * cos(a1);
  float y1 = 100 * sin(a1);
  
  float x2 = 100 * cos(a2);
  float y2 = 100 * sin(a2);
  
  stroke(255,255);
  line(x1,y1,x2,y2);

} 
}
