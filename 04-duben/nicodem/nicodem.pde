import processing.opengl.*;

int num = 1000;
ArrayList n = new ArrayList();// n;

boolean record = true;
PImage src;


void setup(){
    size(640,380,OPENGL);
    //smooth();

    randomSeed(19);
    src = loadImage("quarterNeg.png");
     for(int i = 0 ; i< num; i++){
        n.add(new Nico());
    }//
    //println(PFont.list());
    textFont(createFont(PFont.list()[45],16));
    textAlign(CENTER);

    //tint(0,200);
}

void draw(){
    if(frameCount<10){
    
    background(255);
    fill(0);
    /*if(frameCount>90){
        fill(0,map(frameCount,90,100,255,0));
    }
    text("kof 11",width/2,height/2);
    */
    }else{
    background(0);

        if(frameCount%5 == 0)
            n.remove(0);

        for(int i = n.size()-1 ;i>0;i--){
            Nico tmp = (Nico)n.get(i);
            tmp.draw();
           // filter(BLUR,1.4);
            /*if(frameCount>200){
                filter(INVERT);
            }*/
        }

    //filter(INVERT); 

        //line(0,height/2,width,height/2);
        //line(width/2,0,width/2,height);
    }
    
        frame();
    if(record)
        saveFrame("/desk/nicodemNegatif/nico####.png");

    if(n.size()==0)
        exit();

}

void frame(){
    pushStyle();
    strokeWeight(10);
    noFill();
    stroke(0);
    rect(0,0,width,height);
    popStyle();
}

void mousePressed(){
    n.add(new Nico(mouseX,mouseY));

}


class Nico{
    float x,y,cx,cy;
    int id;
    float angle;
    float step;

    Nico(){
        x = random(-src.width,width+src.width);
        y = random(-src.height,height+src.height);

        cx = 12;

        cy = 83.5;
        angle = random(0,360);
        step = random(-100,100)/10.0;


    }

    Nico(float _x,float _y){
        x = _x;
        y = _y; 
        cx = 12;

        cy = 83.5; 
        angle = random(0,360);
        step = random(-100,100)/10.0;

   }

    void draw(){

        angle += step;
        pushMatrix();
        translate(x-cx,y-cy);
        pushMatrix();
        translate(cx,cy);
        rotate(radians(angle));


        image(src,-cx,-cy);
        popMatrix();
        popMatrix();
    }
}
