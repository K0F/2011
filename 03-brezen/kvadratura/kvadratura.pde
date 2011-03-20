

boolean rec = true;
Misery [] m;

void setup(){
    if(rec)
        size(1280,720,P2D);
        else
  size(128,128,P2D); 

  m = new Misery[width*height];
  
  for(int y = 0 ;y< height;y++){
    for(int x = 0 ;x< width;x++){ 
      m[y*width+x] = new Misery(x,y);
      
    }
  }

}

void draw(){
  
 for(int y = 0 ;y< height;y++){
    for(int x = 0 ;x< width;x++){ 
      m[y*width+x].draw();
      
    }
  } 

  if(rec)
      saveFrame("/desk/opto/opto####.png");
}

class Misery{
  float timer = 0;
  int x,y;
  float speed = 10.0;
  

  Misery(int _x,int _y){
    x = _x;
    y = _y;
    speed = 5;//cos(y/(80.0+y))*2;//+sin(y)*height/2;//random(10,11);
  } 

  void draw(){
    stroke(sin(timer/speed)*127+127);
    speed = atan(constrain(dist(width/2.0,height/2.0,x,y),0,10000)/((sin(frameCount/300.0)+1.1)*300.0))*5.0;
    timer++;
    
    point(x,y); 

  }

}

