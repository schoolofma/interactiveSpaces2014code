// M_1_5_02_TOOL.pde
// Agent.pde, GUI.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class Agent {
  PVector p, pOld;
  float stepSize, angle;
  boolean isOutside = false;

//  Agent() {
//    p = new PVector(random(width),random(height));
//    pOld = new PVector(p.x,p.y);
//    stepSize = random(1,5);
//  }
  
  Agent(float x, float y) {
    p = new PVector(x, y);
    pOld = new PVector(p.x,p.y);
    stepSize = random(0.05,0.2);
  }

  void update(){
    // EFFECT 1
    //angle = noise(p.x/noiseScale,p.y/noiseScale) * noiseStrength;
    
    // EFFECT 2
    angle = noise(p.x/noiseScale,p.y/noiseScale) * 24;
    angle = (angle - int(angle)) * noiseStrength;
    
    
    //stepSize +=0.01;

    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;
//    p.x += stepSize;
//    p.y += stepSize;

//    if(p.x<-10) isOutside = true;
//    else if(p.x>width+10) isOutside = true;
//    else if(p.y<-10) isOutside = true;
//    else if(p.y>height+10) isOutside = true;
//
//    if (isOutside) {
//      p.x = random(width);
//      p.y = random(height);
//      pOld.set(p);
//    }

    stroke(10);
    //strokeWeight(strokeWidth*stepSize);
    strokeWeight(strokeWidth);
    line(pOld.x,pOld.y, p.x,p.y);
    //ellipse(p.x,p.y, 4, 4);

    pOld.set(p);

    isOutside = false;
  }

}



