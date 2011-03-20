
class Node {
  Slovo slovo;
  float x,y;
  int id;
  int kontext[] = new int[0];

  Node(Slovo _slovo,int _id) {
    id = _id;
    slovo = _slovo;
    x = random(width);//map(slovo.cetnost,64,0,0,width); 
    y = random(height);//height-2;
  }

  void najdiKontext() {


    for(int q = 0;q<slovo.kontext.length;q++) {
      boolean mam = false;
      for(int i = 0;i<an.slv.length;i++) {
        if(mam)continue;
        
        String current = an.slv[i].obsah+"";

        for(int k = 0;k<an.slv[i].kontext.length;k++) {  
          if(slovo.kontext[q].equals(current)) {
            mam = true;
            println(slovo.obsah + " " + an.slv[i].obsah);
          }
        }
      }
    }


/*
    for(int q = 0;q<slovo.kontext.length;q++) {
      for(int i = 0;i<an.slv.length;i++) {
        String current = an.slv[i].obsah+"";
        if(current.equals(an.slv[i].kontext[q])) {
          for(int n = 0;n<nod.length;n++) {
            if(nod[n].slovo.obsah.equals(current)) {
              kontext = expand(kontext,kontext.length+1);
              kontext[kontext.length-1] = nod[n].id;
            }
          }
        }
      }
    }*/

    if(kontext.length>0)
      println(slovo.obsah+" "+kontext[0]);
  }




  void draw() {


    // x+=(width/2-x)/map(slovo.cetnost,1,maxCetnost,1000,30);
    // y+=(height/2-y)/map(slovo.cetnost,1,maxCetnost,1000,30);

    /*textFont(f,12);
     fill(#ff0000,80);
     for(int i = 0;i<slovo.kontext.length;i++)
     text(slovo.kontext[i],x+10,y);
     */

    strokeWeight(2);
    stroke(0,5);
    for(int i = 0 ;i<kontext.length;i++) {
      line(x,y,nod[kontext[i]].x,nod[kontext[i]].y);
    }

    textFont(f,map(slovo.cetnost,1,maxCetnost,12,80));
    fill(0,map(slovo.cetnost,1,maxCetnost,7,200));
    fill(0,100);
    text(slovo.obsah,x,y);

    //text(slovo.cetnost,x-10,y-map(slovo.cetnost,1,maxCetnost,7,50));
  }
}

