/* exersize: try adding and using three more arrays
 one for the sizes of objects, 
 one for horizontal speed,
 one for vertical speed.
 
 This way each object will have its own size and speed.
 Use the horizontal and vertical speed instead of the
 values 5 and 7 below.
 */

// It's good to specify the amount of items in an integer here.
// That makes changing the amount of items very easy.
int amount = 100;
// The other option would be to delete the previous line, and
// put a 100 in every place where "amount" is used. This
// way, when you want to change the amount of items, you have
// to scan your code, find the number 100, see if it actually
// refers to the amount of items, and replace it by 200, for 
// instance. Much easier to break.

// Tell Processing that x and y are float arrays.
float[] x;
float[] y;
float[] sz;
int[] colors;
float[] xspeed;
float[] yspeed;

void setup() {
  size(600, 600);
  colorMode(HSB);

  // Here you reserve space for your array elements.
  // You are saying: my array will have N elements.
  x = new float[amount];
  y = new float[amount];
  sz = new float[amount];
  colors = new int[amount];
  xspeed = new float[amount];
  yspeed = new float[amount];

  // By default our arrays contain just 0's, and our
  // circles would be all in the same position (0, 0).
  // We fix that by assigning each element in the array
  // a random value.
  for (int i=0; i<amount; i++) {
    x[i] = random(width);
    y[i] = random(height);
    sz[i] = random(5, 20);
    colors[i] = color(random(255));
    xspeed[i] = random(1, 5);
    yspeed[i] = random(1, 5); 
  }
}
void draw() {
  background(200);

  // Now we draw our collection of ellipses in our screen.
  for (int i=0; i<amount; i++) {
    // We can not write here just "x", we have to specify
    // which x are we talking about. Remember that "x" is
    // a collection of floats, not just one.
    fill(colors[i]);  
    ellipse(x[i], y[i], sz[i], sz[i]);
    x[i] += xspeed[i];
    y[i] += yspeed[i];

    // Check if this ellipse got out of the screen,
    // and if so, fix it.
    if (x[i] > width) {
      x[i] = 0;
    }
    if (y[i] > height) {
      y[i] = 0;
    }
  }
}

