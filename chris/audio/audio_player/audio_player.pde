import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;
AudioPlayer player;

void setup(){
  size(200,200);
  minim = new Minim(this);
  player = minim.loadFile("05-Sorte.mp3");
  player.loop();
  player.pause();
}

void draw(){
  
  if(mouseX >width/2) player.play();
  else player.pause();
  
  background(255);
  fill(255);
  rect(width/2,0,width/2,height);
}



