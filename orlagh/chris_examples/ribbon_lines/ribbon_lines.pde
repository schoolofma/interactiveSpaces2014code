ArrayList <PVector>pts;

void setup() {
  pts = new ArrayList();

  size(500, 500);
}


void draw() {

  noStroke();
  float thickness = 5;
  
  for (int i = 1; i < pts.size (); i++) {
    
    float xA = pts.get(i-1).x;
    float yA = pts.get(i-1).y;
    float xB = pts.get(i).x;
    float yB = pts.get(i).y;

    beginShape(QUAD_STRIP);
      vertex(xA, yA+thickness);
      vertex(xA, yA-thickness);
      vertex(xB, yB+thickness);
      vertex(xB, yB-thickness);
    endShape();
  }
}

void mouseDragged() {
  pts.add( new PVector(mouseX, mouseY, 0));
}

