void setup(){
	size(640,640,P2D);
	createFont("Liberation",9);
	noiseSeed(second());
	smooth();
}

float ms = 0;

void draw(){

	background(0);



	float mms = millis();
	if(ms>60000){
	ms = mms-60000;
	}else{

	ms = millis();
	}

	float sec = map(second(),0,60,-90,360-90);
	float secfrac = map(ms,0,1000*60,-90,360-90);
	//secfrac *= PI/60.0;


	translate(width/2, height/2);
	rotate(radians(secfrac));

	stroke(255,120);
	line(0,0,150,0);


	float f1 = 75;
	float f2 = 150;

	stroke(255,60);

	translate(sin(ms/15000.0)*75.0,0);

	for(int i =1 ; i< 61;i++){

		f1 = map(secfrac,-90,360-90,0,150);
		f2 = map(secfrac,0,60,0,150/(i+0.0));
		rotate(radians(secfrac+90) );
		line(f1,0,0,0);
		translate(f1,0);

		//f2 /= 2.0;
	}

}
