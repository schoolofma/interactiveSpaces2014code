import SimpleOpenNI.*; 
SimpleOpenNI kinect;

ArrayList<PVector> handPositions;
PVector currentHand; 
PVector previousHand;

void setup() { 
  
  size(640, 480);
  kinect = new SimpleOpenNI(this); 
  kinect.setMirror(true);
  //enable depthMap generation 
  kinect.enableDepth(); 
  // enable hands + start gesture generation  
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);
  handPositions = new ArrayList();
  stroke(255, 0, 0); 
  strokeWeight(2);
}

void draw() { 
  kinect.update(); 
  image(kinect.depthImage(), 0, 0);

  for (int i = 1; i < handPositions.size(); i++) {
    currentHand = handPositions.get(i); 
    previousHand = handPositions.get(i-1); 
    PVector pA = new PVector();
    PVector pB = new PVector();
    kinect.convertRealWorldToProjective(currentHand, pA); 
    kinect.convertRealWorldToProjective(previousHand, pB); 
    line(pB.x, pB.y, pA.x, pA.y);
  }

}

// ----------------------------------------------------------------- // hand events

void onNewHand(SimpleOpenNI curContext,int handId,PVector pos){
  handPositions.add(pos);
}

void onTrackedHand(SimpleOpenNI curContext,int handId,PVector pos){
  handPositions.add(pos);
}

void onLostHand(SimpleOpenNI curContext,int handId){
  handPositions.clear(); 
}

// ----------------------------------------------------------------- // gesture events
void onCompletedGesture(SimpleOpenNI curContext,int gestureType, PVector pos){
  int handId = kinect.startTrackingHand(pos);
}

