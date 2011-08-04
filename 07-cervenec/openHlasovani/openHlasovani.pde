Parser parser;
ArrayList hlasovani;

void setup(){
    size(640,640);

    hlasovani = new ArrayList();
    parser = new Parser();

    textFont(createFont("Sans",9,false));
}


void draw(){

    background(255);

    fill(0);

    for(int i = 0 ; i < hlasovani.size();i++){
        Hlasovani tmp = (Hlasovani)hlasovani.get(i);
        String nazev = tmp.nazev;
        text(nazev,10,i*10+10);
    }

}

class Parser{

    int obdobi = 20;
    int schuze = 1;
    String query;
    String rawHtml[];

    Parser(){


        for(int sch =1 ; sch < 20;sch ++ ){

            schuze = sch;
            query = mkQuery(obdobi,schuze);

            rawHtml = loadStrings(query);

            ArrayList hrefs = new ArrayList();

            for(int i = 0;i<rawHtml.length; i++){
                String[] tmp = match(rawHtml[i],"(\\<td .*</td>)");


                if(tmp!=null){
                    for(int ii = 0; ii < tmp.length ; ii+=2 ){

                        //  println(tmp[ii]);                    

                        if(!tmp[ii].equals("")){

                            String raw = match(tmp[ii],"(\\<TD valign=top>.*</TD>)")[0];
                            String nazev = raw.substring(15,raw.indexOf("</TD>"));
try{

                            hlasovani.add(new Hlasovani(new String(nazev.getBytes("ISO-8859-2"),"UTF-8")));
}catch(Exception e){
        
}
//println();

                            // println(">>>>>>>>> "+ nazev);
                            //println();
                        }

                        //if(tmp[0].indexOf("<td valgin=\"top\">")>-1){

                        /*
                           String tt[] = match(tmp[ii],"(\\<TD valgin=top>)");

                           if(tt!=null){
                           String nazev = tt[0].substring(17,tt[0].length());


                           println(nazev);
                           }
                           hrefs.add(new Hlasovani());
                         */
                        //}
                        //  println("////////////////////////////////////////");
                    }
                }
            }
            /*       
                     for(int i = 0 ; i < hrefs.size();i++){
                     String pure[] = splitTokens((String)hrefs.get(i),"\"");
                     rawHtml = loadStrings("http://www.psp.cz/cgi-bin/win/sqw/"+pure[1]);

            //saveStrings("dump"+i+"html",rawHtml);
            }
             */
        }
    }



    String mkQuery(int _obdobi,int _schuze){
        String _query = "http://www.psp.cz/sqw/phlasa.sqw?o=";
        _query += _obdobi;
        _query += "&s="+_schuze;
        return _query;
    }



}


class Hlasovani{
    int schuze;
    int chlasovani;
    int bod;
    String nazev;
    String datum;
    boolean vysledek;

    Hlasovani(String _nazev){
        nazev = _nazev;
    }


}

