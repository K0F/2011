
import processing.opengl.*;

PFont font;


String tex = "Counting of letters is quite useles, when you want to understand the meaning of the text.";
float sizes[] = new float[tex.length()];

float W;

void setup(){
    size(1024,150,OPENGL);

    for(int i= 0;i<sizes.length;i++){
        sizes[i] = random(12,32);
    }

    W = width;

    font = createFont("Aller",92,true);
    fill(255);
    //textMode(SCREEN);
    //hint(ENABLE_NATIVE_FONTS);
}


void draw(){
    background(0);

    float x = 0;

    for(int i = 0 ; i<tex.length() ; i++){
        sizes[i] = noise((frameCount)/((int)tex.charAt(i)/2.0))*92; //noise(frameCount/80.0) * noise((frameCount)/(30.0+i)) * 32;
        textFont(font,sizes[i]);
        x+=textWidth(tex.charAt(i));
    }

    W = x;

    pushMatrix();
    translate(0,height-20);
    scale(width/W);

    x = 0;    
    for(int i = 0 ; i<tex.length() ; i++){
        textFont(font,sizes[i]);
        text(tex.charAt(i),x,0);
        x+=textWidth(tex.charAt(i));
    }



    popMatrix();


}
