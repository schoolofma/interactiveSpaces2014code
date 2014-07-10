import processing.video.*;

import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Rectangle[] faces;

// add camera object
Capture cam;

void setup() {
  
  // setup camera
  cam = new Capture(this,640,480);
  cam.start();
  
  opencv = new OpenCV(this,640,480);
  size(opencv.width, opencv.height);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void draw() {
  
  // load camera image
  if(cam.available()){
    cam.read();
  }
  opencv.loadImage(cam);
  opencv.flip(1);
  
  faces = opencv.detect();
  
  pushMatrix();
    scale(-1,1);
    image(cam, -cam.width, 0);
  popMatrix();
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

