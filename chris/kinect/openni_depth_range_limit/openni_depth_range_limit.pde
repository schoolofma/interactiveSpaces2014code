import SimpleOpenNI.*;
SimpleOpenNI  kinect;

PImage depthImage;

void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw()
{
  kinect.update();
  
  float closeLimit = map(mouseX,0,width,0,11*256);
  int[] depthValues = kinect.depthMap();
  depthImage = kinect.depthImage();
  for (int x = 0; x < 640; x++) {
    for (int y = 0; y < 480; y++) {
      int i = x + y * 640;
      int currentDepthValue = depthValues[i];
      if (currentDepthValue < 610 || currentDepthValue > closeLimit) {
        depthImage.pixels[i] = 0;
      }
    }
  }

  image(depthImage, 0, 0);
}

void mousePressed(){
  saveFrame("depth_limit"+random(1000)+".png");
}

