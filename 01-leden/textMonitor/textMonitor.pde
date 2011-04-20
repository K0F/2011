// a través de los métodos textWidth(), textAscent() y textDescent() pintaremos el cuadro donde se inscribe cada letra de un mensaje

String mensaje="";
String raw[];


  int gap=24;

color c[];

int shift = 0;
float alphas[];

PFont fontA;
void setup(){
  //colorMode(HSB, 255, 255, 255);
  size(screen.width,screen.height,P2D);
  textMode(SCREEN);
  
  fontA = createFont("Vernada",gap,true);
  frameRate(50);
  smooth();
  raw = loadStrings("input.txt");
  
  for(int i =0;i<raw.length;i++){
  mensaje += raw[i]+"";
  }

  alphas = new float[mensaje.length()];
  for(int i =0;i<alphas.length;i++){
    alphas[i] = 255;
  }
  c = new color[512];
  for(int i =0;i<c.length;i++){
    c[i] = color(25,200,255);//color(random(255),150,200);
  }

}

float adv = 0;

void draw(){
  background(0);
  textFont(fontA);
  textAlign(LEFT);

  int longitudMensaje=mensaje.length();

  float posicionX=0;
  float posicionY=0;


  if(frameCount%(int)(mouseX/100+1)==0)
    shift++;


  if(shift>126)
    shift=49;

  for(int posicion=0; posicion<longitudMensaje; posicion++){

    char caracterActual=mensaje.charAt(posicion);

    float alturaMaximaExacta=textAscent();
    float alturaMinimaExacta=textDescent();
    alphas[posicion] = noise((frameCount+posicion)/30.0)*255;

    float anchoCaracter=textWidth(caracterActual);
    noStroke();
    //fill(c[((int)caracterActual+shift)%c.length],map((shift-(int)mensaje.charAt(posicion)),0,255,255,0));
    
    adv +=( (int)mensaje.charAt(posicion)-adv) / 1;
    fill(255, sin(frameCount/(adv-49.0)*(mouseX/10.0))*127 );


    if(posicionX+anchoCaracter>=width){
      posicionX=0;
      posicionY+=alturaMaximaExacta;
    }
    // rect(posicionX, posicionY, anchoCaracter, alturaMaximaExacta);

    //fill(0);
    text(caracterActual, posicionX, posicionY+gap);

    posicionX=posicionX+anchoCaracter;

  }
}



