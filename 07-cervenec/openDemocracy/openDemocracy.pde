/**
*  Open Democracy project to watch czech parliment by kof
*/

import seltar.unzipit.*;


Zaznam zaznam;

void setup(){

    size(640,480,P2D);

    zaznam = new Zaznam(this,sketchPath+"/data/001schuz.zip");



    


}



void draw(){


}


class Zaznam{

    PApplet parent;
    String raw[];
    String filename;
    UnZipIt root;
    int id;
    float date;

    Zaznam(PApplet _parent,String _filename){
        
        parent = _parent;
        filename = _filename;
        
        root  = new UnZipIt(filename,parent);

        String filenames[] = root.getFilenames();
        raw = new String[filenames.length];
        
        for(int i = 0;i<filenames.length;i++){

            raw[i] = root.loadString(filenames[i]);

        }

        println("soubor "+filename+" otevren! Nalezeno "+filenames.length+" jednotlivych zaznamu.");
    

    println(raw[5]);
    }
}
