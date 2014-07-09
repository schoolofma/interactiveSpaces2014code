int amount = 10;
AnimatedCircle[] circles;

void setup() {
  size(300, 300, P2D);

  circles = new AnimatedCircle[amount];
  for (int i=0; i<amount; i++) {
    circles[i] = new AnimatedCircle(
      random(width), 
      random(height), 
      random(5, 20)
    ); 
  }
}

void draw() {
  background(255);
  for (int i=0; i<amount; i++) {
    circles[i].paint();   
  }
}

