

color[] colarray = {
  color(0, 60, 16),  
  color(0, 60, 67), 
  color(0, 61, 88)
};


void setup() {
  size (800, 600);
  background(255);

  //  int theseColours = new int[3];
  //  int[] evColours = new int[theseColours];
}

void draw() {
  for (int i=0; i< colarray.length; i++) {
    noStroke();
    fill(colarray[i]);
    rect(i*100, 0, 100, 100);
  }
}
