import peasy.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

SoundAnalysis sa;
Particule[] listeParticules;
TypoManager typo01;
PeasyCam cam;

float distSeuil = 60; // distance between particles for alpha value of lines

int mode = 3;
float myColor;
int bezControl = 30;
TypoManager[] myTypo;

double camAngle=0.001;

void setup() {
  //size(screenWidth,screenHeight, OPENGL);
  size(1024,768, OPENGL);
  smooth();
  cam = new PeasyCam(this, 0,0,0, 1250);
  
  //cam.setRollRotationMode();
  frameRate = 30;
  myTypo = new TypoManager[7];
  //String[] typos1 = {"N","b","O","B","I", "S","T"}; // invaders  
  //String[] typos1 = {"a","b","c","d","e", "f","g"}; // cats vs dogs
  //String[] typos1 = {"5","b","O","B","I", "S", "V"}; // faces
  String[] typos1 = {"{-}","@","531","Q","%", "Log", "$"};
  for (int i=0; i<typos1.length;i++) {
    //myTypo[i*2] = new TypoManager(this,"invaders.ttf",typos1[i],30);
    //myTypo[i*2] = new TypoManager(this,"catsvsdogs.ttf",typos1[i],30);
    //myTypo[i] = new TypoManager(this,"Faces.ttf",typos1[i],20);
    //myTypo[i] = new TypoManager(this,"Baskerville.ttf",typos1[i],20);
    myTypo[i] = new TypoManager(this,"Sanford.ttf",typos1[i],20);
    
  }
  go();
  colorMode(HSB, 255, 100, 100, 100);
  sa = new SoundAnalysis(this, 50); 
}


void draw() {
  sa.update();
  
  cam.rotateY(map(sa.getFFTLevel(32), 0,10, 0,0.33));
  cam.rotateZ(camAngle/4);
  cam.lookAt(0,0,0);
  
  if(sa.getFFTLevel(32)<2 && sa.getFFTLevel(32)>1.6){
    cam.reset(1000);
    go();
  }
  
  //println(sa.getFFTLevel(32));
  
  pushMatrix();
    translate(-(width/2), -(height/2));
    if (frameCount < 1 || frameCount % 600 == 0) {
      go();
    } else {
      background(0);
      if (mode == 1) {
        design1();
      } else if (mode == 2) {
        design2(); 
      } else if (mode == 3) {
        design3();
      } else if (mode == 4) {
        design4();
      } else if (mode == 5) {
        design5();
      } else if (mode == 6) {
        design6();
      }
    }
  popMatrix();
  
  if (frameCount % 200 == 0) {
      mode = (int)random(1,7);
  }
  
  //saveFrame(timestamp()+"_##.tiff");
  
}


//void controlEvent(ControlEvent theEvent) {
//  if (theEvent.getController().name().equals("Btn")) {
//    println("Restart!");
//    go();
//  }
//}


void go() {
  // get random index for typos array
  int randomChar = (int)random(myTypo.length);
  // get particules from typo
  int nbParticules = myTypo[randomChar].listePoints.length;
  listeParticules = new Particule[nbParticules];
  // set color
  setColor();
  // create particles
  for (int i=0; i<listeParticules.length; i++) {
    PVector p = myTypo[randomChar].listePoints[i];
    listeParticules[i] = new Particule(
      p.x, 
      p.y,
      random(-50,50)
    );
  }
}


void setColor() {
  myColor = random(0,255);
}

void mousePressed() {
  setColor();
  go();
}


void keyPressed() {
  if (key == '1') {
    mode = 1;
  } else if (key == '2') {
    mode = 2;
  } else if (key == '3') {
    mode = 3;
  } else if (key == '4') {
    mode = 4;
  } else if (key == '5') {
    mode = 5;
  } else if (key == '6') {
    mode = 6;
  }
}


void freqs() {
  float xFreq = map(sa.getFFTLevel(32), 0,40, 0,width);
  float micLevel = sa.getMicroLevel()*10;
  pushStyle();
  stroke(255,100,100,100);
  strokeWeight(10);
  popStyle();
  line(xFreq, height, xFreq, height-250);
}


void design1() {
    // draw
    distSeuil = 100;
    noFill();
    for (int i=0; i<listeParticules.length; i++) {
      listeParticules[i].display();
    }
    for (int i=0; i<listeParticules.length; i++) {
      for (int j=0; j<listeParticules.length; j++) {
        float d = dist(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z);
        if (d<distSeuil && d>1) {
          stroke(myColor,0,100,100-((d/distSeuil)*100));
          //line(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z); 
          line(
            //first point
            listeParticules[i].x, 
            listeParticules[i].y, 
            listeParticules[i].z,
            //second point
            listeParticules[j].x, 
            listeParticules[j].y, 
            listeParticules[j].z
          );
        } else {
          noStroke();
        }
      }
    }
}


