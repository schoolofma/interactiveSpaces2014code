int amount = 100;
float[] x;
float[] y;

/* exersize: try adding three more arrays
  one for the sizes of objects, 
  one for horizontal speed,
  one for vertical speed
*/

void setup() {
  size(600, 600);
  
  x = new float[amount];
  y = new float[amount];
  
  for(int i=0; i<amount; i++) {
    x[i] = random(width);
    y[i] = random(height);
  }
}
void draw() {
  background(200);

  for(int i=0; i<amount; i++) {  
    ellipse(x[i], y[i], 40, 40);
    x[i] += 5;
    y[i] += 7;
    
    if(x[i] > width) {
      x[i] = 0;
    }
    if(y[i] > height) {
      y[i] = 0;
    }
  }    
}
