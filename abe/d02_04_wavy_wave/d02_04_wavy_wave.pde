void setup() {
  size(600, 600);
}
void draw() {
  background(255);
  // for each animation frame we draw 600 points
  for (float x=0; x< width; x++) {
    // noise always returns a number between 0 and 1
    // that's why we multiply it by 600
    point(x, 600 * noise(x * 0.003, frameCount * 0.1));
  }
}
