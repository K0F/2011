float[] ang,L,speed;
int num = 10;

void setup(){

	size(1280,720,P2D);



	noiseSeed(19);

	ang = new float[num];
	L = new float[num];
	speed = new float[num];

	for(int i = 0 ; i < ang.length;i++){
		ang[i] = 0;
		L[i] = (200.0)/(i+1.0);
		speed[i] = 0.1-i/200.0;

	}

	noSmooth();


	background(0);
	stroke(255,10);
	
}


void draw(){

	
	
	fill(0,45);
	rect(0,0,width,height);

	pushMatrix();
	translate(noise(frameCount/3.0)*5,noise(frameCount/3.21)*5);

	for(int q = 0;q<PI*1000/2.0;q++){

	pushMatrix();
	translate(width/2,height/2);
	for(int i = 0 ; i < ang.length;i++){

	float l = L[i]+((noise(((frameCount+i*20.0)/120.0 )-0.51)*(250.0+i/40.0)));

	stroke(lerpColor(#4B6F30,#F0D207,norm(i,ang.length,0)), (sin((i+frameCount)/3000.0)+1.0)*12.0 );

	ang[i]+=speed[i];	
	rotate(ang[i]);
	line(0,0,l,0);
	translate(l,0);	



	}

	popMatrix();

}

	popMatrix();

}


