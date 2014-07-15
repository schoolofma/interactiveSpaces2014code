import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;

void setup() {
  size(640*2,480);

  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  kinect.enableRGB(true);

}

void draw(){
  
  image(kinect.getDepthImage(),0,0);
  image(kinect.getVideoImage(),640,0);
  
}

void stop(){
  kinect.quit();
  super.stop();
}
