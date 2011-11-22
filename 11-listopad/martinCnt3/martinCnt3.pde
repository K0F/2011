
int cntr = 0 ;

String mesic[] = {"leden","únor","březen","duben","květen","červen","červenec","srpen","září","říjen","listopad","prosinec"};

void setup(){
	size(720,576,P2D);
	println(PFont.list());
	textFont(createFont(PFont.list()[15],200,true));
	textMode(SCREEN);
	textAlign(CENTER);
}


void draw(){

	background(0);


	fill(255);


	float num = map(frameCount,0,200,2100,1950);
	text((int)num,width/2,height/2);



	if(num<1950)
	exit();

	saveFrame("/desk/martinCntrs/2100-1950/####.png");

}
