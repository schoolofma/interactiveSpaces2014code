import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;

void setup() {
  size(720, 480, P2D);
  video = new Capture(this, width, height);
  video.start(); 
  opencv = new OpenCV(this, 720, 480);

  opencv.startBackgroundSubtraction(5, 3, 0.5);
}

void draw() {

  if (video.available()) { 
    video.read();
  }

  tint(255,0,0);
  image(video, 0, 0);  
  opencv.loadImage(video);

  opencv.updateBackground();

  opencv.erode();
  opencv.dilate();

  int areaTotal = 0;
  
  for (Contour contour : opencv.findContours ()) {
    areaTotal += contour.area();
  }
  
  float pct = map(areaTotal,0,video.width*video.height*.25,0,255);
  tint(pct,0,0);
  image(video, 0, 0);  

}

