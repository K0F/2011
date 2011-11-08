/**
*  Weird midnight sketch by kof 2011
*  asemicConstruction, copyleft
*/

float[] ang,L,speed;
int num = 10;


float speedUP;

void setup(){

	size(1600,900,P2D);



	noiseSeed(19);

	ang = new float[num];
	L = new float[num];
	speed = new float[num];

	for(int i = 0 ; i < ang.length;i++){
		ang[i] = 0;
		L[i] = (200.0)/(i*4.0+1.0);
		speed[i] = 0.1-i/(200.0+i);

	}

	noSmooth();


	background(0);
	stroke(255,10);
	
	speedUP = HALF_PI * 3333.3;
}


void draw(){

	
	pushStyle();
        strokeWeight(10);
        stroke(0);
	fill(0,45);
	rect(0,0,width,height);
        popStyle();

	pushMatrix();
	translate(noise(frameCount/3.0)*5,noise(frameCount/3.21)*5);


	if(frameRate < 30)
	//speedUP --;

	for(int q = 0;q< speedUP ;q++){

	pushMatrix();
	translate(width/2,height/2);
	for(int i = 0 ; i < ang.length;i++){


	translate(0,noise(i*10.0+frameCount/330.0)*i*300.0);

	float l = L[i]+((noise(((frameCount+i*2000.0)/120.0 )-0.51)*(150.0+i/40.0)));

	stroke(lerpColor(#222B38,#FFF5CD,norm(i,ang.length,0)), (sin((i*10000.0+frameCount*30000.111)*3.0)+1.0)*12.0 );

	ang[i]+=speed[i];	
	rotate(ang[i]);
	line(0,0,l,0);
	translate(l,0);	



	}

	popMatrix();

}

	popMatrix();

	saveFrame("/desk/god/god#####.png");

}


