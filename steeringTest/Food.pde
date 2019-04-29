// The Nature of Code
class Food {
  ArrayList<PVector> food;

 
  Food(int num) {
    // Start with some food
    food = new ArrayList();
    for (int i = 0; i < num; i++) {
       food.add(new PVector(random(width),random(height))); 
    }
   
  } 
  
  // Add some food at a position
  void add(PVector l) {
     food.add(l.copy()); 
  }
  
  // Display the food
  void run() {
    for (PVector f : food) {
       rectMode(CENTER);
       stroke(0);
       fill(175);
       rect(f.x,f.y,12,12);
    } 
    
    // There's a small chance food will appear randomly
    if (random(1) < 0.0001) {
       food.add(new PVector(random(width),random(height))); 
    }
    
    
    
  }
  
  // Return the list of food
  ArrayList getFood() {
    return food; 
  }
}
