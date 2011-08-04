

void setup(){

    size(1600,900,P2D);

}



void draw(){
    background(0);
    stroke(#ffffff);
    line(0,frameCount%height,width,frameCount%height);
    line(frameCount%width,0,frameCount%width,height);

}
