void setup() {
  size(600, 600);
  noStroke();
}
void draw() {
  background(#223388);
  for (float x=0; x<width; x += 10) {
    float verticalPosition = frameCount % height;
    if(random(100) < 1) {
      fill(255);
    } else {
      fill(x, 0, 0);
    }
    rect(x, verticalPosition, 20, x / 5);
  }
  //if(frameCount > 50) {
  //  noLoop();
  //}
}
