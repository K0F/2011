void setup(){
	size(640,640,P2D);
	
	stroke(255,30);
	noSmooth();
	noiseSeed(19);
	background(0);
}



void draw(){
	translate(width/2,height/2);

	background(0);


	for(int sh =1 ;sh<  2 ;sh++){

	int q = 0;
	for(int fr = 0 ; fr < 80 ; fr++){

	//noiseSeed(fr);	
	pushMatrix();
	float mxd = 1;
	for(int i = 0; i < 1000 ; i++){

		
	
		float len = 0.1;//sin((frameCount+q)/3000.0)+1;//noise(frameCount/300.0+q)*0.01;
	
		stroke( 255, (sin( i/10.0+frameCount/300.0) +1.0 ) * 44.0 + 1 ) ;
		//strokeWeight( (sin( i/100.0+frameCount/3000.0) +1.0 ) * 4.0 + 1);
		translate(len,(noise( (i+fr+frameCount/30000.0) / (noise((fr+i+frameCount)/(fr+1000.0+sh))*100.0) )-0.5)*15.0);
			
		//mxd = max(dist(screenX(0,0),screenY(0,0),width/2,height/2),mxd);
	
		point( 0,0);
		
		if(i%30==0){
			q++;
			rotate(HALF_PI);// (noise(frameCount/30000.0+fr)-0.5) *180));
	
			
			scale(noise( (fr+i*1000+frameCount) / 899.9 )*0.001 + 0.99);
	}


	}

		popMatrix();
	}
	}

}
