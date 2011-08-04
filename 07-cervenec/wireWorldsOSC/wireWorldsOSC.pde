/**
 * WireWorlds OSC
 *
 * + .. zoomin
 * - .. zoomout
 * s .. ulozit stav do txt
 * l .. nacist stav do txt
 * spiky .. pohyb po plose
 * DEL .. clrscreen
 * ENTER .. zazehni signal na pozici
 * L klik .. vytvor drat
 * R klik vymaz drat
 * e .. nasadit senzor
 * INSERT .. ulozit do bmp
 * HOME .. nacist z png
 * q .. exit
 * a .. nahravani videa .. vyzaduje GStreamer lib
 */





//import codeanticode.gsvideo.*;
import netP5.*;
import oscP5.*;


boolean staticImage = true;

// globalni rozliseni
int plochaX = 1200;
int plochaY = 700;

//GSMovieMaker mm;
OSC osc;
Receiver rece[] = new Receiver[0];

int X, Y;
int SID = 0;
//Recorder r;

boolean emit = true;
boolean rec = false;
boolean receive = true;

int top = 4;
int numx = plochaX/top,numy = plochaY/top;

ArrayList c = new ArrayList();//Cell[numx*top][numy*top];
color col[] = {color(0),color(50),color(120),color(255)};

int shiftx=0,shifty=0;

int scaler = 1;
String filename;

boolean somecells = false;

void setup(){
    size(plochaX,plochaY,P2D);
    background(0);

    noCursor();

    filename =  "machines/cz_1200x700.bmp";

    frameRate(25);

    loadStateFromImage();
    /*
       for(int y=0;y<c[0].length;y++){
       for(int x=0;x<c.length;x++){

       if()
       c[x][y] = new Cell(x,y);
       }
       }
     */
    /*if(rec){
      mm = new GSMovieMaker(this,width,height,"out/out.avi",GSMovieMaker.X264,GSMovieMaker.BEST,25);
      mm.start();
      }*/


    //for(int x=0;x<c.length;x++){
    //	c[x][30].state=1;
    //}

    noStroke();


}


void initOSC(){
    osc = new OSC("127.0.0.1",12000);
}

void loadState(){
    try{
        String temp[] = loadStrings(filename+".txt");

        for(int y=0;y<c[0].length;y++){
            for(int x=0;x<c.length;x++){
                c[x][y].state = parseInt(temp[y].charAt(x))-48;
            }
        }

    }catch(NullPointerException e){
        println("no such a file, please save before");
    }
    println("machine loaded: "+filename+".txt");
}

void saveState(){

    String data[] = new String[0];

    for(int y=0;y<c[0].length;y++){
        data = (String[])expand(data,data.length+1);
        data[data.length-1] = "";
        for(int x=0;x<c.length;x++){
            data[data.length-1]+=c[x][y].state!=0?"1":"0";
        }
    }

    saveStrings(filename,data);
    println("saved as: "+filename+".txt");
}



class Cell{
    int x,y,id;
    int state;

    Cell(int _id,int _x,int _y){
        id = _id;
        x = _x;
        y = _y;
    }

}

void loadStateFromImage(){

    if(emit)
        initOSC();
    try{
        PImage temp = loadImage(filename);

        //if(temp.width==c.length&&temp.height==c[0].length){

        c = new ArrayList();

        temp.loadPixels();

        for(int x=0;x<temp.width;x++){
            for(int y=0;y<temp.height;y++){

                if(brightness(temp.pixels[y*temp.width+x])==255){
                    c.add(new Cell(cntr,x,y));
                }


                /*
                   c[x][y] = new Cell(x,y);

                   if((brightness(color(temp.pixels[y*temp.width+x]))) == 255){
                   c[x][y].state=1;
                   }else if((red(color(temp.pixels[y*temp.width+x]))) == 146){
            //println( red(temp.pixels[y*temp.width+x]) );


            c[x][y].state=1;
            c[x][y].hasRece=true;

            rece = (Receiver[])expand(rece,rece.length+1);
            rece[rece.length-1] = new Receiver(x,y,rece.length-1);

            //println("got red no. "+(rece.length-1)+" on "+x+" : "+y);

            }else if((red(color(temp.pixels[y*temp.width+x]))) == 223){
            c[x][y].state=1;
            c[x][y].hasSenzor = true;
            //println( (red(color(temp.pixels[y*temp.width+x]))) );
            }else{
            c[x][y].state=0;
            }*/
            }
        }

        println("state loaded sucessfully from: "+filename+".bmp");

        /*}else{
          println("error: stored values does not correpondent to dimensions");
          }*/

    }catch(NullPointerException e){
        println("error: saved record does not found " +e);
    }
}

