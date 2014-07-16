// this is the evColour array file

Table myTable;
Colour[] evColor;

void setup() {
  size (800, 600);
  background(255);
  myTable = loadTable("data/evColour-RGB.csv", "header");
  int amount = myTable.getRowCount();

  evColour = new Colour[amount];

  for (int i=0; i< amount; i++) {
    TableRow row = myTable.getRow(i);
    float rgb = row.getFloat("RGB");

    evColour[i] = new Colour(r, g, b);
  }

  for (TableRow row : myTable.rows ()) {
    float r = row.getFloat("R");
    float g = row.getFloat("G");
    float b = row.getFloat("B");
  }
}

void draw() {
  background(255);
  for(int i=0; i<evColour.length; i++)
  fill(evColour[i]);
  rect(i*30, 0, 30, 30);
}
}
