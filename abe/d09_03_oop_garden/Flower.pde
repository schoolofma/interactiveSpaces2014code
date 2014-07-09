class Flower {
  float x;
  float y;
  float radius;
  int currentHeight;

  // Time when the plant starts growing.
  // Before that, nothing.  
  int timeStart;
  
  // Time when it ends growing up, and it starts blossoming.
  int timeEndGrowingUp;
  
  // Time when it ends blossoming.
  int timeEndBlossom;
  
  // Time when it starts flying away.
  int timeEndLife;
  
  Flower(float tmpX, float tmpY) {
    x = tmpX;
    y = tmpY;
    currentHeight = 0;
    radius = 0;
    
    timeStart = (int)random(1000, 5000);
    // We force each time to be greater than the previous time,
    // so timeStart < timeEndGrowingUp < timeEndBlossom < timeEndLife
    timeEndGrowingUp = timeStart + (int)random(500, 1500);
    timeEndBlossom = timeEndGrowingUp + (int)random(100, 300);
    timeEndLife = timeEndBlossom + (int)random(3000, 5000);  
  }
  
  void draw() {
    if(millis() < timeStart) {
      // If it's too early for this flower, do nothing. Just get out.
      return;
    } else if(millis() < timeEndGrowingUp) {
      // If it's not too early, but we're not done growing up,
      // grow up.
      currentHeight += 1;      
    } else if(millis() < timeEndBlossom) {
      // If we're done growing up, but not done blossoming, blossom.
      radius += 2;
    } else if(millis() > timeEndLife) {
      // If we're too old, fly out
      x += 5;
    }
    
    // Draw stem
    strokeWeight(3);
    stroke(#22AA33); 
    line(x, y, x, y - currentHeight);
   
    // Draw petal
    noStroke();
    fill(#FF5522);
    ellipse(x, y - currentHeight, radius, radius);    
  }
}
