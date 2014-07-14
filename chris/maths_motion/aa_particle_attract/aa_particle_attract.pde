ArrayList<Particle> particles;


void setup(){
  size(500,500);
  particles = new ArrayList();
}


void draw(){
  background(200);
  
  for(int i = 0; i < particles.size(); i++){
    Particle p = particles.get(i);
    
    float dist = dist(p.x,p.y,mouseX,mouseY);
    if( dist < 100 && dist > 10){
      float forceX = (mouseX-p.x)*.01;
      float forceY = (mouseY-p.y)*.01;
      p.applyForce(forceX,forceY);
    }
    p.update();
    p.draw();
  }
  
  
  // check offscreen
  for (int i = particles.size()-1; i >= 0; i--) {
     Particle p = particles.get(i);
     if( p.x < 0 || p.x > width || p.y < 0 || p.y > height){
       particles.remove(i);
     }
  }
  
  
  println("Total particles: " + particles.size());  
}

void keyPressed(){
  if( key == ' ' ){
    Particle p = new Particle();
    particles.add(p);
  }
  
}

class Particle{

    float x,y,velX,velY;
    float damp;
    
    Particle(){
      x = random(width);
      y = random(height);
      damp = .01;
    }
    
    void update(){
      x += velX;
      y += velY;
      velX += -velX*damp;
      velY += -velY*damp;
      
    }
    
    void draw(){
      ellipse(x,y,10,10);
    }
    
    void applyForce( float forceX, float forceY){
      velX += forceX;
      velY += forceY;
    }
    
    
}
