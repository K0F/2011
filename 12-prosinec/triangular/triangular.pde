import org.processing.wiki.triangulate.*;


/**
triangulation taken from http://wiki.processing.org/w/Triangulation
@author Tom Carden, Nicolas Clavaud
*/
 
import org.processing.wiki.triangulate.*;
 
ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();
 
void setup() {
  size(1280, 720,P2D);
  smooth();
  noiseSeed(19);
  //noLoop();
 
  // fill the points Vector with points from a spiral
  float r = 1.0;
  float rv = 1.01;
  float a = 0.0;
  float av = 0.75;
  
  points = new ArrayList();
 
  while(r < min(width,height)/2.0) {
    points.add(new PVector(width/2 + r*cos(a), height/2 + r*sin(a), 0));
    a += av;
    r *= rv;
  }
 
  // get the triangulated mesh
  triangles = Triangulate.triangulate(points);
  background(255);
}
 
void draw() {
 
 // background(255);
 
  // draw points as red dots   
  //blend(g,0,0,width,height,0,0,width,height,ADD);
 
  
   
  
  noStroke();
  fill(255, 0, 0);
 
  
 
  
   // fill the points Vector with points from a spiral
  float r = 1.0;
  float rv = 1.01+noise(frameCount/1000.0)/2.;
  float a = noise(frameCount/300.0);
  float av = sin(frameCount/20000.0)+0.3;
  
  points = new ArrayList();
 
  while(r < min(width,height)/2.0) {
    points.add(new PVector(width/2 + r*cos(a), height/2 + r*sin(a), 0));
    a += av;
    r *= rv;
  }
  
  triangles = Triangulate.triangulate(points);
 
  // draw the mesh of triangles
  stroke(0, 40);
  fill(255, 40);
  beginShape(TRIANGLES);
 
  
 
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    noFill();
    strokeWeight(random(1,2));
    stroke(0,noise(i+frameCount/80.0)*255);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  
   float nX = (-.5+noise(-frameCount/30.))*20.;
  float nY = (-.5+noise(frameCount/30.))*20.;
  
  blend(g,0,0,width,height,0+(int)(nX/2.),0+(int)nY,width+(int)nX,height+(int)nY,ADD );
  
  filter(BLUR,random(1,2));
  blend(g,0,0,width,height,0+(int)(nX/2.),0+(int)nY,width+(int)nX,height+(int)nY,MULTIPLY);
  
  saveFrame("/archive/kof/last12");
  
}

