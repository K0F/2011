/*
 *    geomerative example
 *
 *    fjenett 20080417
 *    fjenett 20081203 - updated to geomerative 19
 */

import geomerative.*;
import processing.opengl.*;

RFont font;

void setup()
{
	size(640,320,OPENGL);
	smooth();
	hint(ENABLE_OPENGL_2X_SMOOTH);

	RG.init(this);

	font = new RFont( "Aller_Rg.ttf", 90, RFont.CENTER);
	//hint(ENABLE_NATIVE_FONTS);

	frameRate( 50 );
	stroke(0,150);
	//fill(0,120);
}

void draw()
{
	background(255);
	translate(width/2,height/2);



	// die folgenden einstellungen beinflussen wieviele punkte die
	// polygone am ende bekommen werden.

	//RCommand.setSegmentStep(random(0,3));
	//RCommand.setSegmentator(RCommand.UNIFORMSTEP);

	//RCommand.setSegmentLength(2);
	//RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

	//RCommand.setSegmentAngle(random(0,HALF_PI));
	//RCommand.setSegmentator(RCommand.ADAPTATIVE);
	
	String gen = "";
	for(int i = 0 ;i<4;i++){
		gen += (char)(int)random(64,78);
	}

	RGroup grp = font.toGroup(gen);

	grp = grp.toPolygonGroup();


	for ( int i = 0; i < grp.elements.length; i++ )                     // elemente durchlaufen
	{
		RShape shp = grp.elements[i].toShape();

		for ( int ii = 0; ii < shp.paths.length; ii++ )             // shapes durchlaufen
		{
			RPoint[] pnts = shp.getPoints();
			//println(pnts.length);

			beginShape();
		//vertex(pnts[0].x,pnts[0].y);
			for ( int iii = 0; iii < pnts.length; iii++ )             // shapes durchlaufen
			{
				vertex(pnts[iii].x,pnts[iii].y);
			}
		
		//vertex(pnts[pnts.length-1].x,pnts[pnts.length-1].y);
			endShape(CLOSE);

		}
	}


	/*

	RPoint[] pnts = grp.getPoints();

	// ellipse(pnts[0].x, pnts[0].y, 5, 5);
	beginShape();
	for ( int i = 1; i < pnts.length; i++ )
{
	//if(dist(pnts[i-1].x, pnts[i-1].y, pnts[i].x, pnts[i].y)<10)
	//break;
	vertex( pnts[i-1].x, pnts[i-1].y );
	//   ellipse(pnts[i].x, pnts[i].y, 5, 5);
}

	endShape(CLOSE);*/
}

