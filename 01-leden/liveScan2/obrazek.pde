

class Obrazek{
  PImage img;
  int id;
  String filename;
  String date;
  String numDate;
  int uniTime;

  Obrazek(int _id,String _filename){
    id = _id;
    filename = _filename;
    img = loadImage(sketchPath+"/obrazky/"+filename);
   // date = _date+"";
    
   /* String cas[] = splitTokens(date," ");
    numDate = cas[3];
    
    String tmp2[] = splitTokens(cas[3],":");
    int h = parseInt(tmp2[0]);
    int m = parseInt(tmp2[1]);
    int s = parseInt(tmp2[2]);
    
    uniTime = (s+(m*60)+(h*60*60));
    
    */
    
    
  }
  



}

