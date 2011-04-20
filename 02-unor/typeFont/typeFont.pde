
import geomerative.*;
 
ImgProc imgProc = new ImgProc();
RFont font;
 
 String fontName = "ChocolateDulce.ttf";
String inp = "", lastText;
String zin = "nepolapitená úzkost";
 
int fontSize = 120;
int currWord = 0;
 
int[] currFrame;
int[] prevFrame;
int[] tempFrame;
String[] words;
 
boolean newtext = true, auto = true, pauze = false;
 
ArrayList seekers, coords;
 
void reload(){
	zin = loadStrings("veta.txt")[0];
words = split(zin," ");


}

void setup() {
  size(800, 600, P2D);
reload();

	background(0);
  noCursor();
  RG.init(this);
  font = new RFont(fontName, fontSize, RFont.CENTER);
  seekers = new ArrayList();
  coords = new ArrayList();
  noStroke();
  noCursor();
  fill(0);
  frameRate(30);
 
  //imgProc
  currFrame = new int[width*height];
  prevFrame = new int[width*height];
  tempFrame = new int[width*height];
  for(int i=0; i<width*height; i++) {
    currFrame[i] = color(0);
    prevFrame[i] = color(0);
    tempFrame[i] = color(0);
  }
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
 
void draw() {
  
  frame.setLocation(1920,0);

  imgProc.blur(prevFrame, tempFrame, width, height);
  arraycopy(tempFrame, currFrame);
 
  if((frameCount == 1) && auto) {
    inp = words[currWord];
  }
 
  RGroup grp = font.toGroup(inp);
  RCommand.setSegmentLength(1);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RPoint[] pnts = grp.getPoints();
 
  if(pnts != null) {
    if(newtext) {
      coords = new ArrayList();
    }
    if(pnts.length > 0) {
      update(pnts.length, pnts, 4);
    }
    if(newtext) {
      newtext = false;
    }
 
    //add seekers if there are more points than seekers
    checkSeekerCount(pnts.length);
 
    if(auto) {
      if(arrived() == 100) {
        pauze = true;
      }
      if(arrived() == 0 && pauze && seekers.size() == 0){
        println("nieuw");
	
        if(currWord < words.length-1) {
          currWord++;
          inp = words[currWord];
        }
        else {
          currWord = 0;
        reload();  
	inp = words[currWord];
	
        }
        pauze = false;
      }
       
    }
  }
  else {
    seekers = new ArrayList();
  }
  if(inp != lastText) {
    newtext = true;
  }
  lastText = inp;
  imgProc.drawPixelArray(currFrame, 0, 0, width, height); 
  arraycopy(currFrame, prevFrame);
}

