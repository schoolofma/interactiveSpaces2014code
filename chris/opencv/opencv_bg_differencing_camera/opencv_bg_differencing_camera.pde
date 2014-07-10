import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;
PImage bg;
boolean takeSnapshot = false;

void setup() {

  size(720, 480);

  video = new Capture(this, width, height);
  video.start(); 

  opencv = new OpenCV(this, 720, 480);
  bg = new PImage(720, 480, RGB);
}

void draw() {
  
  if(video.available()){ 
    video.read();
  }
  
  opencv.loadImage(video);
  opencv.flip(1);
  
  if (takeSnapshot) {
    bg = opencv.getSnapshot();
    takeSnapshot = false;
  }

  opencv.diff(bg);
  opencv.threshold(49);

  image(opencv.getOutput(), 0, 0);

}

void keyPressed() {
  takeSnapshot = true;
}
