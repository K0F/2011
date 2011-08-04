int cntr = 0 ;
int frameSkip = 900;

void setup(){
    size(800*4,480);
    background(0);
    smooth();
    noiseSeed(19);
}


void draw(){
    for(int i = 0 ; i < frameSkip;i++){
        if(cntr%5000==0)
            filter(BLUR,0.6);

        pushMatrix();

        translate(noise(cntr/2000.0)*width*2-width/2,noise(cntr/200.0)*height*2-height/2);
        rotate(cntr/50.0);

        stroke(255,0,0,5*sin(cntr/3000.0));
        line(0,80,0,0);

        stroke(0,255,0,5*sin(cntr/3000.0));
        line(-80,0,0,0);

        popMatrix();

        cntr++;
    }
}

void keyPressed(){
    if(key=='s'){
        save("abstract.png");
    }
}




