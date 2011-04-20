import org.json.*;

String query =  "beep";
int pages = 10;

ArrayList img = new ArrayList(0);
ArrayList name = new ArrayList(0);

String api_key = "4daf76e033114821b7b686f955b86880";


void setup() {
  size(600,800,P2D);
  textFont(createFont("Vernada",9,true));
  textMode(SCREEN);

  Runnable runnable = new FreeSoundLoader();
  Thread thread = new Thread(runnable);
  thread.start();
}

void draw() {

  background(20);
  fill(255);

  text("Query: "+query+"\n-----------------------------------------------",10,20);
  
  for(int i = 0;i<name.size();i++) {
    String s = (String)name.get(i);
    text(s,50,i*10+40);
    PImage im = (PImage)img.get(i);
    image(im,10,i*10+30,30,10);
  }
  
}