void saveStateToImage(){
    PImage temp = createImage(c.length,c[0].length,RGB);

    for(int y=0;y<c[0].length;y++){
        for(int x=0;x<c.length;x++){
            if(c[x][y].state>0){temp.pixels[y*temp.width+x]=color(255);}else{temp.pixels[y*temp.width+x]=color(0);}
        }
    }

    temp.save(filename+".bmp");
    println("state saved as image: "+filename+".bmp");
}

void draw(){
    background(0);

    step(1);

    pushMatrix();
    translate(-shiftx,-shifty);

    for(int y=0;y<c[0].length;y++){
        for(int x=0;x<c.length;x++){
            c[x][y].draw();
        }
    }

    noFill();
    stroke(255);
    rect(-1,-1,1,1);
    rect(c.length*scaler+1,-1,1,1);
    rect(-1,c[0].length*scaler+1,1,1);
    rect(c.length*scaler-1,c[0].length*scaler+1,1,1);
    noStroke();

    popMatrix();

    X = constrain((int)((mouseX/scaler)+shiftx/scaler),0,c.length-1);
    Y = constrain((int)((mouseY/scaler)+shifty/scaler),0,c[0].length-1);

    c[X][Y].sel=true;

    if(mousePressed){
        if(mouseButton==LEFT)
            c[X][Y].state=1;
        if(mouseButton==RIGHT)
            c[X][Y].state=0;
        if(mouseButton==3){
            c[X][Y].state=3;
            mousePressed=false;
        }
    }


}

void keyPressed(){
    if(key==' '){
        for(int y=0;y<c[0].length;y++){
            for(int x=0;x<c.length;x++){
                c[x][y].calm();
            }

        }
    }else if(key=='='){
        scaler++;
    }else if(key=='-'){
        scaler--;
    }else if(key =='s'){
        saveState();
    }else if(key =='l'){
        loadState();
    }else if(keyCode==LEFT){
        shiftx-=3;
    }else if(keyCode==RIGHT){
        shiftx+=3;
    }else if(keyCode==UP){
        shifty-=3;
    }else if(keyCode==DOWN){
        shifty+=3;
    }else if(keyCode==DELETE){
        for(int y=0;y<c[0].length;y++){
            for(int x=0;x<c.length;x++){
                c[x][y].state=c[x][y].nextState=0;
            }
        }
    }else if(keyCode==ENTER){
        c[X][Y].state=3;


    }else if(keyCode == 155){
        saveStateToImage();

    }else if(keyCode==36){
        loadStateFromImage();
    }else if(key == 'q'){

        exit();
    }else if(key == 'a'){
        rec=!rec;
    }else if(key == 'e'){
        if(!emit){
            //osc = new OSC("127.0.0.1",12000);
            emit = true;
            c[X][Y].s = new Senzor(SID);
            SID++;
        }

        c[X][Y].hasSenzor = !c[X][Y].hasSenzor;
    }


    scaler=constrain(scaler,1,top);
    keyPressed=false;
}

void step(int n){
    boolean anim = false;
    for(int y=0;y<c[0].length;y++){
        for(int x=0;x<c.length;x++){
            if(c[x][y].state>1){
                anim=true;
                break;
            }
        }
    }

    if(anim){
        if(frameCount%n==0){
            for(int y=0;y<c[0].length;y++){
                for(int x=0;x<c.length;x++){
                    c[x][y].act();
                }
            }

            for(int y=0;y<c[0].length;y++){
                for(int x=0;x<c.length;x++){
                    c[x][y].update();
                }
            }
        }
    }
}

class Senzor{
    int id;
    float freq;

