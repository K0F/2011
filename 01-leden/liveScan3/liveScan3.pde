
Slozka slozka;
ArrayList obrazky = new ArrayList(0);
int obr = 0;
int start = 0;
int pocitadlo = 0;

boolean wait = true;

void setup() {
  size(screen.width,screen.height,P2D);
  slozka = new Slozka();
  background(0);
}


void draw() {


  if(frameCount%50==0 && slozka.hasNew()) {
    slozka.update();
  }

  if(obr+1>slozka.num() && !wait) {
    println("konec smycky");
    wait = true;
  }


  if(!wait) {

    if(slozka.num()>0) {
      //pushMatrix();

      PImage tmp = (PImage)obrazky.get(obr);

      //translate(width/2-tmp.width/2,height/2-tmp.height/2);


      for( int y = start; y < (pocitadlo);y+=2) {    
        for( int x = 0 ; x < tmp.width;x++) {
          stroke( tmp.pixels[ y * tmp.width + x ] );
          point(width/2-tmp.width/2+x,height/2-tmp.height/2+y);
        }
      }

      //popMatrix();

      pocitadlo = pocitadlo + 1;

      if(pocitadlo >= tmp.height) {
        if(start == 0) {

          start = 1;
        }
        else {


          obr += 1;

          start = 0;
        }

        pocitadlo = start;
      }
    }
  }
}



class Slozka {
  ArrayList soubory = new ArrayList(0);
  String cesta;

  Slozka() {
    cesta = sketchPath + "/obrazky";

    println("oteviram slozku "+ cesta);


    if(hasNew()) {
      update();
    }
    else {
      wait = true;
      println("slozka je prazdna");
    }
  }

  int num() {
    return soubory.size();
  }


  void update() {
    println("update");
    String [] tmp = listFileNames(cesta);

    if(soubory.size()==0) {

      for(int i = 0;i<tmp.length;i++) {
        println("pridavam: "+tmp[i]);
        soubory.add(tmp[i]);
        obrazky.add(loadImage(cesta+"/"+tmp[i]));
      }
      wait = false;
    }
    else {


      int len = num();
      for(int i =0 ;i<tmp.length;i++) {
        
        boolean neue = true;
        
        for(int q =0 ;q<len;q++) {
          String s = (String)soubory.get(q);

          if(tmp[i].equals(s)) {
            neue = false;
          }
        }

        if(neue) {
          println("pridavam: "+tmp[i]);
          soubory.add(tmp[i]);

          obrazky.add(loadImage(cesta+"/"+tmp[i]));
        }
      }
      wait = false;
    }
  }

  boolean hasNew() {
    if(listFileNames(cesta).length!=num())
      return true;
    else
      return false;
  }
}

