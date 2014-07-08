import processing.video.*; //<>// //<>//

/**
* School of Maa
* Chris Sugrue
* Recap basics of working with pixels : iterate through video fram 
* to find brightest pixel (if pixels are equally bright, stores last found)
* Stores an averaged postion for smoothing.
*/

Capture video;
float smoothX = 0;
float smoothY = 0;

void setup(){
 
  size(640,480);
  
  video = new Capture(this, width, height);
  video.start(); 
  
}

void draw(){
  
  if (video.available()) {
   
    video.read();
      
    // load pixels for altering
    video.loadPixels();
    
    float brightestVal = 0;
    int brightX = 0;
    int brightY = 0;
    
    // loop in 2 dimensions
    // index = y * image width + x
    for( int y = 0; y <  video.height; y++){
      for( int x = 0; x <  video.width; x++){
        int pix = y * video.width + x;
        color pixelColor = video.pixels[pix];
        float pixelBrightness = brightness(pixelColor);
        if(pixelBrightness >= brightestVal){ 
          brightestVal = pixelBrightness;
          brightX = x;
          brightY = y;
        }
      }
     }
  
    image(video,0,0);
    
    // get smoothed values
    smoothX = .75*smoothX+.25*brightX;
    smoothY = .75*smoothY+.25*brightY;
    
    // draw circle around brightest pixel
    noFill();
    stroke(255,0,0);
    ellipse(brightX,brightY,25,25);
    
    stroke(0,255,0);
    ellipse(smoothX,smoothY,25,25);
  }
}
