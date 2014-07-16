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
  // enable hands + gesture generation  
  kinect.enableGesture(); 
  kinect.enableHands();
  kinect.addGesture("RaiseHand");
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
    line(previousHand.x, previousHand.y, currentHand.x, currentHand.y);
  }

}

// ----------------------------------------------------------------- // hand events

void onCreateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position); 
  handPositions.add(position);
}

void onUpdateHands(int handId, PVector position, float time) { 
  kinect.convertRealWorldToProjective(position, position); 
  handPositions.add(position);
}

void onDestroyHands(int handId, float time) { 
  handPositions.clear(); 
  kinect.addGesture("RaiseHand");
}

// ----------------------------------------------------------------- // gesture events

void onRecognizeGesture(String strGesture, PVector idPosition, PVector endPosition)
{
  kinect.startTrackingHands(endPosition); 
  kinect.removeGesture("RaiseHand");
}
