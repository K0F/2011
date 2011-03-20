

Pix[] pix;

int sc = 2;
int W,H;
int w,h;
int[] xs = {
  -1,0,1,-1,1,-1,0,1
};
int[] ys = {
  -1,-1,-1,0,0,1,1,1
};

void setup() {

  size(400,200,P2D);
  W = width;
  H = height;
  w = W / sc;
  h = H / sc;

  int cnt = 0;
  pix = new Pix[w*h];
  for(int y = 0;y<h;y++) {
    for(int x = 0;x<w;x++) {

      pix[cnt] = new Pix(x*sc,y*sc,cnt);
      cnt++;
    }
  }


  noStroke();
}



void draw() {



  for(int i = 0;i<pix.length;i++) {
    pix[i].update();
  }
  
  for(int i = 0;i<pix.length;i++) {
    pix[i].draw();
  }
}

class Pix {
  int id,x,y;
  float val,val2;

  Pix(int _x,int _y,int _id) {
    id = _id;
    x = _x;
    y = _y;
    val2 = val = random(255);
  } 

  void update() {

    for(int i = 0;i<xs.length;i++) {
      float ext = getNVal(i); 
      
      int area = 10;
      
      if(
      x > w/2 - sc * area &&
      x < w/2 + sc * area &&
      y > h/2 - sc * area &&
      y < h/2 + sc * area
      ) {
        if(val>20)
        val2--;
        //continue;
      }
      
      if( abs(ext-val) < 127 ) {
        val2 -= (ext - val2) / 8.0;
      } 
      else {
        val2 += (ext - val2) / 8.0;
      }
    }
  }

  void draw() {
    fill(val);
    rect(x,y,sc,sc);
    val += (val2 - val) / 2.0;
  }

  float getNVal(int smer) {
    return pix[((ys[smer]+y+h)%h)*w+((xs[smer]+x+w)%w)].val;
  }
}

