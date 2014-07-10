float x;
float y;

void setup(){
  size(500,500);
  x = width/2;
  y = height/2;
}

void draw(){
  background(150);
  
  float angle = atan2(mouseY-y,mouseX-x);

  rectMode(CENTER);
  pushMatrix();
    translate(x,y);
    rotate(angle);
    rect(0,0,100,100);
  popMatrix();
  
   pushMatrix();
    translate(x,y);
    ellipse(50*cos(angle),50*sin(angle),10,10);
  popMatrix();
  
}


