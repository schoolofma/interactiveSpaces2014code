import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;
PImage bg;
boolean takeSnapshot = false;

void setup() {

  size(720, 480, P2D);

  video = new Capture(this, width, height);
  video.start(); 

  opencv = new OpenCV(this, 720, 480);
  bg = createImage(720, 480, RGB);
}

void draw() {

  opencv.loadImage(video);
  opencv.flip(1);
  image(opencv.getOutput(), 0, 0);

  if (takeSnapshot) {
    bg = opencv.getSnapshot();
    takeSnapshot = false;
  }

  opencv.diff(bg);
  opencv.threshold(49);
  opencv.erode();
  opencv.dilate();

  strokeWeight(3);
  ArrayList<Contour>contours = opencv.findContours(false,true);
  for (int i = 0; i < contours.size(); i++) {
      
      Contour contour = contours.get(i);
      
      // use this to stop if area too small
//      if( contour.area() < 300 ){
//        break;
//      }
      
      contour.setPolygonApproximationFactor(4);
    
      noFill();
      stroke(255, 0, 0);
      contour.getPolygonApproximation().draw();
      
      float centerX = contour.getBoundingBox().x + contour.getBoundingBox().width*.5;
      float centerY = contour.getBoundingBox().y + contour.getBoundingBox().height*.5;
      
      noStroke();
      fill(255,0,255);
      ellipse(centerX,centerY,10,10);
    
  }
}

void keyPressed() {
  takeSnapshot = true;
}
