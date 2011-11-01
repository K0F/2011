void setup(){

	size(1280,720,P2D);
	fill(255,5);
	frameRate(25);
	noSmooth();
	noStroke();
	//stroke(0,10);
}


int zen = 3;
int realf = 0;
boolean negative;

void draw(){
	background(negative?255:0);

	translate(noise(frameCount/3.01277)*10.0,(noise(frameCount/3.0)*10.0));
		

	realf++;
	frameCount %= zen;

	if(realf%3==0){
		zen+=1;
		negative = !negative;
	}

	float x,y,r;
	for(int X = 0;X <= width; X+=width/2){
		for(int Y = 0 ; Y <= height;Y+=height/2){
			for(int i = 0 ; i < 4000;i++){
				x = width/2 + width*(1.0+cos((frameCount/10.0*pow(i+frameCount,2.17))/3000000.0))+X;	
				y = height*(1.0+sin((frameCount*pow(i+1.0,2.4)/10.0)/300.0))+Y;	
				x %= (width);
				y %= (height);
				fill(negative?0:255,(sin(i/PI/10.0)+1.0)*7);
				r = 25*sin(pow(i/30.0,1.1))+3;	
				ellipse(x,y,r,r);
			}	
		}

	}

	save("/desk/visOhm2/frame"+nf(realf,5)+".png");

}
