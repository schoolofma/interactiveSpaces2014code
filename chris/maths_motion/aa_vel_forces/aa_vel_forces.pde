float x = 0;
float y = 0;
float velX = 0;
float velY = 0;
float damp = .01;

void setup(){
  size(500,500);

}

void draw(){
  background(200);
  
  // add velocity to position
  y += velY;
  x += velX;
  
  // add friction to velocity
  velX += -velX*damp;
  velY += -velY*damp;
  
  ellipse(x,y,20,20);
}

void keyPressed(){
  
  float force = 2;
  
  if (key == CODED) {
    
    if (keyCode == UP){ velY -= force;
    }else if(keyCode == DOWN){ velY += force;
    }else if(keyCode == LEFT){ velX -= force;
    }else if(keyCode == RIGHT){ velX += force;
    }
    
  } 
  
}

void mousePressed(){

  x = mouseX;
  y = mouseY;
  velX = 0;
  velY = 0;
}

