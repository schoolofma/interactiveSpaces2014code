// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-6: Drawing a grid of squares

// Size of each cell in the grid, ratio of window size to video size
// 35 * 18 = 630
// 60 * 9 = 315
int videoScaleX = 18;
int videoScaleY = 9;
int squareWidth;
int squareHeight;

// Number of columns and rows in our system
int cols, rows;

void setup() {
  size(630,315);
  
  // Initialize columns and rows
  squareWidth = width/videoScaleX;
  squareHeight = height/videoScaleY;
}

void draw() {
  
  // Begin loop for columns
  for (int i = 0; i < videoScaleX; i++) {
    // Begin loop for rows
    for (int j = 0; j < videoScaleY; j++) {
      
      // Scaling up to draw a rectangle at (x,y)
      int x = i*squareWidth;
      int y = j*squareHeight;
      fill(255);
      stroke(0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x,y,squareWidth,squareHeight); 
    }
  }
}
