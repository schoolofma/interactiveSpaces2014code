float num;

void setup() {
  size(600, 600);
  
  // Here we call our flower() function, defined below, 
  // 20 times.
  // Using our own function instead of pasting all the
  // code from flower() here between the { and the }
  // makes the code more readable. You split the problem
  // in smaller pieces, and the name of the function helps
  // you understand and predict what will happen.
  // Maybe a better name would be drawFlower() because...
  // flower what? sell flower? eat flower? :)
  for(int i=0; i<20; i++) {
    flower(i * 30, random(height), (int)random(3, 10), random(20, 40));
  }

  // sum() is a function we define below.
  // it's so simple that it doesn't make sense,
  // you could as well write: num = 22 + 33;
  num = sum(22, 33);
  // average() maybe makes a bit more sense.
  num = average(2, 3, 44);
  // both sum() and average() are just examples 
  // of how you can return a value from a function.  
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
  // No "return" here. That's why it says "void flower",
  // "void" means no return value.
}
// Here we return an integer. That's why it says
// "int sum" instead of "void sum".
int sum(int a, int b) {
  return a+b;
}
// Here we return a float.
float average(float a, float b, float c) {
  return (a+b+c) / 3;
}
