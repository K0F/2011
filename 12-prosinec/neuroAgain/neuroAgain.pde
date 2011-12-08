
Neuron n[];

void setup(){
	size(128,128,P2D);
	
	n = new Neuron[width*height];

	for(int i =0 ; i < n.length;i++){
		n[i] = new Neuron(i,i%width,(int)(i/width+1.));
	}

}


float globsum = 1;

void draw(){

	loadPixels();

	for(int i =0 ; i < n.length;i++){
		n[i].cycle();
	}

	
	for(int i =0 ; i < n.length;i++){

		n[i].draw();
	}

	updatePixels();

	//filter(BLUR,2+sin(frameCount/10.0)*2.0);

//	println(frameCount);
}

void mouseDragged(){
	fill(0);
	ellipse(mouseX,mouseY,10,10);

}

class Neuron{
	int x,y;
	float sum;
	float tresh;
	float [] w;
	int id;

	Neuron(int _id,int _x,int _y){
		id = _id;
		sum = random(200)/100.0-50.0;
		tresh = 1;
		x = _x;
		y = _y;
		w = new float[width*height];

		for(int i = 0 ; i < w.length;i++){
			w[i] = random(-2,2);
		}
		
	}

	void cycle(){
		
		activation:
		for(int i = 0 ; i < 200 ; i+=1){
			
			int sel = (int)(i^i+frameCount)%w.length;
			sum += ((w[sel]*n[sel].sum)-sum)/10.0;
			w[sel]-=0.0001;		
	
			if(sum>0.0){w[sel]+=0.0001;break activation;}
			
		}
	}

	void draw(){
		sum += ((brightness(pixels[(id+width)%pixels.length])/127.)-sum)/20.0;
		pixels[id] = color((sum+1)*127);
	}


}
