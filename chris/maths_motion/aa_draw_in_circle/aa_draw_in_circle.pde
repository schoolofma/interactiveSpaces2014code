

void setup(){
  size(500,500);
}


void draw(){
     
    background(150);
    
    int radius = 100;
    int offX = width/2;
    int offY = height/2;
    
    for( int i = 0; i < 360; i+=10){
      float angle = radians(i);
      float x = offX + cos(angle)*radius;
      float y = offY + sin(angle)*radius;
      ellipse(x,y,10,10);
    }
}
