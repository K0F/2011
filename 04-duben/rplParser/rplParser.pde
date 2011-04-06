//
import peasy.*;
import processing.opengl.*;


String filename = "SoKoBaN_vs_uke-28731_3803.rpl";


float sc = 30;
Figure one,two;



void setup(){
    size(800,600,OPENGL);

    PeasyCam cam;

    cam = new PeasyCam(this, 100);
    cam.setMinimumDistance(50);
    cam.setMaximumDistance(500);

    one = new Figure(filename,0);
    two = new Figure(filename,1);
    stroke(255);
    noFill();
}



void draw(){
    rotateX(-.5);
    rotateY(-.5); 

    background(0);
    //pushMatrix();
    //scale(sc);
    //translate(width/2*0.001*sc,height/2*0.001*sc,0);
    one.draw();
    two.draw();
    //popMatrix();
}

class Figure{
    ArrayList pos = new ArrayList();
    ArrayList poses = new ArrayList();
    String raw[];
    int phase = 0;
    int id;

    Figure(String filename,int _id){
        id = _id;
        raw = loadStrings(filename);


        int cnt = 0;
        for(int i  = 0 ;i<raw.length;i++){
            if(raw[i]!=null){

                if(splitTokens(raw[i],";")[0].equals("POS "+id)){
                    String positions = splitTokens(raw[i],";")[1];
                    String p[] = splitTokens(positions," ");
                    pos = new ArrayList();
                    for(int ii = 0;ii < p.length-3;ii+=3){
                        pos.add(
                                new Point(pos.size(),(float)parseFloat(p[ii])*sc,(float)parseFloat(p[ii+1])*sc,(float)parseFloat(p[ii+2])*sc)
                               );
                    cnt = pos.size();
                    }
                    poses.add(new Pose(pos));
                     println(id + " : "+cnt);
                }

            }

        }

        //println(id + " : "+cnt);

    }

    void draw(){

        if(frameCount%10==0)
            phase ++;

        if(phase >= poses.size())
            phase = 0;


        Pose pose = (Pose)poses.get(phase);
        pos = pose.points;

        for(int i = 0 ;i<pos.size();i++){
            pushMatrix();
            Point tmp = (Point)pos.get(i);
            translate(tmp.x,tmp.y,tmp.z);
            box(5);
            //line(0,-0.01,0,0,0.01,0);
            popMatrix();

        }
    }


}

class Point{
    float x,y,z;
    int id;

    Point(int _id, float _x,float _y,float _z){
        id = _id;
        x = _x;
        y = _y;
        z = _z;
    }

}

class Pose{
    ArrayList points;

    Pose(ArrayList al){
        points = al;
    }
}
