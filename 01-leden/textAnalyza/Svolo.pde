
class Slovo implements Comparable {
  String obsah;
  int cetnost;
  int poradi;
  String [] kontext;

  Slovo(String _obsah) {
    obsah = ""+_obsah;
  }

  Slovo(String _obsah,int _cetnost) {
    obsah = ""+_obsah;
    cetnost = _cetnost;
  }

  void nastavKontext(String [] _kontext) {
    kontext = new String[_kontext.length];
    for(int i = 0;i<_kontext.length;i++)
      kontext[i]=_kontext[i]+"";
  }

  void nastavCetnost(int _in) {
    cetnost = _in;
  }

  int compareTo(Object o)
  {
    Slovo other = (Slovo)o;
    if(other.cetnost>cetnost) 
      return 1;

    else if(other.cetnost==cetnost)
      return 0;

    else 
      return -1;
  }
}

