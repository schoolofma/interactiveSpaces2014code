import processing.video.*;
import SimpleOpenNI.*;

// SETTINGS
int waitBeforeReady = 3; // seconds before starting to move particles
float zDistance = 1000;
float diffIrImageThreshold = 35.0; // to trigger movement events
int movementsCountNeeded = 4000;

int maxColor = 220;
int minColor = 200;
int colors = minColor;
float colorStep = 1;


// -- webcam --
Capture cam;
boolean kinectMode = false;
int detail = 5;

// Globals
SimpleOpenNI kinect;
PImage irImage, irCopyImage, generatedImage;
PGraphics pointsCloudImage, pointsCloudCopyImage;

int[] depthMap;
boolean standby;
int standbyTime;
int activeTime;
boolean agentsCreated = false;
boolean goBack = false;
boolean acceptMovements = true;
int visiblePointsCount;


// ------ agents ------
Agent[] agents;
int agentsCount = 12000;
float noiseScale = 300, noiseStrength = 10; 
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 4;
int drawMode = 1;
String[] updateType = {"linear", "decompose", "goBack", "linearFat"};
int currentUpdateType;

// ------ Point cloud -----
ArrayList<PVector> visiblePoints, oldVisiblePoints;

// depth
float        zoomF = 0.5f;
float        rotX = radians(180);
float        rotY = radians(0);


// ------- movement event -------
int movementStopTimeCounter = 0;
int framesToChangeSituation = 180;
boolean allowChangeCount = true;
int changeCount = 0;



void setup()
{
  //1280 x 720 
  //size(1024, 768, P3D);
  size(1280, 720, P3D);
  frameRate(30);
  smooth();
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100, 100);
  
  // KINECT
  kinect = new SimpleOpenNI(this);
  if(kinect.isInit() == false) {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     kinectMode = false;
  } else {
     kinectMode = true;
     kinect.enableDepth();
     kinect.enableIR();
  }
  
  // CAMERA
  if (!kinectMode) {
    String[] cameras = Capture.list();
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
      
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(this, cameras[3]);
      cam.start();     
    } 
  }
  
// perspective(radians(45), float(width)/float(height), 10, 15000);
  
  // Create all the agents once
  agents = new Agent[agentsCount];
  
  background(0, 0, 100, 100);
  fill(0);
  standbyTime =  millis();
  
//  pointsCloudImage = createGraphics(640,480);
//  pointsCloudImage.noStroke();
//  pointsCloudImage.fill(255);
//  
//  pointsCloudCopyImage = createGraphics(640,480);

  irCopyImage = createImage(640, 480,RGB);
  irImage = createImage(640, 480,RGB);
}


void draw() {
  noStroke();
  //fill(255, 20);
  fill(0, 0, 100, 20);
  rect(width/2,height/2, width, height);
  
  standby = true;
  visiblePoints = new ArrayList<PVector>();
  
  if (kinectMode) {
    // update the cam with IR data
    kinect.update();
    kinect.setMirror(true);
    //pointsCloudCopyImage.copy(pointsCloudImage, 0,0,640,480, 0,0,640,480);
    irCopyImage.copy(irImage,0,0,640,480,0,0,640,480);
    irCopyImage.updatePixels();
    irImage = kinect.irImage();
    depthMap = kinect.depthMap();
    // 3d position
    translate(width/2, height/2, 0);
    rotateX(rotX);
    rotateY(rotY);
    scale(zoomF); // 0.5
    PVector realWorldPoint;
    PVector[] realWorldMap = kinect.depthMapRealWorld();
    int     index;
    //translate(0,0,-1000);
//    pointsCloudImage.beginDraw();
//    pointsCloudImage.background(0);
    for(int y=0; y < kinect.depthHeight(); y += detail) {
      for(int x=0; x < kinect.depthWidth(); x += detail) {
        index = x + y * kinect.depthWidth();
        if(depthMap[index] > 0) { 
          realWorldPoint = realWorldMap[index];
          if (realWorldPoint.z < zDistance) {
            standby = false;
            visiblePoints.add(new PVector(realWorldPoint.x *2,realWorldPoint.y *2));
            //pointsCloudImage.ellipse(x, y, 5, 5);
          }
        }
      }
    }
    //pointsCloudImage.endDraw();
    //image(pointsCloudCopyImage, 0, 0);
    
  } else if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    //image(cam, 0, 0);
    for(int x=0;x < cam.width;x+=detail) {
      for(int y=0;y < cam.height;y+=detail) {
        int index = x + (y * cam.width);
        color c = cam.pixels[index];
        //      fill(brightness(c));
        //      ellipse(x*2, y*2, 4, 4);
        standby = false;
        if (brightness(c) < 150) {
          visiblePoints.add(new PVector(x * 2, y * 2));
        }
      }
    }
  }
  
