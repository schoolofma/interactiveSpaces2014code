void setup() {
  size(600, 600);
}
void draw() {
  background(255);
  rect(300, 600 * noise(frameCount * 0.01), 60, 60);
  rect(450, 600 * noise(frameCount * 0.01, 0.2), 60, 60);
}
