/**
 * oscP5parsing by andreas schlegel
 * example shows how to parse incoming osc messages "by hand".
 * it is recommended to take a look at oscP5plug for an
 * alternative and more convenient way to parse messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;
import processing.opengl.*;
import processing.opengl.*;
import javax.media.opengl.GL;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

OscP5 oscP5;
NetAddress myRemoteLocation;
float val[];
boolean received[];
float fade[];

int num = 10;



PGraphics rectangle;


void setup() {
  size(1920-1,1200-1,OPENGL);
  frameRate(120);

  val = new float[num];
  received = new boolean[num];
  fade = new float[num];


  for(int i = 0;i<num;i++) {
    val[i] = 0;
    received[i] = false;
    fade[i] = 255;
  }

  rectangle = createGraphics(119,60,JAVA2D);

  rectangle.beginDraw();
  rectangle.fill(255);
  rectangle.noStroke();
  rectangle.rect(10,10,rectangle.width-20,rectangle.height-20);
  rectangle.filter(BLUR,1.5);
  rectangle.endDraw();

  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  background(0);  
}

void draw() {
  //background(0);  

  fill(0,30);
  rect(0,0,width,height);


  for(int i = 0;i<num;i++) {
    if(received[i]) {
      fade[i] = 100;
    }

    tint(lerpColor(#FFCC00,#FFFFFF,map(val[i],0,(5+3)*32,0,1)),fade[i]);

    image(rectangle,map(i,0,num,20,width-20),height/2-rectangle.height/2+map(val[i],0,(5+3)*32,200,-200));


    fade[i] -= 3;

    if(frameCount%3==0)
      received[i] = false;
  }
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */

  //for(int i = 0;i<num;i++) {
    if(theOscMessage.checkAddrPattern("/bang")==true) {
      
      for(int i =0 ;i<num;i++){
      received[i] = true;
      val[i] = theOscMessage.get(i).floatValue();
        
      }
    }
  //}
}

