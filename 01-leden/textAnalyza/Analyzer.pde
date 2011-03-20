class Analyzer {
  String[] raw;
  ArrayList vety = new ArrayList(0);
  ArrayList slova = new ArrayList(0);
  int cetnost[] = new int[0];

  Slovo slv[];


  Analyzer() {

    //load text into raw[]
    raw = loadStrings(jmenoSouboru);

    //split into sentences
    for(int i = 0;i<raw.length;i++) {
      if(!raw[i].equals("")) {
        String [] tmp = split(raw[i],".");
        for(int v = 0;v<tmp.length;v++) {
          //tmp[v]+=".";
          vety.add(tmp[v]);
        }
      }
    }


    for(int i = 0 ;i<vety.size();i++) {
      String is = (String)vety.get(i);
      if(!is.equals("")) {
        String tmp[] = split((String)vety.get(i)," ");
        for(int s = 0 ;s<tmp.length;s++) {
          if(tmp[s].length() >0)          
            if(tmp[s].charAt(0)!=' ') {
              cetnost = expand(cetnost,cetnost.length+1);
              cetnost[cetnost.length-1] = 1;
              slova.add(tmp[s]);
            }
        }
      }
    }





    slv = new Slovo[slova.size()];


    for(int i = 0;i<slova.size();i++) {

      slv[i] = new Slovo((String)slova.get(i));

      for(int z = 0;z<slova.size();z++){
        String A = (String)slova.get(i);
        String B = (String)slova.get(z);
        if(A.equals(B) && z!=i) {
          cetnost[i]++;
        }
      }

      slv[i].nastavCetnost(cetnost[i]);
      String [] kntxt = new String[2];
      
      if(i-1>0)
      kntxt[0] = ""+(String)slova.get(i-1);
      
      if(i+1<slova.size())
      kntxt[1] = ""+(String)slova.get(i+1);
      
      slv[i].nastavKontext(kntxt);
    }

    println("sorting ...");
    Arrays.sort(slv);
    println("done!");



    maxCetnost = slv[0].cetnost;

    println("cutting...");

    for(int i = 0;i<slv.length;i+=slv[i].cetnost+1) {
      //if(slv[i].obsah.length()>2)
        s.add(slv[i]);
    }

    println("done");
  }
}

