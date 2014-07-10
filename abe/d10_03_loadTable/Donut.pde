class Donut {
  float x;
  float y;
  
  Donut(float tmpx, float tmpy) {
    x = tmpx;
    y = tmpy;
  }
  
  void draw() {
    noStroke();
    pushMatrix();
    translate(x, y);
    for(float a=0; a<TWO_PI+0.1; a+=0.05) {
      rotate(a);
      fill(0, random(20));
      rect(random(20,30), 0, 20, 10);
    }
    popMatrix();
  }
}
