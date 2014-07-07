import geomerative.*;
boolean TypoManager_isGeomerativeInit = false;
class TypoManager
{
  // programme parent
  PApplet applet;

  // Variable qui va stocker notre fonte TTF
  RFont fonte;

  // Forme du texte
  RShape forme;
  
  // Liste des points
  PVector[] listePoints;

  // Liste des points par forme
  PVector[][] listePointsShape;
  
  TypoManager(PApplet applet_, String fontName_, String texte, float segmentLength){
    this.applet = applet_;
    if (TypoManager_isGeomerativeInit == false){
      TypoManager_isGeomerativeInit = true;
      RG.init(applet);
    }
   
    fonte = new RFont(fontName_, 200, RFont.CENTER);
    RCommand.setSegmentLength(segmentLength);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

    forme= fonte.toShape(texte);
    forme = RG.centerIn(forme,applet.g,50);

    RPoint[] points = forme.getPoints();
    listePoints = new PVector[points.length];
    for (int i=0;i<points.length;i++){
      listePoints[i] = new PVector( points[i].x+width/2,points[i].y+height/2 );
    }
    
    RPoint[][] pointsShape = forme.getPointsInPaths();
    RPoint p,t;
    
    listePointsShape = new PVector[pointsShape.length][];

    for (int i=0;i<pointsShape.length;i++)
    {
      listePointsShape[i] = new PVector[pointsShape[i].length];
      for (int j=0;j<pointsShape[i].length;j++){
        listePointsShape[i][j] = new PVector(pointsShape[i][j].x+width/2, pointsShape[i][j].y+height/2);
      }
    }    
    
  }
  
  int shapesNb()
  {
    return listePointsShape.length;
  }

  PVector[] shape(int i)
  {
    if (i<shapesNb())
     return listePointsShape[i];
    return null;
  }
  
  void drawPoints()
  {
    for (int i=0;i<listePoints.length;i++){
      ellipse(listePoints[i].x,listePoints[i].y,5,5);
    }
  }

  void drawShapes()
  {
    PVector p;
    int i,j;
  for (i=0;i<listePointsShape.length;i++)
  {
    noFill();
    beginShape();
    for (j=0;j<listePointsShape[i].length;j++)
    {
       p = listePointsShape[i][j];
        vertex(p.x,p.y);
    }
    
    vertex(listePointsShape[i][0].x,listePointsShape[i][0].y);

    endShape();
  }
  }
}
