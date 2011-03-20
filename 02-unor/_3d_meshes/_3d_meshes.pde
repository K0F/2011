//import net.java.games.jogl.*;

import processing.opengl.*;
import peasy.*;

PeasyCam cam;

Shape s[];

float msize = 1;
float len = 1.2;

ArrayList infoX;
ArrayList infoY;

//GL gl;

void setup(){
	size(640,480,OPENGL);
	cam = new PeasyCam(this, 100);
	cam.setMinimumDistance(50);
	cam.setMaximumDistance(500);


	//gl = ((PGraphicsGL)g).gl;
	// gl.glEnable(GL.GL_CULL_FACE);

	infoX = new ArrayList();
	infoY = new ArrayList();

	s = new Shape[1];

	for(int i = 0 ;i < s.length;i++)
		s[i] = new Shape(50);

	stroke(255);
	textFont(createFont("Verdana",10));
	//textMode(SCREEN);
}


void draw(){
	background(255);

	noStroke();
	fill(255,0,0,100);

	for(int i = 0 ;i < s.length;i++){

		s[i].render();

	}

	cam.beginHUD();
	fill(255);
	for(int t = 0;t<infoX.size();t++){
		text(t,(Float)infoX.get(t),(Float)infoY.get(t));
	}
	cam.endHUD();

}

void keyPressed(){
	for(int i = 0 ;i < s.length;i++)
		s[i].nextGen();

}


class Shape{
	ArrayList <PVector> pnt;
	ArrayList <PVector> pntRef;

	float r;
	PVector center;
	PVector ref;

	Shape(float _r){
		pnt = new ArrayList();
		pntRef = new ArrayList();
		r = _r;

		for(int i = 0;i<3;i++){
			pnt.add(new PVector(0,random(-r,r),random(-r,r)));

			PVector tmp = (PVector)pnt.get(i);

			infoX.add(screenX(tmp.x,tmp.y,tmp.y));
			infoY.add(screenY(tmp.x,tmp.y,tmp.y));

		}
	}

	void nextGen(){
		int start = pnt.size()-3;
		for(int i = start;i<start+3;i++)
		{   PVector cur = (PVector)pnt.get(i);

			/*

				pntRef.add(new PVector(
				               lerp(0,cur.x,len),
				               lerp(0,cur.y,len),
				               lerp(0,cur.z,len)
				           ));

				//cur = (PVector)pntRef.get(i);
				pnt.add(new PVector(
				            lerp(ref.x,cur.x,0.7),
				            lerp(ref.y,cur.y,0.7),
				            lerp(ref.z,cur.z,0.7)

				        ));

				    */    
			pnt.add(new PVector(cur.x+10,cur.y,cur.z));


			PVector tmp = (PVector)pnt.get(i);


			infoX.add(screenX(tmp.x,tmp.y,tmp.y));
			infoY.add(screenY(tmp.x,tmp.y,tmp.y));
		}
	}




	void render(){

		for(int v = 0;v<pnt.size()-5;v+=3){

			beginShape(TRIANGLES);

			kofVertex(v+0);
			kofVertex(v+1);
			kofVertex(v+3);

			kofVertex(v+1);
			kofVertex(v+2);
			kofVertex(v+4);

			kofVertex(v+2);
			kofVertex(v+0);
			kofVertex(v+5);

			kofVertex(v+3);
			kofVertex(v+1);
			kofVertex(v+4);

			kofVertex(v+4);
			kofVertex(v+2);
			kofVertex(v+5);

			kofVertex(v+5);
			kofVertex(v+0);
			kofVertex(v+3);


			endShape(CLOSE);




		}

		float cx = 0;
		float cy = 0;
		float cz = 0;
		for(int i = 0;i<pnt.size();i++){
			PVector tmp = (PVector)pnt.get(i);

			drawPoint(tmp.x,tmp.y,tmp.z);

			infoX.set(i,screenX(tmp.x,tmp.y,tmp.z));
			infoY.set(i,screenY(tmp.x,tmp.y,tmp.z));



			cx+=(tmp.x-cx)/2.0;
			cy+=(tmp.y-cy)/2.0;
			cz+=(tmp.z-cz)/2.0;
		}

		stroke(#ff0000);
		drawPoint(cx,cy,cz);
		/*
				ref = new PVector(
				          lerp(0,cx,len),
				          lerp(0,cy,len),
				          lerp(0,cz,len)
				      );
		*/
		//drawPoint(ref);


	}

	void kofVertex(int _i){
		PVector tmp = (PVector)pnt.get(_i);
		vertex(tmp.x,tmp.y,tmp.z);


	}

	void drawPoint(float _x,float _y,float _z){
		line(_x+msize,_y,_z,_x-msize,_y,_z);
		line(_x,_y+msize,_z,_x,_y-msize,_z);
		line(_x,_y,_z+msize,_x,_y,_z-msize);
	}

	void drawPoint(PVector _v){
		line(_v.x+msize,_v.y,_v.z,_v.x-msize,_v.y,_v.z);
		line(_v.x,_v.y+msize,_v.z,_v.x,_v.y-msize,_v.z);
		line(_v.x,_v.y,_v.z+msize,_v.x,_v.y,_v.z-msize);
	}
}


