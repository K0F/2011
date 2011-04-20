

class FreeSoundLoader implements Runnable {

  String lquery;
  String url;

  byte b[];

  FreeSoundLoader(Strnig _lquery) {
    lquery = _lquery;
  }

  public void run() {
    try {

      for (int p = 1; p <= pages; p++) {

        JSONObject data = new JSONObject(join(loadStrings("http://tabasco.upf.edu/api/sounds/search?q="+lquery+"&api_key="+api_key+"&p="+p+"&format=json"), ""));
        JSONArray entries = data.getJSONArray("sounds");
        int len = data.getInt("num_results");

        println("query "+lquery+" has "+len+" hits ... downloading page "+p);
        println("------------------------------");

        for (int i = 0; i < entries.length(); i++) {
          JSONObject entry = entries.getJSONObject(i);

          String filename = entry.getString("base_filename_slug");

          url = entry.getString("preview")+"?api_key="+api_key;//+"/"+tmp.getString("base_filename_slug")+".mp3";//+tmp.getString("type") ;
          //b = new byte[0];
          b = loadBytes(url);


          saveBytes("sounds/"+lquery+"/"+filename+".mp3",b);//+entry.getString("type"),b);//+entry.getString("type"),b);

          img.add(loadImage(entry.getString("spectral_l")));
          PImage pg = (PImage)img.get(i);
          pg.save("images/"+lquery+"/"+filename+".png");

          name.add(filename+".mp3");//"+entry.getString("type"));

          //sample.add( minim.loadFile( "sounds/"+query+"/"+filename+".mp3" )  );
          print("#");
        }
        println("");
      }
    }
    catch (JSONException e) {
      println (e.toString());
    }

    println("  done!");
    println("------------------------------");
    println("");

    //exit();
  }
}

