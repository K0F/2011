

/* Image Masher class
 *	live visualpha mashing by kof 2011
 */

class ImageMasher implements Runnable {

  ArrayList pipeline = new ArrayList();

  PVector pos;
  
  int maxW = 450;

  float x, y;

  float R,G,B;

  int scaledown = 1;

  float blink_speed = 2.5;

  float shake_speed = 10.5;

  float amplitude = 20.0;
  float alpha = 40;
  float effect_smooth = 1.1;

  float skvrneni = 3;

  int step = 7;
  float blurstep = 1.5;

  boolean showText = false;
  boolean drawBackground = false;
  

  String name;

  ////////// available filters /////////////////////////////
  /*
	1: BLEND - linear interpolation of colours: C = A*factor + B
   	2: ADD - additive blending with white clip: C = min(A*factor + B, 255)
   	3: SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
   	4: DARKEST - only the darkest colour succeeds: C = min(A*factor, B)
   	5: LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)
   	6: DIFFERENCE - subtract colors from underlying image.
   	7: EXCLUSION - similar to DIFFERENCE, but less extreme.
   	8: MULTIPLY - Multiply the colors, result will alphaways be darker.
   	9: SCREEN - Opposite multiply, uses inverse valphaues of the colors.
   	10: OVERLAY - A mix of MULTIPLY and SCREEN. Multiplies dark valphaues, and screens light valphaues.
   	11: HARD_LIGHT - SCREEN when greater than 50% gray, MULTIPLY when lower.
   	12: SOFT_LIGHT - Mix of DARKEST and LIGHTEST. Works like OVERLAY, but not as harsh.
   	13: DODGE - Lightens light tones and increases conshaket, ignores darks. Calphaled "Color Dodge" in Illustrator and Photoshop.
   	14: BURN - Darker areas are applied, increasing conshaket, ignores lights. Calphaled "Color Burn" in Illustrator and Photoshop.
   	 */

  PImage img;

  int sel  =0;
  int t = 0, p = 0;
  boolean fadeIn = true;
  boolean fadeOut;
  boolean pause = true;

  int pauseLen = 10;

  PGraphics steps[];

  boolean ready = false;

  int id;
  
  float percent = 0;

  ImageMasher(int _id, String _filename) {

    name = ""+_filename;
    id = _id;
    x = width/2;
    y = height/2;




    // obligatory 19
    noiseSeed(19);
  }


  ImageMasher(int _id, PImage _img) {
    img = _img;
    name = _id+"";
    id = _id;
    x = width/2;
    y = height/2;


    // obligatory 19
    noiseSeed(19);
  }

  void addFilter(int _in) {
    //println("adding filter "+pipeline.size());
    pipeline.add(_in);
  }

  public boolean isReady() {
    return ready;
  }

  void run() {
    img = loadImage(name);

    while (img.width/ (scaledown+.0)>maxW) {
      scaledown++;
    }

    steps = new PGraphics[step];

    //render blurring here
    preRender();

    //pipeline = new ArrayList();
    //pipeline.add(1);
  }


  /**
   	*	set new position to image
   	*/
  void setPos(float _x, float _y) {
    x=_x;
    y = _y;
  }

  /**
   	*	pre-prepare image
   	*/
  void preRender() {
    for (int i =0  ; i < steps.length;i++) {
     
      steps[i] = createGraphics(img.width/scaledown, img.height/scaledown, P2D);
      steps[i].beginDraw();


      //steps[i].tint(i%2==0?#FFCCCC:#CCFFAA, 200);
      steps[i].image(img, 0, 0, img.width/scaledown, img.height/scaledown);


      for (int q = 0;q<img.width/scaledown*img.height/scaledown;q+=(int)random(1,120)) {
        steps[i].strokeWeight(i*3+1);

        steps[i].stroke(0, random(skvrneni*i)+4);
        steps[i].point((int)(q%img.width/scaledown), (int)q/img.width/scaledown);
        
        ;
      }

      steps[i].stroke(0);
      steps[i].noFill();
      steps[i].strokeWeight(20);
      steps[i].rect(0, 0, img.width/scaledown, img.height/scaledown);

      if (i>0)
        steps[i].filter(BLUR, (pow(i, blurstep)));
      steps[i].endDraw();
      
      percent = map(i,0,steps.length-1,0,100);
       
    }

    ready = true;
  }



  /**
   	*	draw visualphas
   	*/
  void draw() {

    if (drawBackground)
      background(0);



    if (pipeline.size()>0)               
      for (int i =0  ; i < steps.length;i++) {
        tint(R,G,B, noise((frameCount+i)/shake_speed)*alpha-constrain(pow(i, effect_smooth), 0, 255));

        int curr = (int)(Integer)pipeline.get((int)(noise((frameCount+i)/(blink_speed))*pipeline.size()));

        if (i==0)
          image(steps[i], (noise((frameCount+i^i)/shake_speed)-0.5)*amplitude+x, y+((noise((frameCount+2000+i^i)/shake_speed)-0.5)*amplitude), steps[i].width, steps[i].height);
        else
          blend(steps[i], 
          0, 0, 
          steps[i].width, steps[i].height, 
          (int)((noise((frameCount+i^i)/shake_speed)-0.5)*amplitude)+(int)x, (int)y+(int)((noise((frameCount+2000+i^i)/shake_speed)-0.5)*amplitude), 
          steps[i].width, steps[i].height, 

          curr);
      }


    noTint();
  }
}

