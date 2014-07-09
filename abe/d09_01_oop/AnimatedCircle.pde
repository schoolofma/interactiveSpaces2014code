class AnimatedCircle {
  float x;
  float y;
  float sz;
  color circleColor;
  float xspeed;
  float yspeed;
  
  // constructor
  AnimatedCircle(float tmpX, float tmpY, float tmpSz) {
    x = tmpX;
    y = tmpY;
    sz = tmpSz;
  }
  
  void paint() {
    ellipse(x, y, 20, 20);
  }
}
