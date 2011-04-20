import org.json.*;
//import ddf.minim.*;
//import javax.sound.sampled.*;

String query =  "";
int pages = 1;

//Minim minim;
//AudioOutput out;

ArrayList img = new ArrayList(0);
ArrayList name = new ArrayList(0);
ArrayList sample = new ArrayList(0);

String api_key = "4daf76e033114821b7b686f955b86880";

void setup() {
  size(900,900);
  textFont(createFont("Vernada",9,true));
 // textMode(SCREEN);
  frameRate(25);
  //mixerInfo = AudioSystem.getMixerInfo();
  //minim = new Minim(this);
 // minim.getLineOut(Minim.MONO,512);

  // mainOut = minim.getLineOut();


  
}

void search(){
  
  img = new ArrayList(0);
name = new ArrayList(0);
sample = new ArrayList(0);
  
  Runnable runnable = new FreeSoundLoader(query);
  Thread thread = new Thread(runnable);
  thread.start();
  
  
}

void keyPressed()
{
  //if ( key >= 0 && key <= 9 )
  //{
    
    
   

    
   // AudioPlayer s = (AudioPlayer)sample.get((int)random(sample.size()));
   // s.play();
  //}
}



void draw() {

  background(20);
  fill(255);

  text("Query: "+query+"\n-----------------------------------------------",10,20);
  for(int i = 0;i<name.size();i++) {
    String s = (String)name.get(i);
    PImage im = (PImage)img.get(i);
    
    if(mouseY>=i*10+40 && mouseY < i*10+50){
          image(im,0,height-im.height);
           fill(#FFCC00); 
    }else{
       fill(255); 
    }
    
    
    image(im,10,i*10+40,50,10);
    
    text(s,65,i*10+50);
    
    
  
    
    
    }
}
/*
void stop()
{
  // always close Minim audio classes when you are done with them
  for(int i = 0;i<sample.size();i++) {
    AudioPlayer s = (AudioPlayer)sample.get(i);
    s.close();
  }
  minim.stop();

  super.stop();
}*/

