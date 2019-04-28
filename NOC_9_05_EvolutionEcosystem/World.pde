PVector bloopLocation;
int counter = 0;
ArrayList<Bloop> bloops;


class World {

  ArrayList<Bloop> bloops;    // An arraylist for all the creatures
  Food food;

  // Constructor
  World(int num) {
    // Start with initial food and creatures
    food = new Food(num);
    bloops = new ArrayList<Bloop>();              // Initialize the arraylist
    for (int i = 0; i < num; i++) {
      PVector l = new PVector(random(width),random(height));
      DNA dna = new DNA();
      bloops.add(new Bloop(l,dna));
      
    }
    
  }

  // Make a new creature
  void born(float x, float y) {
    PVector l = new PVector(x,y);
    DNA dna = new DNA();
    bloops.add(new Bloop(l,dna));
  
    bloopLocation = l.copy();
  }

  // Run the world
  void run() {
    // Deal with food
    food.run();
   
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = bloops.size()-1; i >= 0; i--) {
      // All bloops run and eat
      Bloop b = bloops.get(i);
      
      b.run();
      b.eat(food);
      // If it's dead, kill it and make food
      if (b.dead()) {
        bloops.remove(i);
        food.add(b.position);
      }
     
       pi.seek(bloops);
       b.seek(bloops);
       
      
     // If 0 Bloops, make 6 more.
      if(bloops.size() == 0){
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
      }
      // Reproduce?
      Bloop child = b.reproduce();
      if (child != null) bloops.add(child);
      
      
 
    }
    
    
    
  }
}
