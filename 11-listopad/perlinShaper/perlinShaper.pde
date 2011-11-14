void setup(){
	size(1280,720,P2D);
	noSmooth();
	noiseSeed(19);
}
void draw(){
	background(0);
	translate(width/2,height/2);
	for(int sh =1 ;sh<  2 ;sh++){
		int q = 0;
		for(int fr = 0 ; fr < 80 ; fr++){
			pushMatrix();
			float mxd = 1;
			for(int i = 0; i < 1000 ; i++){
				float len = 0.1;
				stroke( 255, (sin( i/10.0+frameCount/300.0) +1.0 ) * 44.0 + 1 ) ;
				translate(len,(noise( (i+fr+frameCount/30000.0) / (noise((fr+i+frameCount)/(fr+1000.0+sh))*100.0) )-0.5)*15.0);
				point(0,0);

				if(i%25==0){
					q++;
					rotate(HALF_PI);
					scale(noise( (fr+i*1000+frameCount) / 899.9 )*0.001 + 0.99);
				}

			}
			popMatrix();
		}
	}
}
