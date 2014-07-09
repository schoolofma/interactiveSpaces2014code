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
    xspeed = random(-2, 2);
    yspeed = random(-2, 2);
    circleColor = color(random(255),random(255),random(255));
  }
  
  void changeColor() {
  }
  void jump() {
  }
  void resize() {
  }
  void changeSpeed() {
  }
  
  void paint() {
    fill(circleColor);
    ellipse(x, y, 20, 20);
    
    x += xspeed;
    y += yspeed;
    
    if(x > width) {
      x = 0;
    }
    if(y > height) {
      y = 0;
    }
    if(x < 0) {
      x = width;
    }
    if(y < 0) {
      y = height;
    }
  }
}
