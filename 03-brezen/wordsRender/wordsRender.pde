/*
 *    geomerative example
 *
 *    fjenett 20080417
 *    fjenett 20081203 - updated to geomerative 19
 */

import geomerative.*;
import processing.opengl.*;
import peasy.*;

PeasyCam cam;

RFont font;

char [] chars = new char[400];

float rotsX[] = new float[chars.length];
float rotsY[] = new float[chars.length];
float rotsZ[] = new float[chars.length];

float speed = 3;

PGraphics saver;

boolean render = true;

void setup()
{
    size(400,400,OPENGL);
    hint(ENABLE_OPENGL_4X_SMOOTH);
    smooth();

    RG.init(this);

    font = new RFont( "/home/kof/.fonts/Aller_Rg.ttf", 12, RFont.CENTER);

    frameRate( 30 );
    noStroke();
    fill(0,12);



    for(int i = 0;i<chars.length;i++){
        chars[i] = (char)(int)random(62,120);

        rotsX[i] = random(360);
        rotsY[i] = random(360);
        rotsZ[i] = random(360);


    }

    cam = new PeasyCam(this,width/2,height/2,0,400);
      cam.setMinimumDistance(50);
        cam.setMaximumDistance(500);

    saver = createGraphics(width,height,P2D);
}

void draw()
{
    background(255);

    //translate(width/2,0);

    noFill();
    stroke(0,60);

    //rotateY(radians(frameCount));
    for(int i = 0 ;i<chars.length;i++){

        pushMatrix();
//strokeWeight(map(modelZ(0,0,0),-200,200,5,1.8));


        translate(width/2,height/2);
        rotateX(radians(rotsX[i]+=speed*noise(frameCount/30.0)));
        rotateY(radians(rotsY[i]+=speed*noise(frameCount/33.123)));
        rotateZ(radians(rotsZ[i]+=speed*noise(frameCount/29.2314)));
        //scale(1/(1.0+i));
        translate(2,5,noise(frameCount/400.0+i)*200);
       
        drawText(chars[i],1);
        popMatrix();
    }

    if(render)
    saveFrame("/desk/strings/frame####.png");
}


void drawText(char c,float sc){

    String name = c+"";
    RGroup grp = font.toGroup(name);

    // die folgenden einstellungen beinflussen wieviele punkte die
    // polygone am ende bekommen werden.

    //RCommand.setSegmentStep(random(0,3));
    //RCommand.setSegmentator(RCommand.UNIFORMSTEP);

    RCommand.setSegmentLength(random(2,5));
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

    //RCommand.setSegmentAngle(random(0,HALF_PI));
    //RCommand.setSegmentator(RCommand.ADAPTATIVE);

    grp = grp.toPolygonGroup();

    RPoint[] pnts = grp.getPoints();
        //ellipse(pnts[0].x, pnts[0].y, sc, sc);
    for ( int i = 1; i < pnts.length; i++ )
    
    {

 //       strokeWeight(modelZ(-1,0,0)/100.0);
        line( pnts[i-1].x, pnts[i-1].y, pnts[i].x, pnts[i].y );
        //rect(pnts[i].x, pnts[i].y, sc, sc);
    }

}

