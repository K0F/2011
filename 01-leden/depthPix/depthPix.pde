

int net[][][];
int cnt = 0;

float x,y;

void setup() {

  size(320,240,P2D);
  
  net = new int[width][height][255];


  for(int i = 0;i<net.length;i++) {
    for(int ii = 0;ii<net[i].length;ii++) {
      for(int iii = 0;iii<net[i][ii].length;iii++) {
        net[i][ii][iii] = (ii^i+iii^4)%255;//(int)random(255);
      }
    }
  }
  
  noSmooth();
  
  background(0);
}


void draw() {
  
  
  x = noise(frameCount/100.0)*width;
  y = noise(frameCount/101.1)*height;
  float f = (noise(frameCount/230.0))*30;

  for(int i = 0;i<net.length;i++) {
    for(int ii = 0;ii<net[i].length;ii++) {
      stroke(net[i][ii][(int)(((cnt+dist(i,ii,x,y))*f)%255)],60);
  
     //net[i][ii][(cnt+2)%net[0][0].length] = 255-net[i][ii][cnt];
      point(i,ii);
    }
   
  }
  
    cnt++;
  cnt=cnt%net[0][0].length;
  
}

