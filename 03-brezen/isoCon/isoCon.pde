
int speed = 2;

Postava p;

void setup(){
    size(320,240);

    p = new Postava();
    textFont(createFont("Verdana",9,false));
    imageMode(CENTER);
}

void draw(){
    background(255);

    p.show();


}


void keyPressed(){
    if(keyCode==LEFT){
        p.changeDir(0);
    }else if(keyCode==UP){
        p.changeDir(1);
    }else if(keyCode==RIGHT){
        p.changeDir(2);
    }else if(keyCode==DOWN){
        p.changeDir(3);
    }

    p.moving = true;

}

void keyReleased(){
    p.moving = false;

}




class Postava{
    ArrayList sprites = new ArrayList();
    Anim current;
    
    PGraphics shade;
    int curFaze = 0;
    float x,y;
    float moveSpeed = 1;
    int dir=0;
    boolean moving = false;
    float iso = 0.653;
    int w = 64;
    int h = 64;

    color c;


    Postava(){
        
        
        c = color(#ff0000);//random(255),random(255),random(255));
        sprites.add(new Anim("cubeLD.png",w,h,10));
        sprites.add(new Anim("cubeLT.png",w,h,10));
        sprites.add(new Anim("cubeRT.png",w,h,10));
        sprites.add(new Anim("cubeRD.png",w,h,10));
    
        x = width/2;
        y = height/2;
        
        shade = createGraphics(64,64,JAVA2D);
        shade.beginDraw();
        shade.fill(0,15);
        shade.noStroke();
        for(int i = 0 ;i<w/2;i+=3){
        shade.ellipse(w/2,h/2,i*2,i);
        }
        shade.endDraw();


        current = (Anim)sprites.get(dir);
    
    }

    void show(){
        noTint();
        image(shade,x,y+14);
        fill(0,120);
        tint(c);
        current.draw(curFaze,x,y);

        text("X: "+x+"\nY: "+y,x+w,y);
if(moving){
        if(frameCount%speed==0){
            curFaze++;
        }

        if(curFaze>=current.pocet){
            curFaze = 0;
        }

        
        if(dir==0){
            x-=moveSpeed;
            y+=iso*moveSpeed;
        }else if(dir == 1){
            x-=moveSpeed;
            y-=iso*moveSpeed;
        }else if(dir==2){
            x+=moveSpeed;
            y-=iso*moveSpeed;
        }else if(dir == 3){
            x+=moveSpeed;
            y+=iso*moveSpeed;

        }

        if(x>width)x=-w;
        if(x<-w)x=width;
        if(y>height)y=-h;
        if(y<-h)y=height;
}else{
    curFaze = 0;
}
    }

    void changeDir(int _kam){
        dir = _kam;
        current = (Anim)sprites.get(dir);
    }


}


class Anim{
    PImage src;
    ArrayList faze = new ArrayList();
    String filename;
    int pocet;
    int w,h;

    Anim(String _filename,int _w,int _h,int _pocet){
        filename = _filename;
        src = loadImage(filename);

        w=_w;
        h=_h;
        pocet = _pocet;

            for(int i = 0;i<pocet;i++){
        PGraphics tmp = createGraphics(w,h,JAVA2D);
        tmp.beginDraw();
        tmp.image(src,-i*w,0);
        tmp.endDraw();
        faze.add(tmp);
        }


    }

    void draw(int f,float _x,float _y){
        PGraphics current = (PGraphics)faze.get(f);
        image(current,_x,_y);
    }


}
