import codeanticode.gsvideo.*;
import processing.xml.*;
import controlP5.*;

ControlP5 controlP5;

String query;
ArrayList <FSScraper> bank = new ArrayList();
Textfield myTextfield;

int X = 10;
int Y = 10;

boolean useGS = true;

void setup(){
    size(320,240);

    frameRate(25);

    controlP5 = new ControlP5(this);
    //bank = new FSScraper[query.size()];

    ControlFont cf1 = new ControlFont(createFont("Verdana",9,false));

    myTextfield = controlP5.addTextfield("query",10,height-40,width-20,20);
    //controlP5.addTextfield("",100,200,200,20);

    myTextfield.setFocus(true);
    myTextfield.setAutoClear(true);


    myTextfield.setColorActive(color(250)); // color for mouse-over
    myTextfield.setColorForeground(color(200));
    myTextfield.setColorBackground(color(20)); // default color
    myTextfield.captionLabel().setControlFont(cf1);

    /*
       for(int i = 0;i<query.size;i++){
       bank[i] = (new FSScraper(this,query[i]));
       }
     */

}

void controlEvent(ControlEvent theEvent) {
    //println("controlEvent: accessing a string from controller '"+theEvent.controller().name()+"': "+theEvent.controller().stringValue());

    if(!theEvent.controller().stringValue().equals("")){
        bank.add(new FSScraper(this,theEvent.controller().stringValue()));
        //        FSScraper tmp = (FSScraper)bank.get(bank.size()-1);
        //        Thread loader = new Thread(tmp);
        //        loader.run();
    }

}

void draw(){
    background(0);


    for(int i = 0 ;i<bank.size();i++){
        FSScraper tmp = (FSScraper)bank.get(i);
        tmp.draw(10,i*10+10);
        //bank[i].draw();
    }

}

class FSScraper{
    String apiKey = "4daf76e033114821b7b686f955b86880";
    String query;
    PApplet parent;
    XMLElement response;
    int numResults;
    int num = 1;
    GSPipeline pipe;
    String url;
    float vol = 1.0;
    int id;

    boolean fading = false;

    FSScraper(PApplet _parent,String _query){ 
        id = bank.size();
        
        query = _query;
        parent = _parent;

        reload();

    }

    void waitUntilEndAndReload(){
        fading = true;
    }

    void fadeOutAndReload(){
        if(!fading){
            fading = true;
        }
    }

    void reload(){
        if(pipe!=null)
            pipe.dispose();

        fading = false;
        String request = "http://tabasco.upf.edu/api/sounds/search?q="+query+"&api_key="+apiKey+"&format=xml";
        response = new XMLElement(parent,request);
        //numResults = response.getInt("num_results");

        XMLElement tmp[] = response.getChildren("sounds/resource/preview");

        url = tmp[(int)random(tmp.length)].getContent();
        pipe = new GSPipeline(parent, "gnomevfssrc location="+url+" ! mad ! audioconvert ! audioresample ! alsasink", GSVideo.AUDIO);

        if(pipe!=null){
            pipe.play();
            println("creating sample: "+query);
        } 

    }

    void play(){
        if(pipe!=null){
            pipe.play();
        }
    }

    void draw(int x,int y){
        stroke(255);
        noFill();
        rect(x,y,8*8,10);
        fill(255,120);
        noStroke();
        try{
            rect(x,y,map(pipe.time(),0,pipe.duration(),0,8*8),10);
            text(query,x+8*8+10,y+10);
            if(pipe.time()>=pipe.duration()-0.4 && pipe.duration()>0.1){
                pipe.dispose();
                bank.remove(this);
            }
        }catch(Exception e){
            //pipe.delete();
            //bank.remove(this);
        }
    }
}

