import krister.Ess.*;


ArrayList matrixes = new ArrayList();
ArrayList oscillators = new ArrayList();


int oscillatorNum = 32;
int matrixPerOscill = 256;



float minVal =1.1;
float step = 0.013127;

float spread = 16;

int size = 3;
int scale = 3;

PFont font;

float [] graph;
float avg = 0;

AudioStream myStream;
float[] streamBuffer;

int mxVal;
void setup(){
    size(1024,240,P2D);


    graph = new float[width];
    for(int i = 0;i<graph.length;i++){
        graph[i] = 0;
    }


    Ess.start(this);
     myStream=new AudioStream(4410);
      streamBuffer=new float[4410];
       fillAudioBuffer();
        myStream.start();


    for(int i = 0;i<matrixPerOscill;i++)
        matrixes.add(new Matrix(i));


    Matrix m = (Matrix)matrixes.get(matrixes.size()-1);
    mxVal = m.num;

    int X,Y;
    X = size*scale;
    Y = height-15;
    for(int i = 0;i<oscillatorNum;i++){
        oscillators.add(new Oscill(X,Y,i));

        X+=size*scale+scale*2;
        if(X>width){
            X = 0;
            Y += size*scale+scale*2;
        }
    }

    if(scale<2)
        noStroke();
    else
        stroke(0);

    noSmooth();

    font = createFont("Verdana",7,false);
    textFont(font);
    textAlign(CENTER);
    textMode(SCREEN);
}


void draw(){
    background(200);


    avg = 0;

    for(int i = 0;i<oscillators.size();i++){
        Oscill tmp = (Oscill)oscillators.get(i);
        tmp.update();
        tmp.draw();
        avg += tmp.val;
    }

    avg /= (oscillatorNum-0.0);
    graph[frameCount%width] = avg;

    //if(frameCount%5==0)
        fillIt();


    float MX = 0;
        float MN = 512;
        for(int i = 0;i<graph.length;i++){
            MX = max(graph[i],MX);
            MN = min(graph[i],MN);
        }

    stroke(0);
    for(int i = 0;i<width;i++){
        line(i,map(graph[i],MN,MX,height-100,0),i,0);
    }



}

void mousePressed(){
    for(int i = 0;i<oscillators.size();i++){
        Oscill tmp = (Oscill)oscillators.get(i);
        if(tmp.over(5)){
            tmp.running = !tmp.running;
        }
    }

}

void fillIt(){
    
        float MX = 0;
        float MN = 512;
        for(int i = 0;i<graph.length;i++){
            MX = max(graph[i],MX);
            MN = min(graph[i],MN);
        }

    int cnt = 0;
    for(int i = 0 ;i<streamBuffer.length;i++){
        streamBuffer[i] = map(graph[(frameCount+i)%graph.length],MN,MX,-0.9,0.9);
        cnt++;
    }

}

void fillAb(){

        float MX = 0;
        float MN = 512;
        for(int i = 0;i<graph.length;i++){
            MX = max(graph[i],MX);
            MN = min(graph[i],MN);
        }

        streamBuffer[frameCount%streamBuffer.length] = avg;
}

void fillAudioBuffer(){

        float MX = 0;
        float MN = 512;
        for(int i = 0;i<graph.length;i++){
            MX = max(graph[i],MX);
            MN = min(graph[i],MN);
        }


        int cnt = 0;
        int offset = (frameCount%width);
        for(int i=0; i<offset; i++) { 
               streamBuffer[cnt] = map(graph[i],MN,MX,-0.9,0.9);
               cnt++;                  
        }
        for(int i=offset-1; i > 0; i--) { 
              streamBuffer[cnt] = map(graph[i],MN,MX,-0.9,0.9);
               cnt++;                  
        }
        
        for(int i=width-1; i > offset; i--) { 
              streamBuffer[cnt] = map(graph[i],MN,MX,-0.9,0.9);
               cnt++;                  
        }

        for(int i = offset; i < width; i++) { 
               streamBuffer[cnt] = map(graph[i],MN,MX,-0.9,0.9);  
               cnt++;   
        } 

}

