int num = 33;
int len = 15;
float maxSpeed = 5;
float dens = 0.3;
float R = 200.0;

float precision = 70;

boolean running = false;
boolean attract = false;

ArrayList c = new ArrayList(0);



void setup() {
  size(512,512,P2D);
  /* for(int i = 0 ;  i < num;i++) {
   c.add(new Castice());
   }*/
  background(0);
  textFont(createFont("Verdana",11,true));
  textMode(SCREEN);
  textAlign(CENTER);
  noSmooth();
}

void keyPressed() {

  save("screen.png");
}

void draw() {
  background(0);

  if(!running) {
    fill(255);
    text("Click to cast creatures!",width/2,height/2);
  }

  for(int i = 0 ; i < c.size();i++) {
    Castice tmp = (Castice)c.get(i); 
    tmp.draw();
  }
}

void mousePressed() {

  if(mouseButton==LEFT) {
    running = true;
    color tmp = color(random(12,255),random(12,127),random(12,23));
    for(int i = 0 ;  i < num;i++) {
      c.add(new Castice(mouseX,mouseY,tmp));
    }
  }
  else if(mouseButton==RIGHT) {
    attract = true;
  }
}

void mouseReleased() {
  attract = false;
}

