import processing.opengl.*;

void setup(){
    size(1280,720,OPENGL);
    hint(ENABLE_OPENGL_4X_SMOOTH);


}



void draw(){



    background(0);
   

    pushMatrix();
    translate(width/2,height/2,-width/2);
    rotateY(radians(frameCount*2));
    
    translate(-width/2,-height/2,width/2);
    noFill();//fill(255,15);
    stroke(255,15);
    for(int i = 0;i<5000;i++){
        pushMatrix();

float x =  noise(i+frameCount/60.0+8746)*width;
float y = noise(i+frameCount/80.0+2939)*height;
float z = -noise(i+frameCount/98.9)*width;

        translate( x,y,z );
        strokeWeight(map(modelZ(x,x,0),-height,0,5,1.8));

        box(noise(i+frameCount/30.0)*60);
        popMatrix();
    }

    popMatrix();

}
