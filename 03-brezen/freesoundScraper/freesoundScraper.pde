//import ddf.minim.*;
import codeanticode.gsvideo.*;

//Minim minim;

String query[] = {"sing","piano","chord","distrortion"};//,"ring","phone"};
FSScraper bank[];

boolean useGS = true;

void setup(){
    size(320,240,P2D);

    frameRate(25);

    bank = new FSScraper[query.length];

    for(int i = 0;i<query.length;i++){
        bank[i] = (new FSScraper(this,query[i]));
        //   println(e);
    }
    /*
    for(int i = 0;i<query.length;i++){
        bank[i].pipe.play();// = (new FSScraper(this,query[i]));
        //   println(e);
    }*/


}

void keyPressed(){


    if(key == ' '){
        for(int i = 0;i<query.length;i++){
            //bank[i].pipe.delete();
            bank[i].reload();
            //bank[i].pipe.play();
        }
    }
    keyPressed = false;
}

void draw(){
    background(0);


    for(int i = 0 ;i<bank.length;i++){
        //FreesoundScraper fs = (FreesoundScraper)bank.get(i);
        bank[i].draw();
    }

}
/*
   void stop2(){
// always close Minim audio classes when you are done with them
for(int i = 0 ;i<bank.size();i++){
FreesoundScraper fs = (FreesoundScraper)bank.get(i);

AudioPlayer tmp = (AudioPlayer)fs.sample.get(0);
try{
tmp.close();
}catch(Exception e){
println(e);
}
}
minim.stop();

super.stop();
}*/


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

    /*
       println(tmp.length);
       for(int i = 0 ;i<tmp.length;i++){
       println(tmp[i].getContent());
       }

       sample.add(minim.loadFile(tmp[(int)random(tmp.length)].getContent()));
       AudioPlayer sam = (AudioPlayer)sample.get(0);
       sam.loop();       



       for(int i = 0 ;i<num;i++){

       String pre = tmp[(int)random(tmp.length)].getContent();
       sample.add(minim.loadSnippet(pre));
       AudioSnippet sam = (AudioSnippet)sample.get(i);
       sam.play();
       }

     */


    void play(){
        if(pipe!=null){
            pipe.play();
        }
    }

    void draw(){

        if(pipe.time()>=pipe.duration()-0.4 && pipe.duration()>0)
            reload();

    
    
    }
    //println(query+" : "+pipe.time() + " / "+pipe.duration());
    //if(pipe.time() >= pipe.duration()){
    //    pipe = new GSPipeline(parent, "playbin uri="+url, GSVideo.AUDIO);
    //pipe.goToBeginning();
    //    pipe.play();
    //}

}

