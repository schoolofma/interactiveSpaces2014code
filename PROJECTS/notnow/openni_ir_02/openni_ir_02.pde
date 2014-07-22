import gab.opencv.*;
import controlP5.*;
import SimpleOpenNI.*;

// SETTINGS
int waitBeforeReady = 3; // seconds before starting to move particles


// Globals
SimpleOpenNI kinect;
OpenCV opencv;
PImage irImage, generatedImage;
int[] depthMap;
int detail = 3;
//int brightnessThresold = 100;
boolean standby;
int standbyTime;
int activeTime;
boolean agentsCreated = false;


// ------ agents ------
Agent[] agents;
//Agent[] agents = new Agent[10000]; // create more ... to fit max slider agentsCount
int agentsCount = 4000;
float noiseScale = 300, noiseStrength = 10; 
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 4;
int drawMode = 1;

// ------ ControlP5 ------
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;


// ------ Point cloud -----
ArrayList<PVector> visiblePoints;


// depth
float        zoomF = 0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);


void setup()
{
  //size(640*2, 480*2, P3D);
  size(1024, 768, P3D);
  smooth();
  
  kinect = new SimpleOpenNI(this);
  
  if(kinect.isInit() == false) {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // enable depthMap generation 
  kinect.enableDepth();
  
  // enable ir generation
  kinect.enableIR();
  
//  perspective(radians(45),
//              float(width)/float(height),
//              10,150000);
  
  
  fill(0);
  
  standbyTime =  millis();
}

void draw()
{
  //background(255);
  
  noStroke();
  fill(255, 20);
  rect(0,0, width, height);
  
  // update the cam with IR data
  kinect.update();
  
  irImage = kinect.irImage();
  depthMap = kinect.depthMap();
  
  // 3d position
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  PVector realWorldPoint;
  PVector[] realWorldMap = kinect.depthMapRealWorld();
  int     index;
  
  //translate(0,0,-1000);
  
  //beginShape(POINTS);
  standby = true;
  
  visiblePoints = new ArrayList<PVector>();
  
  for(int y=0;y < kinect.depthHeight();y+=detail) {
    for(int x=0;x < kinect.depthWidth();x+=detail) {
      index = x + y * kinect.depthWidth();
      if(depthMap[index] > 0) { 
        realWorldPoint = realWorldMap[index];
        if (realWorldPoint.z < 1000) {
          standby = false;
          
//          color c = irImage.pixels[index];
//          //fill(c, 50);
//          float b = brightness(c);
//          fill(0, 255-b);
          //float radius = map(b, 0, 255, 10, 1);
          //ellipse(realWorldPoint.x *2,realWorldPoint.y *2, radius, radius);
          //fill(0, 50);
          //ellipse(realWorldPoint.x *2,realWorldPoint.y *2, 4, 4);
          
          visiblePoints.add(new PVector(realWorldPoint.x *2,realWorldPoint.y *2));
          
          // create agents
          //agents[i] = new Agent();
          
        }
        // vertex(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
        // vertex(realWorldPoint.x,realWorldPoint.y,0);
      }
    }
  } 
  
  
  if (standby) {
    standbyTime =  millis();
    //println("we are in waiting for you");
    agentsCreated = false;
    
  } else {
    
    activeTime = millis() - standbyTime;
    
    if (activeTime/1000 > waitBeforeReady) {
      
      if (!agentsCreated) {
        agents = new Agent[visiblePoints.size()]; 
        for (int i=0; i<visiblePoints.size(); i++) {
          agents[i] = new Agent(visiblePoints.get(i).x, visiblePoints.get(i).y);
        }
        agentsCreated = true;
      } else {
        int agentsCount = agents.length;
        for(int i=0; i<agentsCount; i++) { 
          agents[i].update();
        }
      }
      
    } else {
      
      for (int i=0; i<visiblePoints.size(); i++) {
        fill(0, 50);
        ellipse(visiblePoints.get(i).x, visiblePoints.get(i).y, 4, 4);
      }
      
    }
    
  }
  
  //endShape();

}



void mousePressed() {
    println("reset!");
    standby = true;
    activeTime = 0;
    standbyTime =  millis();
}


