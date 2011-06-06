//import processing.opengl.*;

int X,Y;

int pocet = 2;
int rozmer = 1;

int num;
Gen g[];

void setup(){

    size(640,480,P2D);

    randomSeed(9);

    X = 0;
    Y = 0;

    num = (int)(width*height)/(pocet*rozmer);

    g = new Gen[num];
    for(int i = 0 ;i<num;i++){
        g[i] = new Gen(i);
    }

    noStroke();
}


void draw(){

    background(0);

    for(int i = 0 ;i<num;i++){
        g[i].draw();
    }

}

class Gen{
    int x,y;
    int id;
    boolean [] data = new boolean[(int)sq(pocet)];

    Gen(int _id){
        id = _id;
        x = X;
        y = Y;

        X += pocet*rozmer;
        if(X>width)
        {
            X = 0;
            Y += pocet*rozmer;
        }

        for(int i = 0 ;i<data.length;i++)
            data[i] = (random(100)>=50?true:false);
    }

    void draw(){
        int xx = 0;
        int yy = 0;
        for(int i = 0 ;i< data.length;i+=1){
            if(data[i]){
                fill(255);
            }else{
                fill(0);
            }
            rect(x+xx,y+yy,rozmer,rozmer);
            
            xx+=rozmer;
            if(xx>=pocet*rozmer){
                xx = 0;
                yy+=rozmer;
            }
            
        }
        if(random(10)>7)
        evolve();
    }

    void evolve(){
        int idx = (int)random(data.length);
        Gen tmp = g[(id+1)%g.length];
        data[idx] = tmp.data[(idx+data.length-2)%data.length] & !data[(idx+1)%data.length];
    }
}
