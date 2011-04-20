
Obrazek obrazky[] = new Obrazek[0];
Slozka slozka;

int start = 0;
int obr = 0;
int pocitadlo = 0;

boolean wait = true;

void setup(){
  size(screen.width,screen.height,P2D);
  slozka = new Slozka();

  frameRate(50);

  background(0);
}

void draw(){

  
  if(frameCount%120==0){

    if(slozka.hasNew()){
      wait = false;
      slozka.refresh();
    }  
  }


  if(!wait){
    kresba();
  }

}



void kresba(){

  if(obrazky.length!=0){

    pushMatrix();
    translate(width/2-obrazky[obr].img.width/2,height/2-obrazky[obr].img.height/2);


    for( int y = start; y < (pocitadlo);y+=2){    
      for( int x = 0 ; x < obrazky[obr].img.width;x++){
        stroke( obrazky[obr].img.pixels[ y * obrazky[obr].img.width + x ] );
        point(x,y);
      }
    }

    popMatrix();

    pocitadlo = pocitadlo + 1;

    if(pocitadlo >= obrazky[obr].img.height){
      if(start == 0){

        start = 1;
      }
      else{
        obr += 1;
        start = 0;
      }

      pocitadlo = start;

      if(obr>=obrazky.length){

        // Quit running the sketch once the file is written
        println("konec smycky, cekam na novy obraz ...");  
       // obr = 0;
        wait = true;
      }
    }
  }
}








