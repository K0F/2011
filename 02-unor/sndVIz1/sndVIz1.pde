 /**
*  SndViz by Krystof Pesek (kof), licensed under Creative Commons Attribution-Share Alike 3.0 license.
* if you leave this header, bend, share, spread the code, it is a freedom!
*
*   ,dPYb,                  ,dPYb,
*   IP'`Yb                  IP'`Yb
*   I8  8I                  I8  8I
*   I8  8bgg,               I8  8'
*   I8 dP" "8    ,ggggg,    I8 dP
*   I8d8bggP"   dP"  "Y8ggg I8dP
*   I8P' "Yb,  i8'    ,8I   I8P
*  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
*  88P      Y8P"Y8888P"    PI8"8888            * * * coding for life
*                           I8 `8,
*                           I8  `8,
*                           I8   8I
*                           I8   8I
*                           I8, ,8'
*                            "Y8P'
*/


import processing.opengl.*;
import javax.media.opengl.GL;
import ddf.minim.*;


//////////  list  ////////

/*

 Jan Jilek
 kvileni.txt
 youLikeSwing.txt
 
 Mrucziwak
 mrucziwak.txt
 
 Masha
 denik.txt
 kubice.txt
 
 Bohdan
	bohdan.txt 

 Monika
 ariela.txt
 krize.txt

 */

//////////  settings  ////////


String vystup[] = {"kvileni.txt","youLikeSwing.txt","mrucziwak.txt","denik.txt","kubice.txt","bohdan.txt","ariela.txt","krize.txt"};

String filename = "bohdan.txt";

int fontSize = 32;
float rad = 60;
float interval = 30;
int numOfSlov = 5;

float mn = 0.6;
float mx = 1.0;
float trig = 0.55;

boolean showText = true;
boolean kesliCary = true;
boolean trigger = false;

boolean control = true;

float lineW = 1.5;

//////////  globs  ////////

int start = 0;
float sc = 1.5;

ArrayList tmp = new ArrayList(0);
ArrayList pos = new ArrayList(0);


ArrayList texty = new ArrayList(0);
String [] raw;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

Minim minim;
AudioInput in;

PImage cur;

void keyPressed(){
	if(key=='0'){
		filename = vystup[0];
		showText = true;

	}else if(key=='1'){
                filename = vystup[1];

		showText = true;

        }else if(key=='2'){
                filename = vystup[2];
		showText = true;


        }else if(key=='3'){
                filename = vystup[3];

		showText = true;

        }else if(key=='4'){
                filename = vystup[4];
		showText = true;


        }else if(key=='5'){
                filename = vystup[5];
		showText = true;

        }else if(key=='6'){
                filename = vystup[6];
		showText = true;

        }else if(key=='7'){
                filename = vystup[7];
		showText = true;

        }else if(key =='t'){
		showText = false;
	}

	loadTex();	

}

//////////  setup  ////////

void setup()
{
  size(1024,768,OPENGL);

  frameRate(50);

  background(0);

  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl


  hint(DISABLE_OPENGL_2X_SMOOTH);

  minim = new Minim(this);
  minim.debugOn();

cur = loadImage("cursor.png");

noCursor();

  if(showText)
    textFont(createFont("Anviers",fontSize,true));
  //textMode(SCREEN);

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, (int)(width*sc));
  noSmooth();

  if(showText) {
    loadTex();
  }
	println("vse dobre");
}




void draw(){
  visual();
  drawText();
}

void mousePressed(){

  cursor(cur,1,1);


}

void mouseReleased(){
	noCursor();
}






//////////  functions  ////////

void visual() {
  float trsh = 0.012;
  noStroke();

  //start = 0;


  for(int i = 0; i < width/2 ; i++)
  {


    if(in.right.get(i)<0.01) {
      if(in.right.get(i+1)<0.01) {

        for(int q = 2;q<100;q++) {
          if(abs(in.right.get(i+q)-0)>trsh) {
            start = i;
            break;
          }
        }
        break;
      }
    }
  }



	trigger = false;
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    if(in.right.get(int(i))>trig)trigger=true;
    stroke(map(in.right.get(int(i)),mn,mx,0,255));
    line(i-start,0,i-start,height);
  }
}

void drawText() {
  if(showText && trigger) {
    if((frameCount%interval)==0) {
      tmp = new ArrayList(0);
      pos = new ArrayList(0);

      for(int i = 0;i<numOfSlov;i++) {
        String curr = (String)texty.get((int)random(texty.size()));
        tmp.add( curr );
        pos.add( new PVector(random(5,width-textWidth(curr)),random(fontSize,height-5)));
      }
    }


    for(int i = 0;i<tmp.size();i++) {
      String sl = (String)tmp.get(i);
      PVector _pos = (PVector)pos.get(i);
      fill(255,map(abs((frameCount%interval)-interval),0,interval,0,200));
      text(sl,_pos.x+(noise((frameCount+150*i)/20.0)-.5)*50,_pos.y+(noise((frameCount+450*i)/20.0)-.5)*50);
    }


	pushStyle();
    stroke(255,map(abs((frameCount%interval)-interval),0,interval,0,50));
    noFill();
    strokeWeight(lineW);


    if(kesliCary)
      for(int i = 0;i<tmp.size();i++) {
        if(i==0)
          for(int ii = 0;ii<tmp.size();ii++) {
            //if(i==ii)continue;
		String sl = (String)tmp.get(i);
            PVector _pos = (PVector)pos.get(i);
            PVector _pos2 = (PVector)pos.get(ii);


		if(control){
            specialLine(
            mouseX+(noise(frameCount/2.0)-.5)*5,
            mouseY+(noise((frameCount+50)/2.0)-.5)*5,
            _pos2.x+textWidth(sl)/2.0+(noise((frameCount+150*ii)/20.0)-.5)*50,
            _pos2.y+(noise((frameCount+450*ii)/20.0)-.5)*50
            ,5);

		}else{

            specialLine(_pos.x+textWidth(sl)/2.0,_pos.y,_pos2.x+textWidth(sl)/2.0,_pos2.y,5);
		}

          }
      }
	popStyle();
  }
}

void loadTex() {
    raw = loadStrings(filename);

  for(int i = 0 ;i< raw.length;i++) {
    String slova[] = splitTokens(raw[i]," ,.;-_!?{}()0123456789  ");
    if(!slova.equals("")&&slova!=null)
      for(int q = 0;q<slova.length;q++) {
        texty.add(slova[q].toUpperCase());
      }
  }
}

void specialLine(float _x, float _y,float _x2,float _y2,float step) {
  float d = dist(_x,_y,_x2,_y2);
  float px = _x;
  float py = _y;
  int cnt = 0;
  for(float f = 0;f<d;f+=step) {
    //if(cnt%2==0)continue;

    float p = norm(f,0,d);

    if(cnt%2==0 && f > rad) {
      line(lerp(_x,_x2,p),lerp(_y,_y2,p),px,py);
    }


    px = lerp(_x,_x2,p);
    py = lerp(_y,_y2,p);

    cnt++;
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

