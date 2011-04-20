Hashtable c;

int num = 400;

int len = 15;

float maxSpeed = 5;

float dens = 0.2;

float R = 300.0;





void setup() {
  size(512,512,P2D);

c = new Hashtable(num,10);

for (int i = 0; i <= num; i++)
  {
    Integer integer = new Integer ( i );
    c.put( integer, new Castice());
  }


  background(0);
}



void draw() {

  background(0);

for (Enumeration e = c.keys(); e.hasMoreElements();)
  {
    Castice tmp = (Castice)(c.get(e.nextElement()));
    tmp.draw();
  }
}


