int w = 640;
int h = 480;
color c = color(255);

int mn = 2;
int mx = 3;

void setup() {

  size(w,h,P2D);
  background(0);  
  loadPixels();
}

int idx = 1;

void draw() {
  c = color(noise(frameCount/20.0)*255,noise(frameCount/20.1)*255,noise(frameCount/20.2)*255,10);

  for(int i =0;i<(int)(w*h/mn);i++) {
    pixels[idx] = c;
    idx+=random(10)>5?mn:mx;
    if(idx>w*h)idx = 0;
  }
  updatePixels();
}

