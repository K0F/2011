

int matiX[] = {-2,-1,0,1,2,-2,-1,0,1,2,-2,-1,1,2,-2,-1,0,1,2,-2,-1,0,1,2};
int matiY[] = {-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,0,0,0,0,1,1,1,1,1,2,2,2,2,2};

void setup(){
    size(320,240,P2D);
    background(0);
    colorMode(HSB);
}

void draw(){
    loadPixels();
    
    for(int i = 0; i < pixels.length;i++){
        pixels[i] = color(255,random(255),127);

        for(int sh = 0;sh < matiX.length;sh++){
            pixels[i] = lerpColor(pixels[i],pixels[(2+i+matiX[sh])%(pixels.length-1)],0.1);
        }

    }
}
