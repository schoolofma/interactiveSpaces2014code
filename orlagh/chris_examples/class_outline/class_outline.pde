ArrayList<myDrawer> drawings;

void setup(){
  
  
  for( int i = 0; i < totalDrawings; i++){
    drawings.add(new Drawer());
  }
  
  
  for( int i = 0; i < totalDrawings; i++){
    Drawer drawer = drawings.get(i);
    // load file with name from some file arraylist or array
  }
}

void draw(){
  
}


class myDrawer{
  ArrayList pts;
  
  myDrawer(){
    pts = new ArrayList();
  }
  
  void loadFile( String filename){
    // create your arraylist with pts from csv file
  }
  
  void display(){
    // update which pts is drawing
    // loops trhough and draws the pts
  
  }
  
  
}

