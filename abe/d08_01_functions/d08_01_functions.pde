int num;

void setup() {
  size(600, 600);
  for(int i=0; i<20; i++) {
    flower(i * 20, random(height), (int)random(3, 10), random(20, 40));
  }

  // num = 22 + 33; // same as next line
  num = sum(22, 33);
  num = average(2, 3, 44);  
}

void flower(float x, float y, int numPetals, float petalSize) {
  noStroke();
  fill(random(255), 20, 20);
  for(int i=0; i<numPetals; i++) {
    ellipse(
      x + random(-petalSize, petalSize), 
      y + random(-petalSize, petalSize), 
      petalSize,
      petalSize);
  }
  stroke(0);
  line(x+5,y+5,x+5,y+50);
  // no return here
}
int sum(int a, int b) {
  return a+b;
}
float average(float a, float b, float c) {
  return (a+b+c) / 3;
}
