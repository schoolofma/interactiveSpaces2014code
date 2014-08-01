class Agent {
  PVector p, pOld, reallyOldP;
  float stepSize, angle;
  boolean visible = false;

  // -- goback animation -- (redraw the camera image)
  float goBackTransition;
  float goBackTransitionSpeed = 0.005;
  float goBackEasing = -0.01;
  
  
  // -- decompose animation //
  float noiseFloat = 0.0;
  
  
  Agent(float x, float y, boolean visible_) {
    p = new PVector(x, y);
    pOld = new PVector(p.x,p.y);
    stepSize = random(0.02, 4);
    visible = visible_;
  }
  
  
  /**/
  /* Simply draw the agent at the given point. */
  /**/
  void updateLinear(float x, float y) {
    reallyOldP = p.get();
    p.x = x;
    p.y = y;
    drawAgents(false);
  }
  
  void updateLinearFat(float x, float y) {
    reallyOldP = p.get();
    p.x = x;
    p.y = y;
    //stroke(colors, 100, 100, 70);
    stroke(colors, 100, 0, 70);
    fill(0, 0, 100, 100);
    rect(p.x,p.y, 10, 10);
  }


  /**/
  /* Add noise to points and move them away from the original position. */
  /**/
  void updateDecompose(float x, float y, int id) {
    //reallyOldP = p.get();
    
    goBackTransition = 0;
    
    if (visible) {  
      // EFFECT 1
      //noiseScale = noiseScale+id/1000;
      angle = noise(p.x/noiseScale,p.y/noiseScale) * noiseStrength;

//      // EFFECT 2
//      // angle = noise(p.x/noiseScale,p.y/noiseScale) * 24;
//      // angle = (angle - int(angle)) * noiseStrength;

      p.x += cos(angle) * stepSize;
      p.y += sin(angle) * stepSize;
      
      drawAgents(true);
    }
  }
  
  
  /**/
  /* Bring point back to one of the points cloud positions. */
  /**/
  void updateGoBack(float x, float y) {
    reallyOldP = p.get();
    
    if (visible) {
      
      PVector destination = new PVector(x, y);

      if (destination.dist(p) < 4) {
        updateLinear(x, y);
        return;
      }
      
      if (goBackTransition < 1) {
        float d = 1 - goBackTransition;
        if(abs(d) > 1) {
            goBackTransition += d * goBackEasing;
          }
        goBackTransition += goBackTransitionSpeed;
      } else {
        goBackTransition = 1;
      }
      
      p = PVector.lerp(p, destination, goBackTransition);
      
      drawAgents(false);
    
     }
  }
  
  
//  void updateDelay(float x, float y) {
//    reallyOldP = p.get();
//    
//    if (visible) {
//      
//    }
//  }
  
  
  /**/
  /* Draw agent. */
  /**/
  void drawAgents(boolean lines) {
    
    //fill(0,0,255, 50);//blue
    //fill(0, 20);
    //fill(0, 255, 0, 20);
    //fill(colors, 70, 100, 20);
    fill(colors, 70, 0, 20);
    //ellipse(p.x,p.y, 4, 4);
    rect(p.x,p.y, 5, 5);
    
//    if (lines) {
//      // stroke(10, 50);
//      // strokeWeight(strokeWidth);
//      // line(pOld.x,pOld.y, p.x,p.y);
//      
//      fill(0,0,255, 50);
//      ellipse(p.x,p.y, 4, 4);
//      
//    } else {
//      fill(0,0,255, 50);
//      ellipse(p.x,p.y, 4, 4);
//    }
    
    //pOld.set(p);
    //pOld = p.get();
  }
  
  
//  float getDist() {
//    println(pOld, p);
//    return PVector.dist(pOld, p);
//  }
  

}



