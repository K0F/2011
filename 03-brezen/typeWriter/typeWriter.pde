import processing.opengl.*;

PFont font;

String complete[];
ArrayList tx = new ArrayList();

boolean render = true;

void setup(){
    size(1024,768,OPENGL);

    complete = loadStrings("text.txt");

    for(int i = 0;i<complete.length;i++){
        tx.add(new LineDisp(complete[i],80+i*30f));
    }


    font = createFont("Aller",92,true);
    fill(255,127);
}


void draw(){
    background(0);

    for(int i = 0;i<tx.size();i++){
        LineDisp tmp = (LineDisp)tx.get(i);
        tmp.draw();

    }

    if (render){
        saveFrame("/desk/textAnalysis/txt####.png");
    }


}


class LineDisp{
    String tex;
    float sizes[];

    float x = 0;
    float y;

    float W;
    LineDisp(String _tex,float _y){
        tex = _tex;
        y = _y;
        sizes = new float[tex.length()];

        for(int i= 0;i<sizes.length;i++){
            sizes[i] = random(12,32);

        }

        W = width;
    }


    void draw(){
        x = 0;
        
        for(int i = 0 ; i<tex.length() ; i++){
            sizes[i] = noise((frameCount)/((int)tex.charAt(i)/2.0))*92; //noise(frameCount/80.0) * noise((frameCount)/(30.0+i)) * 32;
            textFont(font,sizes[i]);
            x+=textWidth(tex.charAt(i));
        }

        W = x;

        pushMatrix();
        translate(0,y);
        scale(width/W);

        x = 0;    
        for(int i = 0 ; i<tex.length() ; i++){
            textFont(font,sizes[i]);
            text(tex.charAt(i),x,0);
            x+=textWidth(tex.charAt(i));
        }

        popMatrix();

    }


}
