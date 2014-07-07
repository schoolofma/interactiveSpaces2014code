import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  println(Capture.list());
  
  cam = new Capture(this, 640, 480, "/dev/video0", 30);
  cam.start();
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
}

