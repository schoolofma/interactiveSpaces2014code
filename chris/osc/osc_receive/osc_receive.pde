import oscP5.*;
import netP5.*;

// make osc object
OscP5 oscP5;

int x=0;
int y=0;

void setup(){
  
  size(400,400);

  oscP5 = new OscP5(this,12345);

}


void draw(){
  background(255);
  ellipse(x,y,50,50);
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  // parse the data and change x y of ellipse
  if( theOscMessage.checkAddrPattern("/mouse") == true){
    x = theOscMessage.get(0).intValue();
    y = theOscMessage.get(1).intValue();
    println();
  }
}

