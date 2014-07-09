int amount = 10;

// An array of objects called circles.
// Notice the type is not int or float, but AnimatedCircle.
AnimatedCircle[] circles;

void setup() {
  size(300, 300, P2D);

  // reserve space for 100 AnimatedCircles
  circles = new AnimatedCircle[amount];
  
  // Construct each circle. Here's where they
  // are born. In our AnimatedCircle file we wrote
  // that the constructor expects 3 arguments.
  // That's why we send here 3 arguments: x, y and size
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
  // Here we go through each AnimatedCircle
  // and paint them. paint() is just a name we chose
  // in our AnimatedCircle class.
  for (int i=0; i<amount; i++) {
    circles[i].paint();   
  }
}

