
class Slozka {
  int pocetStran;
  int current;
  int lastLength = 0;

  String cesta;
  String[] filenames = {
    "nic"
  };


  Slozka() {

    cesta = sketchPath + "/obrazky";
    println("nacitam pobrazky z " + cesta); 


    refresh();
  }

  boolean hasNew() {
    if(listFileNames(slozka.cesta).length!=lastLength)
      return true;
    else
      return false;
  }

  void refresh() {
    String [] tmp = listFileNames(cesta);
    //println(filenames[0]);

    if(filenames.length==0) {
      println("slozka je prazdna");
      wait = true;
    }
    else if(filenames.length>=1 && tmp.length!=filenames.length) {
      println("nalezen novy soubor");

      wait = false;


      int idx[] = new int[0];
      for(int i = 0;i<tmp.length;i++) {
        for(int q = 0;q<filenames.length;q++) {

          boolean neue = false;
          if(!tmp[i].equals(filenames[q])) {
            neue = true;
          }

          if(neue) {
            idx = (int[])expand(idx,idx.length+1);
            idx[idx.length-1] = i;
          }
        }
      }

      for(int i = 0;i<idx.length;i++) {
        println("pridavam obrazek: "+tmp[idx[i]]);
        obrazky = (Obrazek[])expand(obrazky,obrazky.length+1);
        obrazky[obrazky.length-1] = new Obrazek(filenames.length-1,tmp[idx[i]]);
      }
    }


    filenames = new String[tmp.length];

    for(int i = 0;i<tmp.length;i++) {
      filenames[i] = tmp[i]+"";
    }

    lastLength = filenames.length;
  }
}

