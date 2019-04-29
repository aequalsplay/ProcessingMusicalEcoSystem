class World {
 
    
  ArrayList<Particle> particles;
  ArrayList<Object> objects;
  Food food;
  
  World(int num) {
    
    particles = new ArrayList<Particle>();
    objects = new ArrayList<Object>();
    PVector l = new PVector(random(width),random(height));
        objects.add(new Object(l,dna));
    
    for (int i = 0; i < num; i++) {
      DNA dna = new DNA();
      food = new Food(num);
     particles.add(new Particle(l,dna)); 
        
    }
  }
    
    // Make a new creature
  void born(float x, float y) {
    PVector l = new PVector(x,y);
    DNA dna = new DNA();
    particles.add(new Particle(l,dna));
    
  }

void run() {
  
  food.run();
  
  for (int i = objects.size()-1; i >= 0; i--) {
     
      Object o = objects.get(i);
         o.update();
         o.display();
         o.boundaries();
         o.borders();
         o.seek(particles);
         //o.eat(food);
         
  
  for (int j = particles.size()-1; j >= 0; j--) {
     
      Particle p = particles.get(j);
         p.update();
         p.display();
         p.boundaries();
         p.borders();
         p.separate(objects);
         p.eat(food);
         p.separateP(particles);
         
         
         
      
      if(particles.size() > 60) {
        particles.remove(j);
        food.add(p.position);
      }
      
       // If 0 Bloops, make 6 more.
      if(particles.size() <= 0){
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
         born(random(width), random(height));
      }
      
      Particle child = p.reproduce();
      if (child != null) particles.add(child);
      
      if (p.dead()) {
        particles.remove(j);
        food.add(p.position);
      }
}
}
}
}
