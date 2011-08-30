
int num = 100000;
int visible = 2000;

ArrayList words;
String[] raw;

void setup(){
    size(640,400,P2D);

    parse("syn2010_word");


}

void parse(String _filename){
    raw = loadStrings(_filename);

    words = new ArrayList();


    int cnt = 0;
    for(int i = 0 ; i < num;i++){
        String data[] = splitTokens(raw[i],"     ");

        if(data.length==7)
            words.add(new Word(parseInt(data[0]),data[1]));

        cnt++;
    }

    println(cnt+" words loaded");
}

class Word{
    String txt;
    int no;
    

    Word(int _no,String _txt){
        no = _no;
        txt = _txt;
    }
}

class Visual{
    ArrayList w;
    ArrayList pos;

    Visual(ArrayList _w){
        w = _w;

        pos = new ArrayList();

        for(int i = 0 ; i < num ;i++){
            pos.add(new PVector(random(width),random(height)));
        }
    }

    void draw(){
        for(int i = 0 ; i < visible ; i ++){
            String txt = (PVector)w.get(i)+"";
            PVector cpos = (PVector)(pos.get(i));
            text(txt,cpos.x,cpos.y);

        }


    }
   
}
