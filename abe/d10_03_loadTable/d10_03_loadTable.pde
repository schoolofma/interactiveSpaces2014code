Table myTable;

Donut[] myDonuts;

void setup() {
  size(600, 600);
  
  myTable = loadTable("data/randomNums.csv", "header");

  int amount = myTable.getRowCount();
  
  // If we wanted to create objects based on each
  // data row in the csv file, we could create an
  // array of the same size:
  myDonuts = new Donut[amount];
  
  for(int i=0; i<amount; i++) {
    TableRow row = myTable.getRow(i);
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    
    // Here we construct the new object based on
    // data coming from the csv file:
    myDonuts[i] = new Donut(x, y);
    
    //ellipse(x, y, 20, 20);
  }
    
  for(TableRow row : myTable.rows()) {
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    
    //ellipse(x, y, 5, 5);
  }
}

void draw() {
  background(255);
  for(int i=0; i<myDonuts.length; i++) {
    myDonuts[i].draw();
  }
}
