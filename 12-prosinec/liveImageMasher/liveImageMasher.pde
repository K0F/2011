/**
 *       by kof 2011 copyleft
 */


TheEngine engine;

void setup() {
 
  size(640, 480 ,P2D);

  engine = new TheEngine();

  engine.addImage("kof.jpg");

}


void draw() {
	background(0);
 
	engine.draw(); 

}

