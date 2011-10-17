
float peak_every_millisecond = 5000;

PGraphics small_frame;

boolean render = true;

float r;

void setup(){
	size(320,240,P2D);
	frameRate(60);
	
	r = height / 2 + height / 4;

	small_frame = createGraphics(1,1,JAVA2D);

	fill(0);
	noStroke();
	smooth();
}



void draw(){
	
	float brightness = ( sin ( millis() / peak_every_millisecond ) + 1 ) * 128 - 1;	

	color c = color(noise(frameCount/500.0)*255,noise(frameCount/523.0)*255,noise(frameCount/231.0)*255);

	background(c);

	if(render){
		small_frame.beginDraw();
		small_frame.background(brightness);
		small_frame.endDraw();
		
		small_frame.save("/desk/mini_bck/mini"+nf(frameCount,4)+".png");

	}

	ellipse ( width / 2.0 , height / 2.0 , r , r ) ;
}
