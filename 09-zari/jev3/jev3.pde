
float r;

void setup(){

	size(1280,720);

	r = (height/2+height/4);

	noiseSeed(19);

	fill(0);
	noStroke();

	smooth();


	textFont(createFont("Liberation Sans Bold Italic",19));
	textMode(SCREEN);
	textAlign(CENTER);

	println(PFont.list());

	frameCount = 0;
}


void draw(){


	if(frameCount<=100){
		background(255);
	}else if(frameCount>100 && frameCount<=125){
		background(255);
		fill(0);
		text("Jev / Phenomenon",width/2,height/2);


	}else if(frameCount>125 && frameCount <= 200){

	background(255);

	}else if(frameCount<=3750){
		
	background(250+(noise(frameCount/300.0)*15.0));
	ellipse(width/2,height/2,r,r);
	
	}else if (frameCount>3750 && frameCount <= 7500){
	background(0);
	fill(255);
	ellipse(width/2,height/2,r,r);

	}
	else{
	background(0);
	}

	if(frameCount>8400 && frameCount<=8425){
		fill(255);
		text("kof 11",width/2,height/2);
	}

	if(frameCount>=8500){
		exit();
	}else{
		saveFrame("/desk/Jev/frame#####.png");
	}

}
