/**
 *       by kof 2011 copyleft
 */

////////////////////////////////////////
////////  INFO 
////////////////////////////////////////
String name =  "kof.jpg";
int scaledown = 3;
String signature = "John von Neumann";
String quoteText = "quotes.txt";
////////////////////////////////////////

int [] pipeline = {2,6,8,2,6,8,2,6,12,2,13};

float speedPipeline = 2.5;

float speedGeneral = 10.5;

float tras = 20.0;
float al = 40;
float ubytek = 1.1;

float skvrneni = 12;


int step = 8;
float blursteep = 1.4;

boolean showText = false;
boolean drawBackground = true;

///////////////////////////////////////
/*
1: BLEND - linear interpolation of colours: C = A*factor + B
2: ADD - additive blending with white clip: C = min(A*factor + B, 255)
3: SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
4: DARKEST - only the darkest colour succeeds: C = min(A*factor, B)
5: LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)
6: DIFFERENCE - subtract colors from underlying image.
7: EXCLUSION - similar to DIFFERENCE, but less extreme.
8: MULTIPLY - Multiply the colors, result will always be darker.
9: SCREEN - Opposite multiply, uses inverse values of the colors.
10: OVERLAY - A mix of MULTIPLY and SCREEN. Multiplies dark values, and screens light values.
11: HARD_LIGHT - SCREEN when greater than 50% gray, MULTIPLY when lower.
12: SOFT_LIGHT - Mix of DARKEST and LIGHTEST. Works like OVERLAY, but not as harsh.
13: DODGE - Lightens light tones and increases contrast, ignores darks. Called "Color Dodge" in Illustrator and Photoshop.
14: BURN - Darker areas are applied, increasing contrast, ignores lights. Called "Color Burn" in Illustrator and Photoshop.
*/

PImage img;
String[] txt;

int sel  =0;
int t = 0, p = 0;
boolean fadeIn = true;
boolean fadeOut;
boolean pause = true;

int pauseLen = 10;

PGraphics steps[];



void setup() {

  
  img = loadImage(name);
  
  size(img.width/scaledown, img.height/scaledown,P2D);
  
  noiseSeed(19);

  noSmooth();

  txt = loadStrings(quoteText);

  for(int i =0 ;i<txt.length;i++)
  if(txt[i].length()==0)
  txt[i]+="   ";

  img = loadImage(name);

  steps = new PGraphics[step];

  //textFont(loadFont(sketchPath+"/data/SempliceRegular.vlw"));
  textFont(createFont("SempliceRegular",8,false));
  textMode(SCREEN);
  textAlign(CENTER);

  for (int i =0  ; i < steps.length;i++) {
    steps[i] = createGraphics(width, height, P2D);
    steps[i].beginDraw();


    //steps[i].tint(i%2==0?#FFCCCC:#CCFFAA, 200);
    steps[i].image(img, 0, 0, width, height);


    for (int q = 0;q<width*height;q+=(int)random(1,120)) {
      steps[i].strokeWeight(i*3+1);

      steps[i].stroke(0, random(skvrneni*i)+4);
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
  if(drawBackground)
 background(0);

  for (int i =0  ; i < steps.length;i++) {
    tint(255, noise((frameCount+i)/speedGeneral)*al-constrain(pow(i,ubytek),0,255));

      if(i==0)
    image(steps[i], (noise((frameCount+i^i)/speedGeneral)-0.5)*10.0, random(-2, 2), width, height);
    else
    blend(steps[i],
    (int)((noise((frameCount+i^i)/speedGeneral)-0.5)*tras), (int)random(-3.,3.),
    width,height,
    0, 0,
    width, height,
    pipeline[(int)(noise((frameCount+i)/(speedPipeline))*pipeline.length)]);
    
  }

  noTint();
  
  
  if(showText) renderText();

}

void renderText(){
 
  if (t%(txt[sel].length()*8)==0) {
    t= 2;

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
    text(txt[sel], 10, height - 80, width-20, 130);
   
    text(signature, width/2, height-15);
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