    Senzor(int _id){
        id=_id;
        freq = ceil(random(10))*16;
    }
}

class Receiver{
    int id;
    int x,y;
    Receiver(int _x,int _y,int _id){
        x=_x;
        y=_y;
        id=_id;
    }
}

class Cell{
    //state 0=black, 1=wire, 2= tail, 3=head
    int state = 0;
    int nextState = 0;
    int x,y;
    boolean sel = false;
    Senzor s;
    //Receiver r;
    boolean hasSenzor = false;
    boolean hasRece = false;

    Cell(int _x,int _y){
        x=_x;
        y=_y;
    }

    void act(){
        compute();

        if(state==3&&hasSenzor){
            if(s==null){
                s = new Senzor(SID);
                SID++;
            }
            osc.send(s.id);
        }
    }

    void draw(){

        if(state>0){
            noStroke();
            if(hasRece){
                fill(#ff0000);
            }else{

                if(hasSenzor)
                    fill(#ffcc00);
                else
                    fill(col[state]);
            }

            rect(x*scaler,y*scaler,scaler,scaler);
        }

        if(sel){
            stroke(255);
            fill(col[state]);
            rect(x*scaler,y*scaler,scaler,scaler);
        }
        sel=false;



    }

    void compute(){

        //is wire?
        if(state>0){

            if(state==3){
                nextState = 2;
            }else if(state==2){
                nextState=	1;
            }else if(state==1){
                nextState=1;

                int q = getStates(3);
                if(q==1||q==2){
                    nextState=3;
                }
            }

        }else{
            nextState=0;
        }

    }

    void update(){
        state=nextState;
    }

    int getStates(int wh){
        int cnt = 0;

        if(c[(x+c.length-1)%c.length][(y+c[0].length-1)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length)%c.length][(y+c[0].length-1)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length+1)%c.length][(y+c[0].length-1)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length+1)%c.length][(y+c[0].length)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length+1)%c.length][(y+c[0].length+1)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length)%c.length][(y+c[0].length+1)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length-1)%c.length][(y+c[0].length+1)%c[0].length].state==wh)cnt++;
        if(c[(x+c.length-1)%c.length][(y+c[0].length)%c[0].length].state==wh)cnt++;

        return cnt;

    }

    void calm(){

        if(state>0){
            nextState=1;
            update();
        }

    }
}

class OSC{
    OscP5 osc;
    NetAddress addr;
    int port;

    //////////////////////////////////////////////////////////

    OSC(String _addr,int _port){
        port=_port;
        osc = new OscP5(this,_port-1);
        addr = new NetAddress(_addr,port);
    }

    //////////////////////////////////////////////////////////


    void send(float _whatX,float _whatY,float _whatZ){
        OscMessage message = new OscMessage("/msg");
        //message.add("x ");
        message.add(_whatX);
        //message.add("y ");
        message.add(_whatY);

        message.add(_whatZ);
        osc.send(message, addr);


    }

    //////////////////////////////////////////////////////////

    void send(int _ident){
        OscMessage message = new OscMessage("/msg");
        int ident = (_ident);
        message.add(ident);
        //message.add(_what);
        osc.send(message, addr);
    }

    //////////////////////////////////////////////////////////

    void send(int _ident,float _what){
        OscMessage message = new OscMessage("/msg");
        int ident = (_ident);
        message.add(ident);
        message.add(_what);
        osc.send(message, addr);
    }

    //////////////////////////////////////////////////////////

    void send(String _ident,float _what){
        OscMessage message = new OscMessage("/msg");
        String ident = _ident+"";
        message.add(ident);
        message.add(_what);
        osc.send(message, addr);
    }

    //////////////////////////////////////////////////////////

    void oscEvent(OscMessage theOscMessage) {

        if(receive){
            int tmp = theOscMessage.get(0).intValue();
            tmp = constrain(tmp,0,rece.length-1);
            c[rece[tmp].x][rece[tmp].y].state = 3;
        }
        //println("/impulse");



        //print("### received an osc message.");
        //print(" addrpattern: "+theOscMessage.addrPattern());
        //println(" typetag: "+theOscMessage.typetag());
    }

}
