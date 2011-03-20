// import
import processing.opengl.*;
import fullscreen.*; 

FullScreen fs; 

// number of random patterns
int patNum = 7;
//number of rotators
int rotNum = 8;
// minimum oscillation speed (the more low == slower), and the relative spread of speeds (lower == more organized structure)
int minRep = 4000;
int spread = 40;
// size of display averages
int prumSize = 3;
// scale speed of movement per cycle
float scal = 0.2;
// alpha of drawer
float alph = 50;
// scale of graph
float sc = 10.0;


// animation fade
int fade = 100;

// animation caputure
boolean record = false;
int frameCnt = 0;

// debuging showing some more informations on screen
boolean debug = false;
boolean showGraph = false;

// X (time) coordinate of graph
float graphX = 0;
// AL of random patterns
ArrayList patterns = new ArrayList();
// AL of rotators
ArrayList <CPU> cpu = new ArrayList();
// array for average values of all the rotators
int graph[];
// square root of size of rotators matrixes (not generic do not change)
int size = 5;
// positions of plotter
float plotX, plotY, lplotX, lplotY;
int YY,XX;

// default settings for movement increments
int xs[] = {-2,-1,0,1,2,-2,-1,0,1,2,-2,-1,0,1,2,-2,-1,0,1,2,-2,-1,0,1,2};
int ys[] = {-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,0,0,0,0,0,1,1,1,1,1,2,2,2,2,2};

// offscreen plotter paper
PGraphics img;


boolean reach = false;
///////////////////////////////



