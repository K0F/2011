



Grid grid;



void setup(){
    size(1200,700,P2D);

    grid = new Grid("machines/cz_1200x700.bmp");

}



void draw(){


    background(0);

    grid.draw();

}



class Grid{
    ArrayList pnts;
    PImage predloha;
    String path;
    color col[] = {#000000,#999999,#FFFFFF,#FFCC00};
    int matX[] = {-1,0,1,-1,1,-1,0,1};
    int matY[] = {-1,-1,-1,0,0,1,1,1};


    Grid(String _path){
        path = ""+_path;
        pnts = castPnts();
    }

    ArrayList castPnts(){
        
        ArrayList tmp = new ArrayList();
        predloha = loadImage(path);

        int w = predloha.width;
        int cntr = 0;
        
        for(int i =0 ; i<predloha.pixels.length;i++){
            if(brightness(predloha.pixels[i])==255){
                tmp.add(new Pnt(this,cntr,i%w,(int)(i/(w+0.0)),1));
                cntr ++;
            }
        }

        return tmp;

    }

    void draw(){
        for(int i = 0 ; i< pnts.size();i++){
            Pnt p = (Pnt)pnts.get(i);
            p.draw();

        }

    }


}

class Pnt{
    int id,x,y,state,nextState;
    Grid parent;

    Pnt(Grid _parent,int _id, int _x, int _y, int _state){
        id = _id;
        x = _x;
        y = _y;
        state = _state;
    }

    void update(){

        int n = 0;
        for(int i = 0 ;i < parent.matX.length ; i++){
                if(brightness(pixels[(y+parent.matY[i])*width+(x+parent.matX[i])) == 255 ){
                    n++;
                    
                }
        }

        switch(n){
            case 0:
                nextState = 0;
                break;
            case 1:
                nextState = 1;
                break;
            



        }
    }

    void draw(){
        stroke(col[state]);
        point(x,y);

    }

}

