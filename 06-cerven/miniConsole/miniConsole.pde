import processing.net.*; 
Client myClient;

String ip;
String req = "";
ArrayList history = new ArrayList(0);
int yshift = 0;


void setup(){
  
 size(320,240);
 
 textFont(loadFont("Monaco-9.vlw")); 
 
 myClient = new Client(this, "127.0.0.1", 80);
  ip = ""+myClient.ip();
  
}


void draw(){
 background(0);
 fill(255);
 
 for(int i = 0;i<history.size();i++)
 {
 String tmp = (String)history.get(i);
 text(tmp,10,i*12,width-20,height-10);
 }
 
 
 
 
 
 text("("+ip+")#> "+req);
 

 fill((sin(frameCount/2.0)+1)*127);
  text("_"); 
  
}

void keyPressed(){
 if(key >= '1' && key <= 'z'){
  req+=key; 
 }else if(keyCode==BACKSPACE){
   if(req.length()>0)
   req = req.substring(0,req.length()-1);
 }else if(key == ' '){
  req+=" "; 
 }else if(key == '.' || key == ',' || key == ';' || key == '(' || key == ')'){
   req+=key;
 }else if(keyCode==ENTER){
   history.add("("+ip+")#> "+req);
   req = "";
 }
}
