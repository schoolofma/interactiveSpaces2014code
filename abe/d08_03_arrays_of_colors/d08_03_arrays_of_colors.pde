// Declare and initialize 
// an array of type String (words)
String[] names = { 
  "one", "two"
};
// Declare and initialize 
// an array with integers
int[] numbers = { 
  22, 445, 3
};
// Declare and initialize 
// an array with integers.
// You could also use "color" instead of "int"
int[] colors = { 
  #775511, #115577, #771155, color(220, 200, 180)
};

void setup() {
  size(600, 400, P2D);
  
  // print all names 
  println(names);
  
  // print the second number found in the numbers array
  println(numbers[1]);
  
  noStroke();
  
  // we are going to keep going as
  // long as we haven't reached the 
  // right border of the screen.
  
  float x = 0;
  while(x < width) {
    float rectWidth = random(3, 30);

    // choose which color from the list of colors you want.
    // since we have 4 colors, we want to randomly pick
    // 0, 1, 2 or 3
    // colors.length indicates how many elements the array has.
    // The index of an array is always an integer, that's why
    // we use int here. You can ask for the 2nd color. You can
    // not ask for the color 2.1. It's either 0, 1, 2 or 3.
    int which = (int)random(colors.length);
    // set the fill color to one of the colors
    // in the colors array (the one chosen in the
    // previous step. 
    fill(colors[which]);
    
    rect(x, 0, rectWidth, height);
    x += rectWidth;
  }  
}

