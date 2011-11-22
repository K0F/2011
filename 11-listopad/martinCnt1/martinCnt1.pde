
int cntr = 0 ;

void setup(){
	size(720,576,P2D);
	println(PFont.list());
	textFont(createFont(PFont.list()[15],300,true));
	textMode(SCREEN);
	textAlign(CENTER);
}


void draw(){

	background(0);


	fill(255);


	float num = map(frameCount,0,200,100,0);
	text((int)num,width/2,height/2);



	if(num<0)
	exit();
	saveFrame("/desk/martinCntrs/100-0/####.png");

}
