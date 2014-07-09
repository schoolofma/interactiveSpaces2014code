// Kurt was interested in drawing shapes that
// alternate color move between two points.
// This example is for him.
void setup() {
  size(600,600);
  float startx = random(width);
  float starty = random(height);
  float endx = random(width);
  float endy = random(height);

  fill(#FF0000);
  ellipse(startx, starty, 20, 20);
  
  fill(#00FF00);
  ellipse(endx, endy, 20, 20);

  for(float i=0; i<1; i+=0.1) {
    println(i);
    float currentx = lerp(startx, endx, i);
    float currenty = lerp(starty, endy, i);
    fill(0, 20);
    ellipse(currentx, currenty, 5, 5);
  }  
}
