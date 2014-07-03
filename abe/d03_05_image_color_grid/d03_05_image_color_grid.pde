String category = "people";
void setup() {
  size(600, 600);
}
void draw() {
  int x = 100 * (int)random(6);
  int y = 100 * (int)random(6);
  if(random(100) < 90) {
    fill(random(255), random(255), random(255));
    rect(x, y, 100, 100);
  } else {
    PImage myImage = loadImage("http://lorempixel.com/400/400/" + category +"/#.jpg"); 
    image(myImage, x, y, 100, 100);
  }
  frameRate(10);
}
