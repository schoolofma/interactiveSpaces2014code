import SimpleOpenNI.*; 
SimpleOpenNI openni;

void setup() { 
  size(640*2, 480);
  openni = new SimpleOpenNI(this); 
  openni.enableDepth(); 
  openni.enableRGB();
}

void draw(){
  openni.update();
  image(openni.depthImage(), 0, 0);
  image(openni.rgbImage(), 640, 0);
}

