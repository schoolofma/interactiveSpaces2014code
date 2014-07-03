String category = "people";
int x, y;
void setup() {
  size(600, 600);
  x = 0;
  y = 0;
}
void draw() {
  println("LOAD", frameCount);
  
  PImage myImage = loadImage("http://lorempixel.com/400/400/" + 
    category +"/#.jpg"); 
  image(myImage, x, y, 100, 100);
  frameRate(1);
  
  x += 100;
  if(x >= width) {
    x = 0;
    y += 100;
    if(y >= height) {
      y = 0;
      }
    }
  }
