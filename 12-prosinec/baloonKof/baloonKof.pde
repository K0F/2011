import processing.opengl.*;

/**
 *       by kof 2011 copyleft
 */

////////////////////////////////////////
////////  INFO 
////////////////////////////////////////
String name =  "majakovsky.jpg";
String signature = "<code>";
String quoteText = "quotes.txt";
////////////////////////////////////////

int [] pipeline = {HARD_LIGHT,ADD,SCREEN,SCREEN,DODGE,MULTIPLY,HARD_LIGHT};

float speedGeneral = 0.5;
float tras = 200.0;
float ubytek = 1.1;

/*
BLEND - linear interpolation of colours: C = A*factor + B
ADD - additive blending with white clip: C = min(A*factor + B, 255)
SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
DARKEST - only the darkest colour succeeds: C = min(A*factor, B)
LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)
DIFFERENCE - subtract colors from underlying image.
EXCLUSION - similar to DIFFERENCE, but less extreme.
MULTIPLY - Multiply the colors, result will always be darker.
SCREEN - Opposite multiply, uses inverse values of the colors.
OVERLAY - A mix of MULTIPLY and SCREEN. Multiplies dark values, and screens light values.
HARD_LIGHT - SCREEN when greater than 50% gray, MULTIPLY when lower.
SOFT_LIGHT - Mix of DARKEST and LIGHTEST. Works like OVERLAY, but not as harsh.
DODGE - Lightens light tones and increases contrast, ignores darks. Called "Color Dodge" in Illustrator and Photoshop.
BURN - Darker areas are applied, increasing contrast, ignores lights. Called "Color Burn" in Illustrator and Photoshop.

*/

PImage img;
String[] txt;

int sel  =0;
int t = 0, p = 0;
boolean fadeIn = true;
boolean fadeOut;
boolean pause = true;

int pauseLen = 10;

int step = 6;
PGraphics steps[];

float blursteep = 1.8;


void setup() {

  
  img = loadImage(name);
  
  size(img.width, img.height,P2D);
  
  noiseSeed(19);

  noSmooth();

  txt = loadStrings(quoteText);

  for(int i =0 ;i<txt.length;i++)
  if(txt[i].length()==0)
  txt[i]+="   ";

  img = loadImage(name);

  steps = new PGraphics[step];

  textFont(loadFont("SempliceRegular-8.vlw"));
  textMode(SCREEN);
  textAlign(LEFT);

  for (int i =0  ; i < steps.length;i++) {
    steps[i] = createGraphics(width, height, P2D);
    steps[i].beginDraw();


    //steps[i].tint(i%2==0?#FFCCCC:#CCFFAA, 200);
    steps[i].image(img, 0, 0, width, height);

steps[i].strokeWeight(2);

    for (int q = 0;q<width*height;q+=1) {
      steps[i].stroke(0, random(5*i)+4);
      steps[i].point((int)(q%width), (int)q/width);
    }

    steps[i].stroke(0);
    steps[i].noFill();
    steps[i].strokeWeight(20);
    steps[i].rect(0, 0, width, height);

    if (i>0)
      steps[i].filter(BLUR, (pow(i, blursteep)));
    steps[i].endDraw();
  }
  
  background(0);
}


void draw() {
  background(0);

  for (int i =0  ; i < steps.length;i++) {
    tint(255, noise((frameCount+i)/speedGeneral)*185-pow(i,ubytek));

      if(i==0)
    image(steps[i], (noise((frameCount+i^i)/speedGeneral)-0.5)*10.0, random(-2, 2), width, height);
    else
    blend(steps[i],
    (int)((noise((frameCount+i^i)/speedGeneral)-0.5)*tras), (int)random(-tras/2., tras/2.),
    width,height,
    0, 0,
    width, height,
    pipeline[(int)(noise((frameCount+i)/(speedGeneral+10.))*pipeline.length)]);
    
  }

  noTint();

  if (t%(txt[sel].length()*8)==0) {
    t= 1;

    sel++;

    if (sel>=txt.length)
      sel = 0;

    fadeIn = true;
     
  }

  if (!pause) {


    t++;

    if (fadeIn) {
      fill(255, constrain(t*2, 0, 255));
      if ((t*2)>=255)
        fadeIn = false;
    }
    else if (txt[sel].length()*8-t<255) {
      fill(255, txt[sel].length()*8-t);
      if(txt[sel].length()*8-t==0)
      pause = true;
    }
    else {
      fill(255);
    }
    //text(sel+": "+txt[sel], 10, height - 80, width-20, 130);
   
    //text(signature, width/2, height-15);
  }
  else {
    p++;
    
    if (p>=pauseLen) {
      println(p);
      t=0;
      p=0;
      pause = false;
    }
  }
}


