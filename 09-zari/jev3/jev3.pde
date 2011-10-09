
float r;

void setup(){

	size(1280,720);

	r = (height/2+height/4);

	noiseSeed(19);

	fill(0);
	noStroke();

	smooth();


	textFont(createFont("Calluna",19));
	textMode(SCREEN);
	textAlign(CENTER);

}


void draw(){



	if(frameCount<=3750){
		
	background(250+(noise(frameCount/300.0)*15.0));
	ellipse(width/2,height/2,r,r);
	
	}else if (frameCount>3750 && frameCount <= 7500){
	background(0);
	fill(255);
	ellipse(width/2,height/2,r,r);

	}

	if(frameCount>8400 && frameCount<=8425){
		text("Jev\nkof 11",width/2,height/2);
	}

	if(frameCount>=8500){
		exit();
	}else{
		saveFrame("/desk/Jev/frame#####.png");
	}

}
