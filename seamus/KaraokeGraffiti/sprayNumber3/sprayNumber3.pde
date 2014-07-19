import oscP5.*;
import netP5.*;

OscP5 osc;
int listenOnPort = 4500;
int pitch = 0, PITCH_BOTTOM = 65, PITCH_TOP = 95;
float amplitude = 0, AMPLITUDE_THRESHOLD = 0.0, AMPLITUDE_GATE = 0.2, AMPLITUDE_TOP = 1;
String chatMessage;
PVector position, targetPosition;
float SPEED_TOP = 2.0;
float DEFAULT_WEIGHT = 20.0;

// http://glsl.heroku.com/e#4633.5

// Wall texture from: http://texturez.com/textures/concrete/4092

boolean debug = false;

SprayManager sprayCan;

PShader pointShader;

// Spray density distribution expressed in grayscale gradient
PImage sprayMap;

float weight;

float depthOffset;
float offsetVel;

PImage wall;

PGraphics paintscreen;

Path s;

void setup() {
    osc = new OscP5(this, listenOnPort);

  //size(640, , P3D);
  size(displayWidth, displayHeight, P3D);
  frameRate(60);
  
  chatMessage = ""; 
  
  paintscreen = createGraphics(width, height, P3D);
  
  wall = loadImage("wallTexture.jpg");
  
  sprayCan = new SprayManager();

  sprayMap = loadImage("sprayMap.png");

  depthOffset = 0.0;
  offsetVel = 0.0005;

  pointShader = loadShader("pointfrag.glsl", "pointvert.glsl");  
  //pointShader.set("sharpness", 0.9);
  pointShader.set( "sprayMap", sprayMap );

  //background(0);
  
  paintscreen.beginDraw();
  paintscreen.image(wall,0,0);
  paintscreen.endDraw();
  
  position = new PVector();
  position.x = 0;
  position.y = height/2;
  targetPosition = position.get();
  sprayCan.newStroke(position.x, position.y, DEFAULT_WEIGHT);
}

void draw() {

  float animSpeed = 4;
  float animate = ((sin(radians(frameCount * animSpeed)) + 1.0) / 2.0);
  
  weight = animate * 100.0 + 100.0 + random(-10,10);
  
  colorMode(HSB);
  float hue = animate * 50;
  color col = color( hue, 255, 200 );
  colorMode(RGB);
  
  sprayCan.setColor(col);
  sprayCan.setWeight(weight);

  if (mousePressed) {
    if ( null!= sprayCan ) 
      sprayCan.newKnot( mouseX, mouseY, weight );
  }
  
    chatMessage = "amplitude: " + amplitude + ", pitch: " + pitch;

  if (amplitude > AMPLITUDE_GATE) {
    float pitchFactor = ((float)pitch - (float)PITCH_BOTTOM) / ((float)PITCH_TOP - (float)PITCH_BOTTOM);
    float ampFactor = ((float)amplitude - (float)AMPLITUDE_THRESHOLD) / ((float)AMPLITUDE_TOP - (float)AMPLITUDE_THRESHOLD);
    float rotation = -QUARTER_PI + HALF_PI * pitchFactor;
    float speed = SPEED_TOP * ampFactor;
    
    fill(255, 0, 0);
    targetPosition.y = (1-pitchFactor) * height;
    position.y = position.y * 0.93 + (targetPosition.y - position.y) * 0.07 * ampFactor;
    position.x++;
    
    sprayCan.newKnot( position.x, position.y, weight );
  }
  
  paintscreen.beginDraw();
  paintscreen.strokeCap(SQUARE);
  if ( null != sprayCan ) sprayCan.draw(paintscreen);
  paintscreen.endDraw();
  
  image(paintscreen,0,0);
  
  text(chatMessage, 10, 10);
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
  
  println(chatMessage);
}

void mousePressed() {
  sprayCan.newStroke(mouseX, mouseY, weight);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {

    paintscreen.beginDraw();
    paintscreen.image(wall,0,0);
    paintscreen.endDraw();
    
    sprayCan.clearAll();
  }
  if (key == 's' || key == 'S') {
    saveFrame(); 
  }
}

