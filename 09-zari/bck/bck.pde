PVector pos[];

void setup(){
    size(128,128);

    pos = new Pvector[10];

    for(int i = 0 ; i < pos.length;i++)
        pos[i] = (int)new PVector((int)random(width),(int)random(height);)

}


void draw(){
    background(255);

    stroke(200);
    
    for(int i = 0;i<pos.length;i++){
        stroke(pos.x,pos.y);
        pos.y--;
        if(pos.y<0)pos.y=height;
    }

saveFrame("/desk/bck/fr####.png");

    if(frameCount==height){
        exit();
    }


}
