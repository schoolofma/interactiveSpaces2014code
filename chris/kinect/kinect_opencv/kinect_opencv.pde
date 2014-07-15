import gab.opencv.*;
import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;
int kWidth  = 640;
int kHeight = 480;

PImage depthImg;
int minDepth =  60;
int maxDepth = 860;

OpenCV opencv;

void setup() {
  size(kWidth, kHeight);

  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);

  opencv = new OpenCV(this, 640, 480);

  depthImg = new PImage(kWidth, kHeight);
}

void draw() {
  
  // get array of all depth values
  int[] rawDepth = kinect.getRawDepth();
  
  // loop through each depth value and if it is within the threshold
  // set the depthImage pixel to white, if not to black
  for (int i=0; i < kWidth*kHeight; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
    } else {
      depthImg.pixels[i] = 0;
    }
  }

  opencv.loadImage(depthImg);
  opencv.erode();
  opencv.dilate();
  opencv.dilate();

  // draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, 0, 0);

  noFill();
  stroke(255, 0, 0);
  strokeWeight(3);
  /*
  // Another way to loop through contrours
  for (Contour contour : opencv.findContours ()) {
    contour.draw();
  }
  */
  
  ArrayList<Contour>contours = opencv.findContours(false,true);
  for (int i = 0; i < contours.size(); i++) {
      
      Contour contour = contours.get(i);
      contour.draw();
  }
  
  fill(0, 255, 255);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
  text("a/s: adjust minDepth, z/x: adjust maxDepth", 10, 56);
  //println(frameRate);
}

void keyPressed() {
  if (key == 'a') {
    minDepth+=2;
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

