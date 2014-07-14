import oscP5.*;
import netP5.*;

// make osc object
OscP5 oscP5;

// set port and address
NetAddress myAddress;

void setup(){
  
  size(400,400);

  oscP5 = new OscP5(this,12000);
  myAddress = new NetAddress("127.0.0.1",12345); // 127.0.0.1 is localhost

}


void draw(){

}


void mouseDragged() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/mouse");
  myMessage.add(mouseX); /* add an int to the osc message */
  myMessage.add(mouseY); /* add another */
  oscP5.send(myMessage, myAddress); 
}


