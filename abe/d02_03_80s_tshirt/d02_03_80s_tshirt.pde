float x0, y0, x1, y1;
void setup() {
  size(600, 600);
  
  x0 = 0;
  x1 = 0;
  y0 = 0;
  y1 = 0;
  strokeWeight(5);
}
void draw() {
  stroke(frameCount % 255);
  line(x0, y0, x1, y1);
  
  x0 = (x0 + 5) % width;
  x1 = (x1 + 7) % width;
  y0 = (y0 + 9) % height;
  y1 = (y1 + 11) % height;
}
void keyPressed() {
  if(key == 's') {
    saveFrame("awesome.png");
  }
}
