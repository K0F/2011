import peasy.*;
import processing.opengl.*;


String filename = "MattoMatto_vs_SoKoBaN-31380_25401.rpl";

int time;

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
    ArrayList qat = new ArrayList();
    ArrayList linvel = new ArrayList();
    ArrayList angvel = new ArrayList();
    ArrayList keyframes = new ArrayList();

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
                        String name = splitTokens(raw[i],";")[0];
                        boolean newdata = false;


                        if(name.equals("FRAME "+id)){
                        String positions = splitTokens(raw[i],";")[1];
                        keyframes = new ArrayList();
                        keyframes.add((int)parseInt(positions) );
                        cnt = pos.size();
                        newdata = true;
                        }else if(name.equals("POS "+id)){
                        String positions = splitTokens(raw[i],";")[1];
                        String p[] = splitTokens(positions," ");
                        pos = new ArrayList();
                        for(int ii = 0;ii < p.length-2;ii+=3){
                        pos.add(
                            new Point(pos.size(),(float)parseFloat(p[ii])*sc,(float)parseFloat(p[ii+1])*sc,(float)parseFloat(p[ii+2])*sc)
                            );
                        cnt = pos.size();
                        }
                        newdata = true;
                        }else if( name.equals("QAT "+id) ){
                        String positions = splitTokens(raw[i],";")[1];
                        String p[] = splitTokens(positions," ");
                        qat = new ArrayList();
                        for(int ii = 3;ii < p.length;ii+=4){
                        
                        qat.add(
                            new Point(qat.size(),(float)parseFloat(p[ii-2])*(float)parseFloat(p[ii-3]),(float)parseFloat(p[ii-1])*(float)parseFloat(p[ii-3]),(float)parseFloat(p[ii])*(float)parseFloat(p[ii-3]))
                            );

                        cnt = qat.size();
                        }
                        newdata = true;


                        }else if( name.equals("LINGVEL "+id) ){
                            String positions = splitTokens(raw[i],";")[1];
                            String p[] = splitTokens(positions," ");
                            linvel = new ArrayList();
                            for(int ii = 0;ii < p.length-2;ii+=3){
                                linvel.add(
                                        new Point(linvel.size(),(float)parseFloat(p[ii])*sc,(float)parseFloat(p[ii+1])*sc,(float)parseFloat(p[ii+2])*sc)
                                        );
                                cnt = linvel.size();
                            }
                            newdata = true;

                        }else if( name.equals("ANGVEL "+id) ){
                            String positions = splitTokens(raw[i],";")[1];
                            String p[] = splitTokens(positions," ");
                            angvel = new ArrayList();
                            for(int ii = 0;ii < p.length-2;ii+=3){
                                angvel.add(
                                        new Point(angvel.size(),(float)parseFloat(p[ii])*sc,(float)parseFloat(p[ii+1])*sc,(float)parseFloat(p[ii+2])*sc)
                                        );
                                cnt = angvel.size();
                            }
                            newdata = true;
                        }

                        if(newdata) 
                            poses.add(new Pose(pos,qat,linvel,angvel));

            }

        }

    }

    void draw(){

        int lastframe = (Integer)keyframes.get(keyframes.size()-1);
        time += 1;
        if(time>lastframe)
            time = 0;

        for(int i = 0;i<keyframes.size();i++){
            int currframe = (Integer)keyframes.get(i);
            if(time==currframe){
                phase = i;
            }
        }

        Pose pose = (Pose)poses.get(phase);
        pos = pose.pos;

        for(int i = 0 ;i<pos.size();i++){
            pushMatrix();
            Point tmp = (Point)pos.get(i);
            Point rot = (Point)qat.get(i);
            translate(tmp.x,tmp.y,tmp.z);
            rotateX((HALF_PI+rot.x)*TWO_PI);
            rotateY((HALF_PI+rot.y)*TWO_PI);
            rotateZ((HALF_PI+rot.z)*TWO_PI);
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
    ArrayList pos;
    ArrayList qat;
    ArrayList linvel;
    ArrayList angvel;

    Pose(ArrayList _pos,ArrayList _qat,ArrayList _linvel, ArrayList _angvel){
        pos = _pos;
        qat = _qat;
        linvel = _linvel;
        angvel = _angvel;
    }
}