void design2() {
    // draw
    distSeuil = 100;
    bezControl = 20;
    noFill();
    for (int i=0; i<listeParticules.length; i++) {
      listeParticules[i].display();
    }
    for (int i=0; i<listeParticules.length; i++) {
      for (int j=0; j<listeParticules.length; j++) {
        float d = dist(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z);
        if (d<distSeuil && d>1) {
          stroke(myColor,0,100,100-((d/distSeuil)*100));
          //line(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z); 
          curve(
            //first control point
            listeParticules[i].x-bezControl, 
            listeParticules[i].y-bezControl, 
            listeParticules[i].z-bezControl,
            //first point
            listeParticules[i].x, 
            listeParticules[i].y, 
            listeParticules[i].z,
            //second control point
            listeParticules[j].x+bezControl, 
            listeParticules[j].y+bezControl, 
            listeParticules[j].z+bezControl,
            //second point
            listeParticules[j].x, 
            listeParticules[j].y, 
            listeParticules[j].z
          );
        } else {
          noStroke();
        }
      }
    }
}


void design3() {
    // draw
    distSeuil = 100;
    bezControl = (int)random(-10, 10);
    
    noFill();
    for (int i=0; i<listeParticules.length; i++) {
      listeParticules[i].display();
    }
    for (int i=0; i<listeParticules.length; i++) {
      for (int j=0; j<listeParticules.length; j++) {
        float d = dist(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z);
        if (d<distSeuil && d>1) {
          //stroke(myColor,100,100,100-((d/distSeuil)*100));
          stroke(map(d,0,distSeuil,0,255),0,100,100-((d/distSeuil)*100));
          //line(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z); 
          bezier(
            //first control point
            listeParticules[i].x-bezControl, 
            listeParticules[i].y-bezControl, 
            listeParticules[i].z-bezControl,
            //first point
            listeParticules[i].x, 
            listeParticules[i].y, 
            listeParticules[i].z,
            //second control point
            listeParticules[j].x+bezControl, 
            listeParticules[j].y+bezControl, 
            listeParticules[j].z+bezControl,
            //second point
            listeParticules[j].x, 
            listeParticules[j].y, 
            listeParticules[j].z
          );
        } else {
          noStroke();
        }
      }
    }
}


void design4() {
    // draw
    distSeuil = 100;
    bezControl = 20;
    noFill();
    for (int i=0; i<listeParticules.length; i++) {
      listeParticules[i].display();
    }
    for (int i=0; i<listeParticules.length; i++) {
      for (int j=0; j<listeParticules.length; j++) {
        float d = dist(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z);
        if (d<distSeuil && d>1) {
          stroke(myColor,0,100,100-((d/distSeuil)*100));
          //line(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z); 
          bezier(
            //first control point
            listeParticules[i].x-random(-bezControl,bezControl), 
            listeParticules[i].y-random(-bezControl,bezControl), 
            listeParticules[i].z-random(-bezControl,bezControl),
            //first point
            listeParticules[i].x, 
            listeParticules[i].y, 
            listeParticules[i].z,
            //second control point
            listeParticules[j].x+random(-bezControl,bezControl), 
            listeParticules[j].y+random(-bezControl,bezControl), 
            listeParticules[j].z+random(-bezControl,bezControl),
            //second point
            listeParticules[j].x, 
            listeParticules[j].y, 
            listeParticules[j].z
          );
        } else {
          noStroke();
        }
      }
    }
}


void design5() {
    // draw
    distSeuil = 100;
    noFill();
    for (int i=0; i<listeParticules.length; i++) {
      listeParticules[i].display();
    }
}


void design6() {
    // draw
    distSeuil = 100;
    noFill();
    for (int i=0; i<listeParticules.length; i++) {
      listeParticules[i].display();
    }
    for (int i=0; i<listeParticules.length; i++) {
      for (int j=0; j<listeParticules.length; j++) {
        float d = dist(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z);
        if (d<distSeuil && d>1) {
          //stroke(myColor,100,100,100-((d/distSeuil)*100));
          //line(listeParticules[i].x, listeParticules[i].y, listeParticules[i].z, listeParticules[j].x, listeParticules[j].y, listeParticules[j].z); 
          
          stroke(map(d,0,distSeuil,0,255),0,100,100-((d/distSeuil)*100));
          line(
            //first point
            listeParticules[i].x, 
            listeParticules[i].y, 
            listeParticules[i].z,
            //second point
            listeParticules[j].x, 
            listeParticules[j].y, 
            listeParticules[j].z
          );
        } else {
          noStroke();
        }
      }
    }
}

//void keyReleased(){
//  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
//  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
//}

// timestamp
//String timestamp() {
//  Calendar now = Calendar.getInstance();
//  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
//}
