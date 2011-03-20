
import processing.opengl.*;

PFont font;


String tex = "World can't be better than it is.";
float sizes[] = new float[tex.length()];

float W;

void setup(){
    size(600,150,OPENGL);

    for(int i= 0;i<sizes.length;i++){
        sizes[i] = random(12,32);
    }

    W = width;

    font = createFont("Ubuntu",92,true);
    fill(0);
    //textMode(SCREEN);
    hint(ENABLE_NATIVE_FONTS);
}


void draw(){
    background(255);

    float x =  0;

    for(int i = 0 ; i<tex.length();i++){
        textFont(font,sizes[i]);

        x+=textWidth(tex.charAt(i));

        sizes[i] = noise((frameCount+i)/(30.0+i))*92; //noise(frameCount/80.0) * noise((frameCount)/(30.0+i)) * 32;

    }

    W = x;

    pushMatrix();
    translate(0,height/2);
    scale(width/W);


    x = 0;    
    for(int i = 0 ; i<tex.length();i++){
        textFont(font,sizes[i]);
        text(tex.charAt(i),x,0);
        x+=textWidth(tex.charAt(i));
    }



    popMatrix();


}
