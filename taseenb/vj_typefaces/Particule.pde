class Particule 
{
  // Membres (variable de la classe)
  float x=0;
  float y=0;
  float z=0;
  float xStart=0;
  float yStart=0;
  float zStart=0;
  float d=5;
  color c;
  float vx = 0;
  float vy = 0;
  float vz = 0;
  
  // Constructeur
  Particule(float x_, float y_) {
    x = x_;
    y = y_;
    xStart = x_;
    yStart = y_;
    d = random(5,20);
    c = color(random(255), random(255), random(255));
    vx = random(-1,1);
    vy = random(-1,1);
  }
  
  Particule(float x_, float y_, float z_) {
    x = x_;
    y = y_;
    z = z_;
    xStart = x_;
    yStart = y_;
    zStart = z_;
    d = random(5,20);
    c = color(random(255), random(255), random(255));
    vx = random(-0.2,0.2);
    vy = random(-0.5,0.5);
    vz = random(-0.2,0.2);
  }

  // Methodes
  void display() {
    //fill(c);
    
    // acceleration
    if (vy>4) {
      x = xStart;
      y = yStart;
      z = zStart;
      vy = random(-0.5,0.5);
    }
    vy += sa.getMicroLevel()*5;
    
    //else {
    //  vy += sa.getMicroLevel()*4;
    //}
    
    //println(vy);
    
    // vitesse (changer la position)
    x += vx;
    y += vy;
    z += vz;
    
    //soundLevel = map(sa.getFFTLevel(8), 0,40, 0,500);
    
    //z += map(sa.getFFTLevel(8), 0,40, 0,500);
    
    //d = sa.getMicroLevel()*40+5;
    
    if (x+d/2>width) {
      x = width-d/2;
      vx = -vx;
    }
    if (x-d/2<0) {
      x = d/2;
      vx = -vx;
    }
    if (y+d/2>height) {
      y = height-d/2;
      vy = -vy;
    }
    if (y-d/2<0) {
      y = d/2;
      vy = -vy;
    }
    
//    if (mode==2) {
//      pushStyle();
//        noFill();
//        stroke(255);
//        pushMatrix();
//          translate(x, y, z);
//          rotateZ(z);
//          rotateX(x);
//          box(d/2);
//        popMatrix();
//      popStyle();
//    }
    
    if (mode==5) {
      pushStyle();
        noFill();
        stroke(myColor, 0, 100, 100);
        pushMatrix();
          translate(x, y, z);
          rotateZ(z);
          rotateX(x);
          box(d/2);
        popMatrix();
      popStyle();
    }
    
    //ellipse(x, y, d, d);
  }
  
};



