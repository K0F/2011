import processing.opengl.*;
import javax.media.opengl.GL;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

PImage obr,obr2;
boolean state = false;

void setup() {
  obr = loadImage("20110107_002.jpg");
  obr2 = loadImage("20110107_002.jpg");

  size(obr.width/4,obr.height/4,OPENGL); 


  obr.loadPixels();
  obr2.loadPixels();

pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl


  for(int y = 0;y < obr.height;y++) {
    for(int x = 0;x < obr.width;x++) {
      int idx = y * obr.width +x;
      int idx2= y * obr.width + (obr.width-x-1);
      obr2.pixels[idx] = obr.pixels[idx2];
    }
  }
}


void draw() {
  if(frameCount%3==0) {
    state = !state;
  }

  if(state) {
    image(obr,0,0,obr.width/4,obr.height/4);
  }
  else {
    image(obr2,0,0,obr.width/4,obr.height/4);
  }
  
  saveFrame("bura####.png");
}

