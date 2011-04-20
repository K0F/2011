Hashtable hash;


int num = 80000;
float speed = 300.0;

float _x = 0;
float _y = 0;
float _z = 0;

void setup() {
size(1050,720,P2D);
rectMode(CENTER);
  // Start with ten, expand by ten when limit reached

  hash = new Hashtable(num,10);
  
  for (int i = 0; i <= num; i++)
  {
    Integer integer = new Integer ( i );
    hash.put( integer, new Rectangle(i));
  }
  background(0);
}


void draw() {
  
  speed = noise(frameCount/3000.0)*60.0;
  
  background(0);
  //tint(255,1);
  //g.filter(BLUR,0.6);
  //image(g,0,0);
  // Get all values
 // pushMatrix();
  //translate(width/2,height/2);
  //rotate(-radians(frameCount));
  //translate(-width/2,-height/2);
  int q = 1;
  for (Enumeration e = hash.keys(); e.hasMoreElements();)
  {
    Rectangle r = (Rectangle)(hash.get(e.nextElement()));
    r.draw(q++,_x,_y,_z);
    _x = r.x;
    _y = r.y;
     _z = r.z;
  }
  //popMatrix();
  
  
  saveFrame("/home/kof/Desktop/attractor/frame#####.png");
}


class Rectangle {
  float x,y,z,tx,ty,tz,id;
 color c; 


  Rectangle(int _id) {
    id = _id; 
    x=random(width);
    y=random(height);
    tx=random(width);
    ty=random(height);
    tz=random(height);
    c= color(random(255));
  }


  void draw(int q, float _x,float _y,float _z) {
    tx+=(_x-tx)/speed;
    ty+=(_y-ty)/speed;
    tz+=(_z-tz)/speed;
    x=cos((frameCount/(q/1000.0+tx)))*(width/2-(q/164.0+1))+width/2;
    y=sin((frameCount/(q/1000.0+ty)))*(height/2-(q/164.0+1))+height/2;
    z=sin((frameCount/(q/1000.0+tz)))*(height/2-(q/164.0+1))+height/2;
    //fill(c,10);
    stroke(c,40);
    strokeWeight(1+z/420);
    point(x,y);
  }
}