//  if (frameCount % 120 == 0) {
//    println("how many visible points? " + visiblePoints.size());
//  }
  
  if (standby) {
    standbyTime =  millis();
    
    // ADD placeholder!!!!
    
  } else {
    // EVENTS
    //checkTimeline();
    
    activeTime = millis() - standbyTime;
    createAgents();
    updateAgents(); 
  }
  
  changeCount++;
  
  updateColor();
  
}



void createAgents() {
  if (!agentsCreated) {
    for (int i=0; i<agentsCount; i++) {
      if (visiblePoints.size() > i) {
        agents[i] = new Agent(visiblePoints.get(i).x, visiblePoints.get(i).y, true); // VISIBLE AGENT/POINT
      } else {
        float xPos = random(-width, width*2);
        float yPos = random(-height, height*2);
        agents[i] = new Agent(xPos, yPos, false); // NOT VISIBLE AGENT/POINT
      }
    }
    agentsCreated = true;
  }
}



void updateAgents() {
  
  checkMovements(); // p == pOld
  
  visiblePointsCount = visiblePoints.size();
  
  for(int i=0; i<agentsCount; i++) {
    
    if (updateType[currentUpdateType] == "goBack") {
      // GOBACK
      if (visiblePointsCount > i) {
        agents[i].visible = true;
        agents[i].updateGoBack(visiblePoints.get(i).x, visiblePoints.get(i).y);
      }
      
    } else if (updateType[currentUpdateType] == "decompose") {
      // DECOMPOSE
     if (visiblePointsCount > i) {
       agents[i].visible = true;
       agents[i].updateDecompose(visiblePoints.get(i).x, visiblePoints.get(i).y, i);
      }
      
    } else if (updateType[currentUpdateType] == "linear") {
      // LINEAR
      if (visiblePointsCount > i) {
        agents[i].visible = true;
        agents[i].updateLinear(visiblePoints.get(i).x, visiblePoints.get(i).y);
      }
    } else if (updateType[currentUpdateType] == "linearFat") {
      // LINEAR FAT
      if (visiblePointsCount > i) {
        agents[i].visible = true;
        agents[i].updateLinearFat(visiblePoints.get(i).x, visiblePoints.get(i).y);
      }
    }
  }
}


void changeSituation() {
  if (changeCount > 100) {
    currentUpdateType++;
    if (currentUpdateType > updateType.length-1) {
      currentUpdateType = 1;
    }
    changeCount = 0;
  }

}


//void mousePressed() {
//  changeSituation();
//}


void keyPressed() {
  if (key == 83 || key == 115) { // S or s
    save("fog_" + frameCount + ".jpg");
    println("saving frame " + frameCount);
  }
  
  if (keyCode == ENTER) {
    takePicture();
  }
}


//void checkTimeline() {
//  
//  // activeTime
//  if (activeTime > 10000) {
//    // goBack
//    //println("goBack now");
//    currentUpdateType = 2;
//  } else if (activeTime > 5000) {
//    // decomposition
//    //println("deco now");
//    currentUpdateType = 1;
//  }
//  
//}



void checkMovements() {
  loadPixels();
  
  irImage.filter(THRESHOLD, 0.1);
  irCopyImage.filter(THRESHOLD, 0.1);
  irImage.loadPixels();
  irCopyImage.loadPixels();
  
  int movements = 0;
  
  for (int x = 0; x < irImage.width; x += 2 ) {
    for (int y = 0; y < irImage.height; y += 2 ) {
      int loc = x + y*irImage.width;            // Step 1, what is the 1D pixel location
      color current = irImage.pixels[loc];      // Step 2, what is the current color
      color previous = irCopyImage.pixels[loc]; // Step 3, what is the previous color
      float b1 = brightness(current);
      float b2 = brightness(previous);
      float diff = abs(b1-b2);
      if (diff > diffIrImageThreshold) { 
        movements++;
      }
    }
  }
  
  if (movements > movementsCountNeeded) {
    changeSituation();
  }
  
  
//  if (movements > 1000) {
//    resetMovementCounter();
//    //println("yep there is some movement");
//  } else {
//    movementStopTimeCounter++;
//    //println("ok, no movemetns");
//  }
//  
//  println(movementStopTimeCounter);
//  
//  if (movementStopTimeCounter > framesToChangeSituation) {
//    changeSituation();
//    resetMovementCounter();
//  }
  
}

void takePicture() {
  PImage screen = get();
  image(screen, 0, 0);
}


void resetMovementCounter() {
  movementStopTimeCounter = 0;
}

void updateColor() {
  if (frameCount % 3 == 0) {
    colors+=colorStep;
    if (colors > maxColor || colors < minColor) {
      //colors = minColor;
      colorStep = -1*colorStep;
    }
  }
}

