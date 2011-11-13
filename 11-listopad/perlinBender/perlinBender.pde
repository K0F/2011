
Bender bender;




void setup(){
	size(320,160,P2D);
	bender = new Bender();
	noSmooth();
	background(0);

}

void draw(){
	bender.draw();	

}

class Bender{

	PGraphics predloha;
	PGraphics post;


	Bender(){
		udelejPredlohu(200);
		predloha.loadPixels();
		post = createGraphics(predloha.width,predloha.height,P2D);
		post.loadPixels();
	}

	void draw(){
		image(predloha,0,0);

		
		for(int i  = 0 ; i < post.pixels.length ; i ++){
			float br = brightness(predloha.pixels[i]);
			post.pixels[(int)(noise( (i+frameCount) / PI)*post.pixels.length+post.pixels.length) % post.pixels.length ] = color(noise(color(br))*255);
			
//			if(frameCount%300==0){
//				predloha.pixels[i] = post.pixels[i];
//			}

		}

		if(frameCount%300==0){
			
			noiseSeed(frameCount);
			udelejPredlohu(200);
			
		}

		image(post,width/2,0);


	}


	void udelejPredlohu(int _num){
		predloha = createGraphics(160,160,P2D);
		predloha.beginDraw();
		predloha.background(255);
		predloha.fill(0,127);
		predloha.noStroke();
		for(int i = 0  ; i < _num ; i++){
			predloha.rect(predloha.height*noise(i*3673.3),predloha.width*noise(4004.4),noise(i*300.0)*40,noise(i*332.3)*40324);
			predloha.filter(BLUR,noise(i)+1.0);
		}
		predloha.endDraw();

	}


}



