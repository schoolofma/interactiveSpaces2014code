Flower[] myFlower;

void setup() {
  size(300, 300, P2D);

  myFlower = new Flower[20];
  
  for (int i=0; i<myFlower.length; i++) {
    myFlower[i] = new Flower(random(width), height * random(0.7, 0.9)); 
  }
}

void draw() {
  background(#D9FAF7);
  
  noStroke();
  fill(#D7F0A0);
  rect(0, height * 0.6, width, height);
  
  fill(#FCF5B0);
  ellipse(80, 80, 40, 40);
  
  for (int i=0; i<myFlower.length; i++) {
    myFlower[i].draw();   
  }
}
