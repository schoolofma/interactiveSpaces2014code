import gab.opencv.*;
import SimpleOpenNI.*;

SimpleOpenNI openni;
int kWidth  = 640;
int kHeight = 480;

PImage depthImg;
int minDepth =  60;
int maxDepth = 860;

OpenCV opencv;


void setup() { 
  size(kWidth, kHeight);
  openni = new SimpleOpenNI(this); 
  openni.enableDepth(); 
  
  opencv = new OpenCV(this, kWidth, kHeight);
  depthImg = new PImage(kWidth, kHeight);
}

void draw(){
  openni.update();
  
  // get array of all depth values
  int[] rawDepth = openni.depthMap();
  
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
  // Another way to loop through contrours
  for (Contour contour : opencv.findContours ()) {
    contour.draw();
  }
  
  fill(0, 255, 255);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
  text("a/s: adjust minDepth, z/x: adjust maxDepth", 10, 56);
  //println(frameRate);
}


void keyPressed() {
  
  switch(key){
    case 'a': 
      minDepth+=2;
      break;
    case 's':
      minDepth-=2;
      break;
    case 'z':
      maxDepth+=2;
      break;
    case 'x':
      maxDepth-=2;
      break; 
  }

}
