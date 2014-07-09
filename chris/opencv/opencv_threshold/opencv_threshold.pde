import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;

void setup() {

  size(720, 480);

  video = new Capture(this, width, height);
  video.start(); 

  opencv = new OpenCV(this, 720, 480);
}

void draw() {
  
  if(video.available()){ 
    video.read();
  }
  
  opencv.loadImage(video);
  opencv.threshold(202);
  opencv.flip(1);

  image(opencv.getOutput(), 0, 0);

}

