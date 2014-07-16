//colour array
Table myTable;
color[] colarray;

// grid layout
// Size of each cell in the grid, ratio of window size to video size
// 35 * 18 = 630
// 60 * 9 = 315
int videoScaleX = 18;
int videoScaleY = 10;
int squareWidth;
int squareHeight;
// Number of columns and rows in our system
int cols, rows;


void setup() {
  size(720, 400);
  background(255);
  myTable = loadTable("data/Colour Codes.csv", "header");
  int amount = myTable.getRowCount();
  colarray = new color[amount];


  for (int i=0; i < amount; i++) {
    TableRow row = myTable.getRow(i);
    String rgb = row.getString("RGB");
    int[] rgbArray = int(rgb.split("-"));

    colarray[i] = color(rgbArray[0], rgbArray[1], rgbArray[2]);

    // Initialize columns and rows
    squareWidth = width/videoScaleX;
    squareHeight = height/videoScaleY;

    // insert colour to grid
    // loop through every row
    for (int y=0; y<videoScaleY; y++) {
      //loop through every column
      for (int x=0; x<videoScaleX; x++) {
      }
    }
  }
}

void draw() {

  // Begin loop for columns
  for (int i = 0; i < videoScaleX; i++) {
    // Begin loop for rows
    for (int j = 0; j < videoScaleY; j++) {

      // Scaling up to draw a rectangle at (x,y)
      int x = i*squareWidth;
      int y = j*squareHeight;

      // this formula gets the ID position
      // Location = y*width +x
      int index = (y*videoScaleX)+x;

      //noStroke();
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, squareWidth, squareHeight);
      
         if (index >= 0 && index < colarray.length) {
        // fills each square with colour from array
        fill(colarray[index]);
      } else {
        fill(255,0,0);
      }
      
    }
  }
}
