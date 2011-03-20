import processing.opengl.*;



String jmenoSouboru = "input.txt";

Analyzer an;
ArrayList s = new ArrayList(0);
PFont f;

int maxCetnost;

Node[] nod;

void setup() {

  size(640,400,P2D);

  f=createFont("Monospaced",100,true);
  textFont(f,12);
   textAlign(CENTER);

  an = new Analyzer();
  
  nod = new Node[s.size()];
  for(int i = 0 ;i<nod.length;i++){
   nod[i] = new Node((Slovo)s.get(i),i); 
  }
  
  for(int i = 0 ;i<nod.length;i++){
  nod[i].najdiKontext();
  }
}

void draw() {
  background(255);

  fill(0);
  
  for(int i = 0 ; i <  nod.length;i++){
    nod[i].draw();
  }
}





