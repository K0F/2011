
float peak_every_millisecond = 5000;


float r;

void setup(){
	size(1600,900,P2D);
	frameRate(60);
	
	r = height / 2 + height / 4;


	fill(0);
	noStroke();
	smooth();
}



void draw(){
	
	float brightness = ( sin ( millis() / peak_every_millisecond ) + 1 ) * 128 - 1;	

	background(brightness);

	ellipse ( width / 2.0 , height / 2.0 , r , r ) ;
}
