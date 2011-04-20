

class FreeSoundLoader implements Runnable {


  String url;

  byte b[];

  public void run() {
    try {

      for (int p = 1; p <= pages; p++) {

        JSONObject data = new JSONObject(join(loadStrings("http://tabasco.upf.edu/api/sounds/search?q="+query+"&api_key="+api_key+"&p="+p+"&format=json"), ""));
        JSONArray entries = data.getJSONArray("sounds");
        int len = data.getInt("num_results");

        println("query "+query+" has "+len+" hits ... downloading page "+p);
        println("------------------------------");

        for (int i = 0; i < entries.length(); i++) {
          JSONObject entry = entries.getJSONObject(i);



          url = entry.getString("preview")+"?api_key="+api_key;//+"/"+tmp.getString("base_filename_slug")+".mp3";//+tmp.getString("type") ;
          b = new byte[0];
          b = loadBytes(url);

          saveBytes("sounds/"+query+"/"+entry.getString("base_filename_slug")+".mp3",b);//+entry.getString("type"),b);//+entry.getString("type"),b);

          img.add(loadImage(entry.getString("spectral_l")));
          PImage pg = (PImage)img.get(i);
          pg.save("images/"+query+"/"+entry.getString("base_filename_slug")+".png");

          name.add(entry.getString("base_filename_slug")+".mp3");//"+entry.getString("type"));
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

    exit();
  }
}
