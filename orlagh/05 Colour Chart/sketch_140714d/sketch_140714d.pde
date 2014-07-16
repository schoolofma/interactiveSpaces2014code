Table myTable;

color[] colarray;


void setup() {
  size (800, 600);
  background(255);
  myTable = loadTable("data/Colour Codes.csv", "header");
  int amount = myTable.getRowCount();
  colarray = new color[amount];
  
  for (int i=0; i < amount; i++) {
    TableRow row = myTable.getRow(i);
    String rgb = row.getString("RGB");
    int[] rgbArray = int(rgb.split("-"));
    
    colarray[i] = color(rgbArray[0], rgbArray[1], rgbArray[2]);
  }
}

void draw() {
  for (int i=0; i< colarray.length; i++) {
    noStroke();
    fill(colarray[i]);
    rect(i*10, 0, 10, 10);
  }
}