void audioStreamWrite(AudioStream theStream) {
     System.arraycopy(streamBuffer,0,myStream.buffer,0,streamBuffer.length);
}

public void stop() {
     Ess.stop();
      super.stop();
}

class Oscill{
    int x,y;
    Matrix current;
    int mcount;
    PVector dir;
    float speed,time,ltime,val;
    int id;
    boolean running;
    int direction = 1;

    Oscill(int _x,int _y, int _id){
        x=_x;
        y=_y;
        id = _id;
        speed = minVal+(step*id);//andom(minVal,minVal+spread)/1000.0;


        mcount = 0; 
        time = ltime = -HALF_PI;
        current = (Matrix)matrixes.get(0);

        running = true;
    }


    void update(){

        ltime = time;

        if(running)
            time+=speed;

        if((time+HALF_PI)>TWO_PI&&(ltime+HALF_PI)<(TWO_PI)){
            float savePos = time-TWO_PI;
            time = savePos;
            getNewMatrix();
        }

        val = map(current.num,0,512,0,100);


    }

    void draw(){



        int X,Y;
        int i = 0;

        
        if(over(5)){
            stroke(#ffcc00);
        }else if(!running){
            stroke(#ff0000);
        }else{
            stroke(0);
        }
        for(Y = 0 ;Y < size*scale;Y+=scale){
            for(X = 0 ;X < size*scale;X+=scale){
                fill(current.mat[i]?0:255);
                rect(x+X-size*scale/2,y+Y-size*scale/2,scale,scale);
                i++;
            }
        }

        pushStyle();
        stroke(#ff0000);
        line(x,y,x+cos(time)*size/2*scale,y+sin(time)*size/2*scale);
        popStyle();

        stroke(0);
        line(x,y-size*scale/2,x,y-size*scale/2-val);

        fill(0);
        text(current.num,x,y+scale*size+4);
    }


    void getNewMatrix(){
        if(mcount>=matrixes.size()-1&&direction==1){
            direction = -1;
        }else if(mcount<1&&direction==-1){
            direction = 1;
        }


        mcount+=direction;
        current = (Matrix)matrixes.get(mcount);

    }

    boolean over(int area){
        area += size*scale/2;
        if(mouseX>x-area&&mouseX<x+area&&mouseY>y-area&&mouseY<y+area)
            return true;
        else
            return false;
    }

}


class Matrix{
    boolean mat[];
    int num;
    int maxVal;
    int id;
    Matrix(){
        mat= new boolean[(int)sq(size)];

        String repre = "";
        for(int i =0 ;i<mat.length;i++){
            mat[i] = (random(100)>50)?true:false;
            if(mat[i])
                repre += "1";
            else
                repre += "0";
        }
        num = unbinary(repre);
    }
    Matrix(int _id){
        id = _id;
        //num = id;
        //mat= new boolean[(int)sq(size)];
        //for(int i =0;i<mat.length;i++){
        //    mat[i] = true;
        //}
        mat= new boolean[(int)sq(size)];


        String maxSize = "";
        for(int i = 0;i<(int)sq(size);i++){
            maxSize += "1";
        }

        int maxVal = unbinary(maxSize);


        num = (int)map(id,0,matrixPerOscill,0,maxVal);


        String repre = binary(num,(int)sq(size));


        for(int i = 0;i<(int)sq(size);i++){
            if(repre.charAt(i)=='1'){
                mat[i] = true;
            }else{
                mat[i] = false;
            }
        }


    }

    void mutate(int howMuch){
        for(int i= 0;i<howMuch;i++){
            mat[(int)random(mat.length)] = !mat[(int)random(mat.length)];
        }
    }


}
