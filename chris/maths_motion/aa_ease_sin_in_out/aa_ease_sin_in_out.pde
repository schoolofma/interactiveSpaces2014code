float counter = 0;
float step = .01;
float startX = 10;
float startY = 10;
float endX = 100.0;
float endY = 100.0;
float x = startX;
float y = startY;

void setup(){
  size(500,500);
}


void draw(){
  
  counter += step;
  counter = constrain(counter,0,1);
  
  float amt = (sin(counter*PI-HALF_PI)+1)*.5;
  //float amt = 1 - (cos(counter*PI)+1)*.5; // same as above

  x = lerp(startX,endX,amt);
  y = lerp(startY,endY,amt);
  
  
  background(255);
  ellipse(x,y,20,20);

}


void mousePressed(){
  startX = x;
  startY = y;
  endX = mouseX;
  endY = mouseY;
  counter = 0;
}

