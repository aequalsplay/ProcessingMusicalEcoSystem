import netP5.*;
import oscP5.*;
OscP5 osc;
NetAddress supercollider; 

World world;
Pi pi;
PVector steer;

void setup() {
  
  // OSC SETUP
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
  
  // SKETCH SETUP  
  fullScreen(P2D);
  
  
  // WORLD SETUP
  // World starts with n creatures
  int n = 16;
  world = new World(n);
  pi = new Pi(random(width), random(height));
  smooth();
}

void draw() {
  background(0);
  world.run();
  pushMatrix();
  stroke(255);
  strokeWeight(2);
  popMatrix();
  //print(frameRate);
 
 pi.update();
       pi.piDraw();
}

// We can add a creature manually if we so desire
//void mousePressed() {
//  world.born(mouseX,mouseY); 
//}

//void mouseDragged() {
//  world.born(mouseX,mouseY);
//}
