String[] names = { 
  "one", "two"
};
int[] numbers = { 
  22, 445, 3
};
int[] colors = { 
  #FF2233, #251251, #2510F2, color(22, 55, 51)
};

void setup() {
  size(600, 400);
  println(names);
  println(numbers);
  println(colors);
  
  noStroke();
  
  float x = 0;
  while(x < width) {
    float newx = x + random(30);

    int which = (int)random(colors.length);    
    int c = colors[which];
    fill(c);
    
    rect(x,0,newx,height);
    x = newx;
  }
}

