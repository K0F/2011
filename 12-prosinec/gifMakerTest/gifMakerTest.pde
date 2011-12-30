import gifAnimation.*;
GifMaker gifExport;


void setup(){
  size(32,128,P2D);
  
  frameRate(60);
  
  gifExport = new GifMaker(this, "/home/kof/www/export.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setTransparent(0,0,0); // make black the transparent color. every black pixel in the animation will be transparent
  // GIF doesn't know have alpha values like processing. a pixel can only be totally transparent or totally opaque.
  // set the processing background and the transparent gif color to the same value as the gifs destination background color 
  // (e.g. the website bg-color). Like this you can have the antialiasing from processing in the gif.
  
  rectMode(CENTER);
  
  loadPixels();
}

float speed = 5.0;

void draw(){
  background(0);
  
  
  

  for(int y = 0 ; y< height;y++){
    for(int x = 0 ; x< width;x++){
      
      int i =  y*width+x;  
      int X = x,Y = y;
      /*
      if(x<width/2 && y < height/2){
       X = x; Y = y;  
      }else if(x > width/2 && y < height / 2){
       X = (width-x-1); Y = (y);
      }else if(x < width/2 && y > height / 2){
        X = (x); Y = (width-y-1);
      }else if(x > width/2 && y > height / 2){
        X = (width-x-1); Y = (width-y-1);
      }
      */
      pixels[i] = color(  (X^Y+frameCount*16+x|Y)%255 );//(random(255));
    }  
    
  }
  
  updatePixels();

  
  
  
  if(frameCount>=height-1){
    gifExport.finish();
  exit(); 
  }
  
 /*
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(frameCount/speed);
  rect(0,0,20,20);
  
  popMatrix();
  */
  
 gifExport.setDelay(1);
  gifExport.addFrame(); 
  
}


void keyPressed() {
  gifExport.finish();
  exit();
}
