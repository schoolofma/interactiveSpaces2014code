import oscP5.*;
import netP5.*;

OscP5 osc;
int listenOnPort = 4500;
int pitch = 0, PITCH_BOTTOM = 45, PITCH_TOP = 95;
float amplitude = 0, AMPLITUDE_GATE = 0.1, AMPLITUDE_TOP = 1;
PVector position, targetPosition;
float SPEED_TOP = 2.0;
float DEFAULT_WEIGHT = 20.0;
float circleColour = 215.0;

void setup() {
  osc = new OscP5(this, listenOnPort);

  size(displayWidth, displayHeight, P3D);
  frameRate(30);

  background(0, 0, 0, 0);
  position = new PVector();
  position.x = 0;
  position.y = height/2;
  targetPosition = position.get();
  colorMode(HSB);
  stroke(circleColour, 255, 255, 50);
  fill(circleColour, 255, 255, 50);
}

void draw() {
  // Fade out a bit every 5 frames.
  if (frameCount %5 == 0){
    fill(0,2);
    rect(0, 0, width, height);
  }
  
  // Clear whole thing every now and again.
  if (frameCount %6000 == 0){
    fill(0);
    rect(0, 0, width, height);
  }
  
  // Draw the circles and particles.
  if (amplitude > AMPLITUDE_GATE) {
    float pitchFactor = ((float)pitch - (float)PITCH_BOTTOM) / ((float)PITCH_TOP - (float)PITCH_BOTTOM);
    float ampFactor = ((float)amplitude - (float)AMPLITUDE_GATE) / ((float)AMPLITUDE_TOP - (float)AMPLITUDE_GATE);
    float rotation = -QUARTER_PI + HALF_PI * pitchFactor;
    float speed = SPEED_TOP * ampFactor;
    
    circleColour = 60 + (1-ampFactor) * 85; 
    
    pitchFactor = constrain(pitchFactor, 0, 1);
    ampFactor = constrain(ampFactor, 0, 1);
    
    targetPosition.y = (1-pitchFactor) * height;
    targetPosition.x+=5;
    
    if (targetPosition.x > width) {
      targetPosition.x = 0;
    }
    
    position.y = (position.y * 0.9) + ((targetPosition.y - position.y) * 0.1);// * ampFactor;
    position.x = targetPosition.x;
    
    stroke(circleColour, 255, 255, 100);
    fill(circleColour, 255, 255, 100);
    ellipse( targetPosition.x, targetPosition.y, (60*ampFactor), (60*ampFactor) );
    
    PVector sprayOut = PVector.fromAngle(0);
    sprayOut.rotate(frameCount % PI);
    sprayOut.setMag((60*ampFactor) + frameCount % 10);
    ellipse(targetPosition.x + sprayOut.x, targetPosition.y + sprayOut.y, 5, 5);
  }
}

void oscEvent(OscMessage message) {
  print("### received an osc message.");
  print(" addrpattern: " + message.addrPattern());
  println(" typetag: " + message.typetag());
  if (message.checkAddrPattern("/amp") == true) {
    amplitude = message.get(0).floatValue();
  } else if (message.checkAddrPattern("/pitch") == true) {
    pitch = message.get(0).intValue();
  }
}
