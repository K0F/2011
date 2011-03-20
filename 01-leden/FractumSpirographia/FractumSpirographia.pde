


void setup() {
  size(400,400,P2D);
  stroke(255,10);
  background(0);
}



float cnt = 1.0001;

void draw() {
  
  translate(width/2,height/2);
  rotate(-frameCount/1000.0);
  //for(int i = 0 ;i<200;i++){

  cnt += 0.00000000001;//*cnt;
  fractal(cnt,1000);
  
  
  //tint(255,5);
  //image(g,-width/2,-height/2,width/2,height/2);
  //}
}


void fractal(float k,float mez) {
  float x = 0;//sin(frameCount/10000.0);//*floor(random(1,10));
  float y = 1;//cos(frameCount/10000.0);//*floor(random(1,10));
  
  
  for(int i = 1;i<mez;i++) {

    x = (x + x + k);
    y = (y + y + k);
    
    
    //cnt+=(x+y-cnt)/1000000.0;

    //stroke(lerpColor(#ff0000,#ffcc00,map(i,0,mez,0.1,0.11)),10);
    stroke((sin((i+frameCount)/6.0)+1)/2*255,20);
    
    //  if(i%2==0)
    point(cos(x/1000.0)*(width/2-(sin(frameCount/300.0)+1)*width/2),
    sin(y/100000.0)*(height/2-(cos(frameCount/300.0)+1)*height/2))  ;
}
}

