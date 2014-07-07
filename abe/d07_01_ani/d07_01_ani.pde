import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

float x = 200;
float y = 200;

void setup() {
  size(400, 400);
  
  Ani.init(this);
}

void draw() {
  background(0);
  ellipse(x, y, 20, 20);
}

void mousePressed() {
  Ani.to(this, 2, "x", mouseX, Ani.BOUNCE_OUT);
  Ani.to(this, 2, "y", mouseY, Ani.BOUNCE_OUT);
}
