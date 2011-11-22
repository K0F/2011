
int cntr = 0 ;

String mesic[] = {"leden","únor","březen","duben","květen","červen","červenec","srpen","září","říjen","listopad","prosinec"};

void setup(){
	size(720,576,P2D);
	println(PFont.list());
	textFont(createFont(PFont.list()[15],150,true));
	textMode(SCREEN);
	textAlign(CENTER);
}


void draw(){

	background(0);


	fill(255);


	float num = map(frameCount,0,200,0,11);
	text(mesic[(int)num],width/2,height/2);



	if(num>11)
	exit();

	saveFrame("/desk/martinCntrs/leden-prosinec/####.png");

}
