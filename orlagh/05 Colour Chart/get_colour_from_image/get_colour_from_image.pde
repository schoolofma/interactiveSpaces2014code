int x;
int y;

void setup(){
  size(720, 360);
// load image
PImage img = loadImage("evColour.jpg");

// get color from a certain pixel
int mycolor = img.get(700, 200);

fill(mycolor);
rect(0,0,width, height);
}
