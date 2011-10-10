
float break_likeness = 40;
float break_speed = 20.0;

float x_or_y_rate = 0.1;

void setup(){
	size(320,240);
	background(255);

	noiseSeed(19);
}



void draw(){


	color c = color(
			255 * noise(frameCount/30.0),
			255 * noise(frameCount/31.2),
			255 * noise(frameCount/32.3)
		       );

	stroke(c);


	float probability = noise(frameCount / break_speed ) * break_likeness;

SMYCKA_Y:
	for( int y = 0 ; y < height ; y ++ ){
SMYCKA_X:
		for( int x = 0 ; x < width ; x ++){
			point(x,y);



			if( noise( (x*y+x+frameCount) / 2.0 ) * probability < 1.0 ){
				if( noise( (x*y+x+frameCount) / x_or_y_rate) >= 0.5 ){
					break SMYCKA_Y;
				}else{
					break SMYCKA_Y;
				}
			}

		}

	}


}
