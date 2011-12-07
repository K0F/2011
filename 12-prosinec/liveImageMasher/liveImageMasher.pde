

/**
 *       by kof 2011 copyleft
 */


TheEngine engine;



void setup() {
 
  size(640, 480 ,P2D);

  engine = new TheEngine();
  
  engine.addImage("vertov2.jpg");
  engine.addImage("vertov3.jpg");
  
  background(0);

}


void draw() {
        rectMode(CORNER);
        noStroke();
	fill(0,5);
        rect(0,0,width,height);
        
	engine.draw(); 

}

