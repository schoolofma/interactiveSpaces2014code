void setup() {
}

void draw() {
  background(0);
  
  if(millis() < 1000) {
    rect(20,20,20,20);
  } else if( millis() < 2000) {
    ellipse(20,20,20,20);
  } else {
    background(255);
  }
}
