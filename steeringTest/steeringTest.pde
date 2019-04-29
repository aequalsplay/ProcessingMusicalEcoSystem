import netP5.*;
import oscP5.*;
OscP5 osc;
NetAddress supercollider; 
 
 
 
 DNA dna;
 Object o;
 Particle p;
 World world;
 
void setup() {
  fullScreen(P2D);
  
   // OSC SETUP
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
  
  int n = 20;
  world = new World(n);
 
}


void draw() {
  background(0);
  world.run();
   
}
