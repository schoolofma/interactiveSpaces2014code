// This is the "blueprint" for our object.
class AnimatedCircle {
  // This kind of object (AnimatedCircle)
  // contains 6 properties.
  float x;
  float y;
  float sz;
  color circleColor;
  float xspeed;
  float yspeed;
  
  // This is the constructor.
  // Note the missing void/int/float/... at the beginning.
  // The name must be identical to the class name.
  // We decide how many arguments it takes.
  // In this case, we decide that AnimatedCircles are
  // constructed with 3 arguments: x, y and size.
  AnimatedCircle(float tmpX, float tmpY, float tmpSz) {
    // Store the temporary values we receive in the
    // properties of this object, so they are not lost.
    x = tmpX;
    y = tmpY;
    sz = tmpSz;
    // We could receive these too as arguments, but
    // we decided to make them just random.
    xspeed = random(-2, 2);
    yspeed = random(-2, 2);
    circleColor = color(random(255),random(255),random(255));
  }
  
  // These methods are left as an exercise.
  // A function inside an object is called a method.
  // They are the kinds of things that the object
  // can do.
  void changeColor() {
  }
  void jump() {
  }
  void resize() {
  }
  void changeSpeed() {
  }
  
  // This method takes care of painting the object
  // to the screen, and updating it's variables
  // (position, for instance).
  void paint() {
    fill(circleColor);
    ellipse(x, y, sz, sz);
    
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
