
import processing.opengl.*;
/**
* Free Form construction by Kof 2010
*
*/


import peasy.*;



//////////////////////////////// >

PeasyCam cam;


float STEP = 0.3;
int NUM = 200;

Rez o[] = new Rez[NUM];

//////////////////////////////// >
void setup(){

	size(600,320,P3D);
	noStroke();
	fill(0,30);
	hint(DISABLE_OPENGL_2X_SMOOTH);
	//smooth();

	for(int i = 0;i<o.length;i++)
		o[i] = new Rez(i);

	cam = new PeasyCam(this, 800);
	cam.setMinimumDistance(600);
	cam.setMaximumDistance(3000);

	textFont(createFont("Norasi",12,true));
	//textMode(SCREEN);

}



//////////////////////////////// >
void draw(){


	background(2);

	/*
		stroke(0,10);
		for(int i = -o.length/2;i<o.length/2;i+=2){

			//   line(i*5,600,0,i*5,0,0);
			//    line(0,i*5,600,0,i*5,0);

			line(-300,-300,i*5,-300,300,i*5);
			line(-300,300,i*5,300,300,i*5);
			line(-300,300,i*5,300,300,i*5);
		}
	*/
	stroke(#6A4B2F,40);
	/*
		pushMatrix();
		resetMatrix();
		scale(0.001);
		translate(-738,-369);
		
		
		
		for(int n = 0;n<o.length;n++){
			beginShape();
			for(int i = 0;i<o[0].q;i++){
				//stroke(0,(sin(i/o.length)+1)*30);
				vertex(o[n].xs[i],o[n].ys[i],0);
			}
			endShape(CLOSE);
		}
		
		
		line(-width,0,width*3,0);
		line(0,-width,0,width*3);
		
		translate(507,0);
		for(int i = 0;i<o[0].q;i++){
			beginShape();
			for(int n = 0;n<o.length;n++){
				//stroke(0,(sin(i/o.length)+1)*30);
				vertex(o[n].zs[i],o[n].ys[i]);
			}
			endShape();
		}

		translate(-507,507);
		for(int i = 0;i<o[0].q;i++){
			beginShape();
			for(int n = 0;n<o.length;n++){
				//stroke(0,(sin(i/o.length)+1)*30);
				vertex(o[n].xs[i],o[n].zs[i]);
			}
			endShape();
		}

		popMatrix();

		for(int i = 0;i<o[0].q;i++){
			beginShape();
			for(int n = 0;n<o.length;n++){
				//stroke(0,(sin(i/o.length)+1)*30);
				vertex(o[n].xs[i],300,o[n].zs[i]);
			}
			endShape();
		}



		for(int i = 0;i<o[0].q;i++){
			beginShape();
			for(int n = 0;n<o.length;n++){
				//stroke(0,(sin(i/o.length)+1)*30);
				vertex(-300,o[n].ys[i],o[n].zs[i]);
			}
			endShape();
		}
	*/

	//	fill(255,120);
	//	text("Freeform construcion by Kof",width-220,height-10);

	//lights();

	pointLight(255, 127, 15, 300, 300, -100);
	ambientLight(10, 34, 102);
	lightSpecular(255, 255, 255);
	directionalLight(102, 102, 102, 0, 0, -100);
	specular(255, 255, 255);
emissive(0, 26, 51);
	noFill();
	//smooth();
	for(int i = 0;i<o.length;i++){
		o[i].draw2();
	}
	/*
		pushStyle();
		noFill();
		for(int i = 0;i<o[0].q;i++){
			beginShape();
			for(int n = 0;n<o.length;n++){
				stroke(0,(sin(i/o.length)+1)*30);
				vertex(o[n].xs[i],o[n].ys[i],o[n].zs[i]);
			}
			endShape();
		}
		popStyle();
	*/
	stroke(#FFFFFF,85);
	line(-width/4,0,0,width/4,0,0);
	line(0,-width/4,0,0,width/4,0);
	line(0,0,-600,0,0,600);

	//saveFrame("/desk/surfc/s####.png");

}

//////////////////////////////// >
class Rez{
	float x,y,r;

	float step = STEP;
	int id;
	float xs[],ys[],zs[];
	float xr[],yr[],zr[];

	int q = 0;

	Rez(int _id){
		id = _id;
		x = width/2;
		y = height/2;
		r = 40;


		for(float f = -PI;f < PI;f+=step)
			q++;

		xs = new float[q];
		ys = new float[q];
		zs = new float[q];

		xr = new float[q];
		yr = new float[q];
		zr = new float[q];


	}

	void draw2(){
		r  = noise((frameCount+id)/100.33)*120+noise((frameCount+id)/1000.43)*21+4;
		fill(127);
		noStroke();
		/*
				for(int i = 0;i<q;i++){
					xr[i] = 0;
					yr[i] = 0;
					zs[i] = map(id,0,o.length,-300,300);



				}


				for(int i = 0;i<q;i++){

					xr[i] += xs[i];
					yr[i] += ys[i];

				}


				for(int i = 0;i<q;i++){

					xr[i] /= q;
					yr[i] /= q;

				}

		*/
		int i = 0;
		for(float f = -PI;f < PI;f+=step){
			xs[i] = cos(f)*r*2*noise(cos(f/2.0)+id/10.0+frameCount/20.0)+(noise((id+frameCount)/101.0)-0.5)*500;
			ys[i] = sin(f)*r*2*noise(sin(f/2.0)+id/10.0+frameCount/20.1)+(noise((id+frameCount)/111.0)-0.5)*500;
			zs[i] = map(id,0,o.length,-300,300);
			i++;
		}
		//	zr[i] = id*5-((o.length/2)*5);


		/*
		strokeWeight(60-screenZ(xs[i],ys[i],zs[i])*60);

		stroke(#FFCC00,(-1*sin(f)+0.9)*35);


		if(abs(f-sin(frameCount/30.0)*TWO_PI)<0.2)
			stroke(#FFFFFF,(-1*sin(f)+0.9)*65);
		*/
		i=0;
		for(float f = -PI;f < PI;f+=step){

			if(id>1){
				beginShape(QUADS);
				/*normal(
				atan2(o[id-1].ys[i-1]-ys[i-1],o[id-1].xs[i-1]-xs[i-1]),0,0);/*
				atan2(ys[i-1]-ys[i],xs[i-1]-xs[i]),
				atan2(yr[i]-ys[i],xr[i]-xs[i])
				);*/
				int next = (i+q-1)%q;

				vertex(xs[i],ys[i],zs[i]);
				vertex(xs[next],ys[next],zs[next]);
				//normal(o[id-1].xs[i],o[id-1].ys[i],0);

				vertex(o[id-1].xs[next],o[id-1].ys[next],o[id-1].zs[next]);
				vertex(o[id-1].xs[i],o[id-1].ys[i],o[id-1].zs[i]);
				endShape();
			}
			i++;

		}




	}

	void draw(){

		r  = noise((frameCount+id)/100.33)*120+noise((frameCount+id)/1000.43)*21+4;
		//fill(255);
		beginShape();
		int i = 0;
		for(float f = -PI;f < PI;f+=step){
			xs[i] = cos(f)*r*2*noise(cos(f/2.0)+id/10.0+frameCount/20.0)+(noise((id+frameCount)/101.0)-0.5)*500;
			ys[i] = sin(f)*r*2*noise(sin(f/2.0)+id/10.0+frameCount/20.1)+(noise((id+frameCount)/111.0)-0.5)*500;
			zs[i] = id*5-((o.length/2)*5);

			strokeWeight(60-screenZ(xs[i],ys[i],zs[i])*60);

			stroke(#FFCC00,(-1*sin(f)+0.9)*35);


			if(abs(f-sin(frameCount/30.0)*TWO_PI)<0.2)
				stroke(#FFFFFF,(-1*sin(f)+0.9)*65);

			vertex(xs[i]+cos( (zs[i]-ys[i]) /100.0)*400.0,ys[i]+sin(xs[i]/1000.0)*200.0,zs[i]);
			i++;
		}
		endShape(CLOSE);
		strokeWeight(1);
		//no
	}
}
