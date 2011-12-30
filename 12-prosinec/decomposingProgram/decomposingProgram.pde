
/////  GUI definition ////////
String values[] = {"x","y","w","h","r","g","b","a","speed"};
float mins[] = {0,0,1,1,0,0,0,0,1};
float maxs[] = {640,240,640,240,255,255,255,255,255};
GUI gui;
///////////////////////////


float x,y,w,h,r,g,b,a,speed;

void setup() {
  size(640,240);
  
  gui = new GUI(this,20,25,values,mins,maxs);
  }

void draw(){
 background(0);
 
  noStroke();
  fill(r,g,b,a*(sin(frameCount/speed-speed*TWO_PI)+1.0)/2.);
  rect(x,y,w,h);

  gui.draw(); 
}

