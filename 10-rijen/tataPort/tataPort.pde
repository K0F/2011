PImage img[] = new PImage[11];


void setup(){
	size(1280,720);
	
	for(int i = 0 ; i < img.length ; i++ ){
		img[i] = loadImage((nf(i+1,2))+".png");
	}	

	background(0);
	frameRate(25);
}

float tras = 5;
float spx = 3.3;
float spy = 3.4;

void draw(){

tint(255,150);	

image(
img[frameCount%11],
-tras/2.0+noise(frameCount/spx)*tras,
-tras/2.0+noise(frameCount/spy)*tras
);

filter(BLUR,noise(frameCount/300.0)*3);

saveFrame("/desk/tataRendr/frame#####.png");

}
