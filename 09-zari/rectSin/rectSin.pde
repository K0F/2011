
import processing.opengl.*;
import javax.media.opengl.GL;


PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

float ratio;
boolean rec = false;


void setup(){
	size(1280,720,OPENGL);


	noiseSeed(19);

	rectMode(CENTER);
	ratio = (height/(width+0.0));
	frameRate(25);

	pgl = (PGraphicsOpenGL) g; //processing graphics object
	gl = pgl.beginGL(); //begin opengl
	gl.setSwapInterval(1); //set vertical sync on
	pgl.endGL(); //end opengl

	hint(ENABLE_OPENGL_2X_SMOOTH);

	background(0);


}


void draw(){
	background(0);


	for(int i = 0 ; i< 10;i++){

		pushMatrix();

		translate(noise((frameCount+i)/5.0)*2-1,noise((frameCount+i)/6.0)*2-1);

		noStroke();

		float r1 = (sin(frameCount/300.0)+1.0)*(sin(frameCount/301.0)+1.0)*(sin(frameCount/301.3713)+1.0)*height/8.0+5;

		float r2 = (sin(frameCount/312.33)+1.0)*(sin(frameCount/307.033)+1.0)*(sin(frameCount/309.371333)+1.0)*height/8.0+5;


		boolean inverse = r1>=r2?true:false;


		if(inverse){
			fill(255,45);

			rect(width/2,height/2,r1,r1*ratio);


			fill(0);


			rect(width/2,height/2,r2,r2*ratio);
		}else{

			fill(255,45);

			rect(width/2,height/2,r2,r2*ratio);


			fill(0);


			rect(width/2,height/2,r1,r1*ratio);


		}



		popMatrix();




		if(rec)
			if(frameCount<=9750){
				saveFrame("/desk/breathe/br#####.png");
			}else{
				exit();
			}
	}
}
