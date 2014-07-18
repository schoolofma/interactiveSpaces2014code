import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioSample sample;

void setup()
{
  size(500, 500);
  minim = new Minim(this);
  sample = minim.loadSample("Violet.mp3");
}

void draw(){
  
  int gray = (int)map(sample.mix.level()*1000,0,200,0,255);
  println(sample.mix.level()*1000);
  background(gray,0,0);
  
  ellipse(width/2,height/2,100,100);
}

void mousePressed(){
  
  float dist = dist(mouseX,mouseY,width/2,height/2);
  if(dist < 50){
      sample.trigger();
      println("trigger");
  }else{
    sample.stop();
    println("stop");
  }
}



