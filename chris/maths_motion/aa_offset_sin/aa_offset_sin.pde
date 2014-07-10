float offSetY = 0;
float counter = 0;

void setup(){
  size(500,500);
}

void draw(){
  background(150);
  offSetY = sin(counter);
  ellipse(width/2,height/2+(offSetY*100),50,50);
  counter += .1;
}


