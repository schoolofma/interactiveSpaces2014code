/**
* School of Maa
* Chris Sugrue
* Recap basics of working with pixels : 
* iterate through image pixels and threshold to remov dark pixels.
*/

PImage myImage;
PImage myXImage;

void setup(){
 
  myImage = loadImage("cat_blakbg.jpg");
  
  // create a second image so we are not altering the original
  myXImage = new PImage(myImage.width,myImage.height, RGB);
  
  size(myImage.width,myImage.height);

}

void draw(){
  
  // load pixels for altering
  myXImage.loadPixels();
  
  int totalPixels = myImage.width*myImage.height;
  
  for( int i = 0; i < totalPixels; i++){
      // get the pixel from the image (returned as processing color type)
      color pixelColor = myImage.pixels[i];
      // extract the brigthness value from the pixel (0-255)
      float pixelBrightness = brightness(pixelColor);
      // test if the brightness is below our threshold and if so, set to red
      if(pixelBrightness < 75) pixelColor=color(255, 0, 0);
      // set the thresholded image's pixel value
      myXImage.pixels[i] = pixelColor;  
   } //<>//
  
  // update changes to pixels
  myXImage.updatePixels();
  
  // draw our thresolded image
  image(myXImage,0,0);
}
