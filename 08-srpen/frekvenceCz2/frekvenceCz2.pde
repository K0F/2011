/**
  *  Czech Korpus frequency text analysis
  *  by kof 2011
*/


int num = 1000000;
int visible = 2000;

int speed = 1000;

float mx = 0;

HashMap words;
ArrayList text;
ArrayList vals;

void setup(){
    size(1600,900,P2D);


    text = nactiVzorek("vzorek.txt");
    words = parse("/sketchBook/2011/08-srpen/frekvenceCz/data/syn2010_word");

    vals = new ArrayList();
    for(int i =0 ; i<text.size();i++){
        vals.add(0.0);
    }

    textFont(createFont("Sans",9,false));
    textMode(SCREEN);


    smooth();
    fill(255);
    noStroke();
}


// kresba a analyza

void draw(){
    background(0);
    //visual.draw();

    //default pozice

    int x = 20;
    int y = 20;

    // conter na procenta

    int zbyva = 0;
    for(int i = 0 ; i < text.size();i++){
        float val = (Float)vals.get(i);
        if(val==0){
            zbyva ++;
        }
    }

    float procent = 100-(zbyva/(text.size()+0.0))*100;

    // samotna smycka skrze slova

    for(int i = 0 ; i < text.size();i++){
        Word tmp = (Word)text.get(i);
        String slovo = ""+tmp.txt;

        float val = (Float)vals.get(i);
        boolean hit = false;

        // analyza
        if(val==0){

            // prvnich 45% nejbeznejsich slov dat z prvni
            //if( procent < 45.0 )


                fill(255);
                Iterator it = words.entrySet().iterator();


                while(it.hasNext()){
                    Map.Entry current = (Map.Entry)it.next();
                    String _slovo = (String)current.getKey();
                    int _val = (Integer)current.getValue();

                    if(_slovo.toLowerCase().equals(slovo.toLowerCase())){
                        val = _val;
                        hit = true;
                        break;
                        
                    }
                }


            // jestli trefa zaznamenej
            if(hit)
                vals.set(i,val);

            // nejbizarnejsi slovo v textu :)
            mx = max(mx,val);

            //default barva pri hledani
            //fill(#caca00);

        }else{

            // jinak obarvi slova podle hodnoty
            fill(lerpColor(#00ff00,#ff0000,map(val,0,mx,0.45,1)));
        }

        // sirka slova
        float tw = textWidth(slovo+" ");

        // newline
        if(x + tw > width - 20){
            x = 20;
            y += 11;
        }
            
        // selekce v nezvyklosti slov
        if(map(val,0,mx,0,width) > mouseX){
            text(slovo,x,y+height/2);
            stroke(255,15);
            line(x+tw / 2.0 - 2 , height / 2 + y - 2 , map(val,0,mx,0,width),height/2);
            noStroke();
        }

        // kresba textu a elips
        text(slovo,x,y);
        fill(#ff0044,map(val,0,mx,0,100));
        ellipse(x + tw / 2.0 - 2 ,y - 2,tw,12);

        x += tw;
    }

    // dolni ukazatel procesu
    fill(255);
    text(procent+"% slov nalezeno v korpusu",10,height-10);
}

// nacita vzorek txt a prevadi do AL, Word

ArrayList nactiVzorek(String _filename){

    String[] rw = loadStrings(_filename);

    ArrayList _vzorek =  new ArrayList();

    int cnt = 0;

    for( int i = 0 ; i < rw.length ; i ++ ){

        String[] tmp = splitTokens(rw[i],"/\t “„:?.,!;\"\'-()");

        for(int ii = 0 ; ii < tmp.length;ii++){
            _vzorek.add(new Word(cnt,tmp[ii]));
            cnt++;
        }
    }

    return _vzorek;
}

// korpus parser

HashMap parse(String _filename){

    String[] raw;
    raw = loadStrings(_filename);

    num = min(raw.length,num);

    println(raw.length);

    HashMap _words = new HashMap(raw.length,0.001);

    println(raw[0]);

    int cnt = 0;
    for(int i = 0 ; i < num;i++){
        String data[] = splitTokens(raw[i],"\t ");

        if(data.length==7 || data.length==6){
            cnt++;
            _words.put(data[1],cnt);
        }
    }

    println(cnt+" words loaded");
    return _words;
}

// slovo spolu s poradim v korpusu

class Word{
    String txt;
    int no;

    Word(int _no,String _txt){
        no = _no;
        txt = _txt;
    }
}

