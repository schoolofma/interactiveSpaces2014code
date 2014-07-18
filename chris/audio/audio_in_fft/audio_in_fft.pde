import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioInput input;
FFT fft;

void setup()
{
  size(512, 200);
 
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 1024); 
  fft = new FFT(input.bufferSize(), input.sampleRate());
}

void draw(){
  
  background(0,0,0);

  //println(input.mix.level()*1000);
  
  float radius =10+ (int)map(input.mix.level()*1000,0,50,0,20);
  fill(255);
  noStroke();
  ellipse(width-50,50,radius,radius);
  
  fft.forward(input.mix);

  stroke(255);
  for(int i = 0; i < fft.specSize(); i++){
    float amp = fft.getBand(i); // get amplitude of frequency 
    line(i,height,i,height-amp*100);
  }

}

