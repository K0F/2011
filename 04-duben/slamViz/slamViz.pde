
import processing.opengl.*;


void setup(){
  
    
  
  size(1024,768,P2D);
  stroke(255);
  frameRate(30);

	textFont(createFont("Vernada",18,true));
	textMode(SCREEN);
}




void draw(){

  frame.setLocation(0,0);
  background(0);

	fill(255);

text("hello world!",mouseX,mouseY);


  
}

 public void init() {
  /// to make a frame not displayable, you can 
  // use frame.removeNotify() 
  
  frame.removeNotify(); 
 
  frame.setUndecorated(true); 
  
 
  // addNotify, here i am not sure if you have  
  // to add notify again.   
  frame.addNotify(); 
  super.init();
}
