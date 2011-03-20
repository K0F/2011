

PVector grav = new PVector(0,0);

float visc = 0.998;

float maxSpeed = 3.0;

float b =10;

int num = 200;
Weirdo w[] = new Weirdo[num];

void setup() {
  size(320,320,P2D);
  background(0);
  noFill();
  stroke(255);
  smooth();
  


  for(int i = 0;i<w.length;i++)
    w[i] = new Weirdo(i);
}



void draw() {
  tint(255,62);
  image(g,0.9,1);
  
  for(int i = 0;i<w.length;i++)
    w[i].update();
}

class Weirdo {
  PVector pos,acc,vel,lpos;
  int id;
float att;

  Weirdo(int _id) {
    id = _id;
    pos = new PVector(random(b,width-b),random(b,height-b));
    acc = new PVector(0,0);//random(-1,1),random(-1,1));
    vel = new PVector(0,0);
    lpos = new PVector(pos.x,pos.y);
    att = 0.01;
  }


  void update() {
   // att = (sin((frameCount+id)/30.0)-1.0);
    
     lpos = new PVector(pos.x,pos.y);
    pos.add(vel);
    vel.add(acc);
    vel.add(grav);
    vel.limit(maxSpeed);
    acc.mult(visc);
    
    border();

    for(int i = 0;i<w.length;i++) {
      if(w[i].id!=id ) {
        PVector dir = PVector.sub(w[i].pos,pos);
        dir.normalize();
        dir.mult(att);
        acc.add(dir);
      }
    }

    
    strokeWeight((vel.mag())/2+1);
    stroke(255,(maxSpeed-vel.mag())*200+40);
    line(pos.x,pos.y,lpos.x,lpos.y);
  }
  
  void border(){
   if(pos.x<b || pos.x>=width-b)
      vel.x *= -1;
     
     
   if(pos.y<b || pos.y>=height-b)
      vel.y *= -1; 
  }
  
  void nekonecno(){
   if (pos.x > width){
      lpos.x = pos.x = 0;
    }else if(pos.x < 0 ){
     lpos.x =  pos.x = width; 
    }
    
    if (pos.y > height){
      lpos.y = pos.y = 0;
    }else if(pos.y < 0 ){
     lpos.y = pos.y = height; 
    }
     
  }
}

