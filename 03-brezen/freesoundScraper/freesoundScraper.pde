import codeanticode.gsvideo.*;

String query[] = {"crowd","dog","sinewave"};//,"ring","phone"};
FSScraper bank[];

boolean useGS = true;

void setup(){
    size(320,240,P2D);

    frameRate(25);

    bank = new FSScraper[query.length];

    for(int i = 0;i<query.length;i++){
        bank[i] = (new FSScraper(this,query[i]));
    }
    
}

void keyPressed(){


    if(key == ' '){
        for(int i = 0;i<query.length;i++){
            bank[i].reload();
        }
    }
    keyPressed = false;
}

void draw(){
    background(0);


    for(int i = 0 ;i<bank.length;i++){
        bank[i].draw();
    }

}

class FSScraper{
    String apiKey = "4daf76e033114821b7b686f955b86880";
    String query;
    PApplet parent;
    XMLElement response;
    int numResults;
    ArrayList sample = new ArrayList();
    int num = 1;
    GSPipeline pipe;
    String url;
    float vol = 1.0;

    boolean fading = false;

    FSScraper(PApplet _parent,String _query){
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
            pipe.delete();

        fading = false;
        String request = "http://tabasco.upf.edu/api/sounds/search?q="+query+"&api_key="+apiKey+"&format=xml";
        response = new XMLElement(parent,request);
        numResults = response.getInt("num_results");


        XMLElement tmp[] = response.getChildren("sounds/resource/preview");

        url = tmp[(int)random(tmp.length)].getContent();
        pipe = new GSPipeline(parent, "gnomevfssrc location="+url+" ! mad ! audioconvert ! audioresample ! alsasink", GSVideo.AUDIO);

        
        pipe.play();
        println("creating sample: "+query);
    }

    void play(){
        if(pipe!=null){
            pipe.play();
        }
    }

    void draw(){

        if(pipe.time()>=pipe.duration()-0.4 && pipe.duration()>0)
            reload();
    
    }
}

