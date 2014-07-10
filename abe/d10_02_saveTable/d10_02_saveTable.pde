Table myTable;

void setup() {
  size(600, 600);

  randomSeed(22); 
  
  myTable = new Table();

  myTable.addColumn("x");
  myTable.addColumn("y");

  for(int i=0; i<100; i++) {
    TableRow row = myTable.addRow();
    row.setFloat("x", random(width));
    row.setFloat("y", random(height));
  }  
  
  saveTable(myTable, "data/randomNums.csv");
}

void draw() {
}
