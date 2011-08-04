import processing.opengl.*;

float percent ;
String katalog = "cyphernomicon.txt";
String filters = " 	(){}[];,+-&*^%/=<>.\r\n\'\":|`!?";

ArrayList words = new ArrayList(0);
ArrayList ent = new ArrayList(0);

Runnable runnable;
Thread thread;

Libre libre;

int shift = 0;
float sshift = 0;

boolean done = false;
PFont mini, ani;

String current = "";
String sum = "";

void setup(){

    size(320,600,P2D);
    //	hint(DISABLE_OPENGL_2X_SMOOTH);
    hint(ENABLE_NATIVE_FONTS);
    noSmooth();

    println(sketchPath+"/results/"+katalog);
    File f = new File(sketchPath+"/results/"+katalog);
    if(f.exists()){
        println("nacitam ulozenou analyzu z results/"+katalog);
        String raw[] = loadStrings("results/"+katalog);

        for(int i = 0;i<100;i++){
            String data[] = splitTokens(raw[i]);
            ent.add(new Ent(data[0],parseInt(data[1]),parseFloat(data[2])));		
        }
        done = true;
        println("hotovo!");

    }

    if(!done){
        libre = new Libre(katalog);
        libre.start();
    }

    /*
       runnable = new Libre(katalog);
       thread = new Thread(runnable);
       thread.start();
     */
    mini = createFont("Dialogue",10,false);
    //ani = createFont("Anivers",64,true);

    textFont(mini,10);
    //textMode(SHAPE);
    textMode(SCREEN);

}

void draw(){
    background(0);

    sshift += (map(mouseY,0,height,0,ent.size()-200)-sshift)/50.0;
    shift = (int)sshift;

    fill(#FFCC00);
    noStroke();
    rect(width-10,map(shift,0,ent.size()-1,0,height-20),10,20);
    textAlign(LEFT);
    textFont(mini);

    text("",10,20);

    if(!done){
        if(frameCount%3==0)
            sortIt();



        text(katalog+"  "+(int)percent+" % analyzováno, právě: "+current,20,10);



        sum = "";

    }
    if(ent.size()>0){


        int l = min(ent.size(),1000);
        for(int i = 0;i< l ;i++)
            sum+=" "+getWord(i);
    }

    fill(40);

    text(sum,10,20,width-20,height-20);


    textAlign(CENTER);


    for(int i = shift ; i < 100+shift ;i++){
        fill(255,200);
        //textFont(ani,10);//map(i,shift,100+shift,32,12));
        float x =map(getPoradi(i),0,1,10,width-10);
        text(getWord(i) +"  ("+getCount(i)+")",x,map(i,shift,100+shift,40,height-10));
        stroke(255,15);
        line(x,0,x,height);
    }


}

void keyPressed(){
    sortIt();
}

synchronized void sortIt(){

    synchronized (libre) {
        libre.pleaseWait = true;
    }

    try{
        Collections.sort(ent, new byCount());
    }catch(ConcurrentModificationException e){
        println("Sync error: "+e);
    }

    // Resume the thread
    synchronized (libre) {
        libre.pleaseWait = false;
        libre.notify();
    }
}

String getWord(int _in){

    _in = constrain(_in,0,ent.size());
    Ent tmp = (Ent)ent.get(_in);
    return tmp.string;
}


String getCount(int _in){

    _in = constrain(_in,0,ent.size());
    Ent tmp = (Ent)ent.get(_in);
    return ""+tmp.count;
}

float getPoradi(int _in){

    _in = constrain(_in,0,ent.size());
    Ent tmp = (Ent)ent.get(_in);
    return tmp.poradi;
}


class byCount implements java.util.Comparator {
    int compare(Object A, Object B) {
        Ent a = (Ent)A;
        Ent b = (Ent)B;

        int dif = b.count - a.count;
        return dif;
    }
}


class Libre extends Thread{

    String raw[];
    String file;
    ArrayList txt;
    boolean pleaseWait = false;



    Libre(String _file){
        file = _file;

    }

    void run(){
        raw = loadStrings(file);

        txt = new ArrayList();
        for(int i = 0;i<raw.length;i++){
            if( !raw[i].equals("") || !raw[i].equals(" ") || !raw[i].equals("	") || raw[i]!=null)
                txt.add(raw[i]);

        }


        //words = new ArrayList();
        for(int i = 0 ; i< txt.size();i++){
            String curline = (String)txt.get(i);
            String wrds[] = splitTokens(curline,filters);

            for(int ii = 0;ii<wrds.length;ii++){
                ent.add(new Ent(wrds[ii].toLowerCase()));
                words.add(wrds[ii].toLowerCase());
            }
        }
        /*

           for(int i = 0 ; i< words.size();i++){
           ent.add(new Ent((String)words.get(i)));
           }
         */
        for(int i = 0 ; i< ent.size();i++){


            synchronized (this) {
                while (pleaseWait) {
                    try {
                        wait();
                    } catch (Exception e) {
                    }
                }


                Ent tmp = (Ent)ent.get(i);
                tmp.test();
                percent = round( i / (ent.size()+0.0) * 100);
                current = tmp.string;
            }



        }
        done =true;
        String data[] = new String[ent.size()];
        for(int i = 0;i<data.length;i++){
            Ent tmp = (Ent)ent.get(i);
            data[i] = ""+tmp.string+" "+tmp.count+" "+tmp.poradi;
        }
        saveStrings("results/"+katalog,data);

    }
}


class Ent{
    int count = 1;
    String string;
    float poradi = 0.5;

    Ent(String _string){

        string = _string+"";

    }

    Ent(String _string,int _count,float _poradi){
        string = _string;
        count = _count;
        poradi = _poradi;

    }

    void test(){

        /*
           boolean isinlist = false;
           for(int i =0;i<ent.size();i++){
           Ent tmp = (Ent)ent.get(i);
           String ttmp = tmp.string;//.string;
           if(string.equals(ttmp)){
           isinlist = true;break;
           }
           }
         */
        int cnt =1;
        for(int i =0;i<words.size();i++){
            String tmp = (String)words.get(i);
            if(string.equals(tmp)){
                cnt++;
                poradi +=i;
            }
        }

        if(cnt>1){
            poradi /= (cnt+0.0);
            poradi /= words.size();
        }

        cnt = 1;
        for(int i =0;i<ent.size();i++){
            Ent tmp = (Ent)ent.get(i);
            if(string.equals(tmp.string)&&this!=tmp){
                cnt++;
                ent.remove(i);


            }

        }

        count = cnt;

    }

}
