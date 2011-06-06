
import traer.physics.*;


Hero hero,soldier;
World world;

float gravity = 0.5;
float density = 0.03;

void setup(){
	size(320,240,P2D);

	hint(DISABLE_OPENGL_2X_SMOOTH) ;

	hero = new Hero((int)(width/3)*2,130,"figurka3.png");	
	
	noSmooth();

	frameRate(30);


	world = new World();

	//rectMode(CENTER);
	noFill();
	stroke(255,100);
}


void gradient(color a,color b,int steps){
	noStroke();
	for(int i =0;i<steps;i++){
		fill(lerpColor(a,b,map(i,0,steps-1,0,1)));
		rect(0,map(i,0,steps,0,height),width,height/(steps+1.0));
	
	}

}

void draw(){


	background(40);
	//gradient(color(#5d5d6d),color(50),24);
	
	float akcel = degrees(atan2(hero.senzor.position().y()-hero.hlavaP.position().y(),hero.senzor.position().x()-hero.hlavaP.position().x())-HALF_PI);
	float naklon = degrees(atan2(hero.truP[5].position().y()-hero.hlavaP.position().y(),hero.truP[5].position().x()-hero.hlavaP.position().x())-HALF_PI);



	float acc = (naklon);//(naklon+akcel)/2.0;
	float ang = 90;
	acc = constrain(acc,-ang,ang);

	//println(acc);
	//if(frameCount%10==0)
	//	println(acc);
	
	
	//hero.trupQ[0] = map(sin(frameCount/20.0),-1,1,hero.initialQ[18]-2,hero.initialQ[18]+2);
	//hero.trupQ[1] = map(sin(frameCount/20.0),-1,1,hero.initialQ[19]+2,hero.initialQ[19]-2);
/*

	float val = map(mouseX,0,width,0,1);
	float val2 = map(mouseY,0,width,1,2);
	hero.nohaLQ[0] = hero.initialQ[10]*(1.0-val*val2);//map(acc,ang,-ang,+2,hero.initialQ[10]-4.5);
	hero.nohaLQ[1] = hero.initialQ[11]*(1.0+val*val2);//map(acc,ang,-ang,hero.initialQ[11]-2,hero.initialQ[11]+4.5);
	hero.nohaLQ[2] = hero.initialQ[12]*(1.0-val);//map(acc,-ang,ang,hero.initialQ[12]-3,hero.initialQ[12]+3);
	hero.nohaLQ[3] = hero.initialQ[13]*(1.0-val);//map(acc,ang,-ang,hero.initialQ[13]-3,hero.initialQ[13]+3);

	hero.nohaRQ[0] = hero.initialQ[14]*1.5;//map(acc,-ang,ang,+2,hero.initialQ[14]-4.5);
	hero.nohaRQ[1] = hero.initialQ[15]*0.5;//map(acc,-ang,ang,hero.initialQ[15]-2,hero.initialQ[15]+4.5);
	hero.nohaRQ[2] = hero.initialQ[16]-(sin(frameCount/30.0))*6.0;//map(acc,ang,-ang,hero.initialQ[16]-3,hero.initialQ[16]+3);
	hero.nohaRQ[3] = hero.initialQ[17]+(sin(frameCount/30.0))*6.0;//map(acc,-ang,ang,hero.initialQ[17]-3,hero.initialQ[17]+3);


		
	
	
	hero.nohaLQ[0] = map(acc,ang,-ang,hero.initialQ[10]+2,hero.initialQ[10]-4.5);
	hero.nohaLQ[1] = map(acc,ang,-ang,hero.initialQ[11]-2,hero.initialQ[11]+4.5);
	hero.nohaLQ[2] = map(acc,-ang,ang,hero.initialQ[12]-3,hero.initialQ[12]+3);
	hero.nohaLQ[3] = map(acc,ang,-ang,hero.initialQ[13]-3,hero.initialQ[13]+3);

	hero.nohaRQ[0] = map(acc,-ang,ang,hero.initialQ[14]+2,hero.initialQ[14]-4.5);
	hero.nohaRQ[1] = map(acc,-ang,ang,hero.initialQ[15]-2,hero.initialQ[15]+4.5);
	hero.nohaRQ[2] = map(acc,ang,-ang,hero.initialQ[16]-3,hero.initialQ[16]+3);
	hero.nohaRQ[3] = map(acc,-ang,ang,hero.initialQ[17]-3,hero.initialQ[17]+3);


	hero.rukaRQ[0] = map(acc,ang,-ang,hero.initialQ[6],hero.initialQ[6]+5);
	hero.rukaRQ[1] = map(acc,ang,-ang,hero.initialQ[7],hero.initialQ[7]-5);
	hero.rukaRQ[2] = map(acc,ang,-ang,hero.initialQ[8],hero.initialQ[8]+2);
	hero.rukaRQ[3] = map(acc,ang,-ang,hero.initialQ[9],hero.initialQ[9]-2);

	hero.trupQ[0] = map(acc,ang,-ang,hero.initialQ[18]-2,hero.initialQ[18]+2);
	hero.trupQ[1] = map(acc,ang,-ang,hero.initialQ[19]+2,hero.initialQ[19]-2);


	hero.nohaLQ[0] = map(sin(frameCount/10.0),1,-1,hero.initialQ[10],hero.initialQ[10]-4.5);
	hero.nohaLQ[1] = map(sin(frameCount/10.0),1,-1,hero.initialQ[11],hero.initialQ[11]+4.5);
	hero.nohaLQ[2] = map(sin(frameCount/10.0),-1,1,hero.initialQ[12]-3,hero.initialQ[12]+3);
	hero.nohaLQ[3] = map(sin(frameCount/10.0),1,-1,hero.initialQ[13]-3,hero.initialQ[13]+3);

	hero.nohaRQ[0] = map(sin(frameCount/10.0),1,-1,hero.initialQ[14],hero.initialQ[14]-4.5);
	hero.nohaRQ[1] = map(sin(frameCount/10.0),1,-1,hero.initialQ[15],hero.initialQ[15]+4.5);
	hero.nohaRQ[2] = map(sin(frameCount/10.0),-1,1,hero.initialQ[16]-3,hero.initialQ[16]+1);
	hero.nohaRQ[3] = map(sin(frameCount/10.0),1,-1,hero.initialQ[17]-3,hero.initialQ[17]+1);
	*/


	//hero.rukaRQ[2] = map(sin(frameCount/5.0),-1,1,hero.initialQ[8]-4,hero.initialQ[8]+4);
	//hero.rukaRQ[3] = map(sin(frameCount/5.0),1,-1,hero.initialQ[9]-4,hero.initialQ[9]+4);


	pushMatrix();

	//scale(2.0);
		//translate(-hero.hlavaP.position().x()/2-20,-hero.hlavaP.position().y()/2-30);
	hero.act();
	//soldier.act();
	//line(rukaL2P.position().x(),rukaL2P.position().y(),anchor.position().x(),anchor.position().y());
	world.render();

	popMatrix();
}


void keyPressed(){
	if(key=='w'){
		hero.control = 0;
	}else if(key == 't'){
		hero.testing = !hero.testing;

	}

}


void mousePressed(){

	println(mouseX+" : "+mouseY);

}






