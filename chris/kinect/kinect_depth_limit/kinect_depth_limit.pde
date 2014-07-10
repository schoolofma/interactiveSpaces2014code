import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;
int kWidth  = 640;
int kHeight = 480;

PImage depthImg;
int minDepth =  60;
int maxDepth = 860;

void setup() {
  size(kWidth*2, kHeight);

  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);

  depthImg = new PImage(kWidth, kHeight);
}

void draw() {
  // draw the raw image
  image(kinect.getDepthImage(), 0, 0);

  // threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < kWidth*kHeight; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = 0xFFFFFFFF;
    } else {
      depthImg.pixels[i] = 0;
    }
  }

  // draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, kWidth, 0);

  fill(0, 255, 255);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
  text("a/s: adjust minDepth, z/x: adjust maxDepth", 10, 56);

}

void keyPressed() {
    if (key == 'a') {
      minDepth+=2;;
    } else if (key == 's') {
      minDepth-=2;
    } else if (key == 'z') {
      maxDepth+=2;
    } else if (key =='x') {
      maxDepth-=2;
    }
}

void stop() {
  kinect.quit();
  super.stop();
}

