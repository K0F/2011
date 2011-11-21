import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

/**
 *  Harmonograph sketch for multiple players by kof 2011
 *  asemicConstruction, copyleft
 */

import oscP5.*;
import netP5.*;

Minim minim;
AudioInput in;



int port = 7777;


float smoothing = 8.0;

OscP5 oscP5;

float [] val = new float[31];

float[] ang, L, speed;
int num = 10;

float speedUP;

void setup() {

  size(800, 600, P2D);

  oscP5 = new OscP5(this, "239.0.0.1", port);
  
  minim = new Minim(this);
  minim.debugOn();



 for(int i =0 ; i < val.length ;i++){
   val[i] = 128; 
  }

  noiseSeed(19);

  ang = new float[num];
  L = new float[num];
  speed = new float[num];

  for (int i = 0 ; i < ang.length;i++) {
    ang[i] = i;
    L[i] = (400.0)/(4.0+i/100.0);
    speed[i] = 0.02-i/(2000.0);
  }

  noSmooth();


  background(0);
  stroke(255, 10);

  speedUP = HALF_PI * 1000.3;
  
  in = minim.getLineIn(Minim.STEREO, (int)(speedUP));
}


void draw() {


  pushStyle();
  strokeWeight(10);
  stroke(0);
  fill(0, 45);
  rect(0, 0, width, height);
  popStyle();

  pushMatrix();
  translate(map(val[0],0,255,0,width)-width/2, map(val[1],0,255,0,height)-height/2);


  //if(frameRate < 30)
  //speedUP --;
//println(in.right.get(20));
  for (int q = 0;q< map(val[5],0,255,0,speedUP) ;q++) {

    pushMatrix();
    translate(width/2, height/2);
    for (int i = 0 ; i < ang.length;i++) {


      //translate((noise(i*14530.0+frameCount/333.17)-0.5)*500.0/(i+400.0), (noise(i*3459.9231+frameCount/330.0)-0.5)*500.0/(i+1.0));

      float l = lerp(val[i+20],val[i+20]+L[i]+((sin(((frameCount+i*map(val[8],0,255,0,5000.0))/30.0 )-0.51)*(15.0+i/40.0))), map(val[30],0,255,0,1) );

      stroke(lerpColor(#222B38, color(val[2],val[3],val[4]), norm(i, ang.length, 0)),
      (sin((i*map(val[6],0,255,0,3993.3)+frameCount/map(val[7],0,255,2,60))*3.02)+1.0)*12.0 );
 //map(constrain(in.right.get(q)*10,-1,1),-0.5,0.5,0,1)<0.3?45:0 );
      
      ang[i]+=speed[i] + map(val[i+10],0,255,0,HALF_PI*1000.0);	
      rotate(ang[i]);
      line(0, 0, l, 0);
      translate(l, 0);
    }

    popMatrix();
  }

  popMatrix();

  //saveFrame("/desk/god/god#####.png");
  
  noStroke();
  fill(0);
  rect(0,height-val.length,100,val.length);
  stroke(#cccccc);
  
  for(int i =0 ; i < val.length;i++){
   line(0,height-val.length+i,map(val[i],0,255,0,100),height-val.length+i); 
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
 
  super.stop();
}