void setup(){
    size(640,480,P2D);

    //println(FullScreen.getResolutions( 0 ));

    reset();

    rectMode(CENTER);
    noFill();
    noSmooth();
    stroke(0);


    textFont(createFont("Anivers",10,false));
    textMode(SCREEN);
    textAlign(CENTER);

    graph = new int[(int)sq(size)];


  // Create the fullscreen object
    fs = new FullScreen(this); 
      
        // enter fullscreen mode
          fs.enter(); 

}
//////////////////////////////
void eraseImg(){
    img.beginDraw();
    img.smooth();
    img.background(255);
    img.endDraw();


}
//////////////////////////////
void reset(){

    patterns = new ArrayList();

    for(int i = 0;i<patNum;i++)
        patterns.add(new Pattern());

    cpu = new ArrayList();


    XX = width-40;
    YY = height-40;
    for(int i = 0;i<rotNum;i++){
        cpu.add(new CPU(XX,YY,i));
        XX-=40;
        if(XX<=0){
            XX=width-40;
            YY-=40;
        }

    }

    img = createGraphics(width,height,P2D);
    eraseImg();

    graphX = 0;

    lplotX = plotX = width/2;
    lplotY = plotY = height/2;


}
//////////////////////////////
void mousePressed(){
    if(mouseButton==LEFT){
        reset();
    }

}
//////////////////////////////
void draw(){
    background(img);

    if(reach){
        if(record)
        img.save("/desk/parralerAnimator/img"+nf(frameCnt,4)+".png");
        frameCnt++;

        reach = false;
        plotX = width/2;
        plotY = height/2;
        img.beginDraw();
        img.noStroke();
        img.fill(255,fade);
        img.rect(0,0,width,height);
        img.endDraw();
    }

    for(int i = 0 ;i<graph.length;i++)
        graph[i] = 0;


    stroke(0);
    //float tmpX,tmpY;
    for(int i = 0;i<cpu.size();i++){
        CPU tmp = (CPU)cpu.get(i);
        tmp.compute();

        for(int ii = 0;ii<(int)sq(size);ii++){
            graph[ii]+=tmp.getStateVal(ii);
            //tmpX += xs[ii];
            //tmpY += ys[ii];
        }


    }
    //tmpX /= sq(size);
    //tmpY /= sq(size);

    lplotX = plotX;
    lplotY = plotY;


    for(int i = 0;i<graph.length;i++){
        plotX += xs[i]*map(graph[i],0,cpu.size(),0,scal);
        plotY += ys[i]*map(graph[i],0,cpu.size(),0,scal);
    }

    graphX += 1/sc;
    graphX = graphX%width;

    img.beginDraw();
    img.stroke(0,alph);
    img.line(plotX,plotY,lplotX,lplotY);
    //img.line(plotX-(atan2(lplotY-plotY,lplotX-plotX))*2,plotY,plotX+(atan2(lplotY-plotY,lplotX-plotX))*2,plotY);
    //img.strokeWeight(dist(plotX,plotY,lplotX,lplotY));
    //img.strokeWeight(map(atan2(lplotY-plotY,lplotX-plotX),-PI,PI,1,5));
    if(showGraph){
    img.stroke(0,20);
    img.line(graphX,map(abs(width/2-plotX),0,width/2,height/2+100,height/2-100),graphX,map(abs(width/2-lplotX),0,width/2,height/2+100,height/2-100));
    img.line(graphX,map(abs(height/2-plotY),0,height/2,height/2+100,height/2-100),graphX,map(abs(height/2-lplotY),0,height/2,height/2+100,height/2-100));
    }
    img.endDraw();



    int X = 0;
    int Y = 0;


    for(int i = 0;i<graph.length;i++){
        fill(map(graph[i],0,cpu.size(),255,0));
        rect(plotX+X+prumSize*2,plotY+Y+prumSize*2,prumSize,prumSize);


        X+=prumSize;

        if(X>=size*prumSize){
            X = 0;
            Y+=prumSize;
        }

    }

    stroke(0,40);
    plotBorder(40);
    line(plotX-5,plotY,plotX+5,plotY);
    line(plotX,plotY-5,plotX,plotY+5);
}
//////////////////////////////
void plotBorder(int kolik){
    if(plotX<kolik-20)plotX=width-kolik+20;
    if(plotX>width-kolik+20)plotX=kolik-20;

    if(plotY>YY-kolik+20)plotY=kolik-20;
    if(plotY<kolik-20)plotY=YY-kolik+20;


    pushStyle();
    rectMode(CORNERS);
    noFill();
    
    stroke(0,40);
    rect(kolik-20,kolik-20,width-kolik+20,YY-kolik+20);
    popStyle();

}
//////////////////////////////
class CPU{
    int x,y;
    float time;
    float tstep = 0.01;
    float r = 20;
    Pattern pat;
    int current = 0;
    float ltime;
    int id;
    //////////////////////////////
    CPU(int _x,int _y,int _id){
        x=_x;
        y=_y;
        id = _id;
        time = -HALF_PI;
        tstep = random(minRep,minRep+spread)/10000.0;
        pat = (Pattern)patterns.get(current);
    }
    //////////////////////////////
    int getStateVal(int i){
        int answ = pat.state[i]?1:0;
        return answ;
    }
    //////////////////////////////
    void compute(){
        time+=tstep;
        float cx = cos(time)*r;
        float cy = sin(time)*r;
        noFill();
        stroke(0,map(abs(time+HALF_PI-TWO_PI),0,TWO_PI,0,127));
        ellipse(x,y,r*2,r*2); 

        pushStyle();
        rectMode(CORNER);
        int sqr = (int)sqrt(pat.state.length);
        for(int ii = 0;ii<sqr;ii++){
            for(int i = 0;i<sqr;i++){
                if(pat.state[ii*sqr+i]){
                    fill(0);
                }else{
                    fill(255);
                }

                stroke(0);
                rect(ii*sqr+x-pat.state.length/2,i*sqr+y-pat.state.length/2,sqr,sqr);
            }
        }
        popStyle();
        stroke(0);
        rect(x+cx,y+cy,3,3);
        fill(0);
        text(floor(tstep*1000),x,y-11);
        if(debug){
            fill(0);
            text(time,(int)x+cx,(int)y+cy); 
        }
        
        if((time+HALF_PI)>TWO_PI&&(ltime+HALF_PI)<(TWO_PI)){
            float savePos = time-TWO_PI;
            time = savePos;
            getNewPattern();
        }

        ltime = time;


    }
    //////////////////////////////
    void getNewPattern(){
        current+=1;

        if(current>=patterns.size()){
            current = 0;
            if(id==0 && record)
                reach=true;
        }

        pat = (Pattern)patterns.get(current);

    }

}
//////////////////////////////

class Pattern{
    boolean [] state;


    Pattern(){
        state  = new boolean[(int)sq(size)];
        regen();
    }
    //////////////////////////////
    void regen(){
        for(int i = 0;i<state.length;i++){
            if(random(100)>50)
                state[i] = true;
            else
                state[i] = false;
        }

    }

}
