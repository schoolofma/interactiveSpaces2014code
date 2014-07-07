import codeanticode.protablet.*;

Tablet myTablet;

void setup() {
  size(600, 600);
  
  myTablet = new Tablet(this);
}

void draw() {
  background(255 * myTablet.getPressure());
}

