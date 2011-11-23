/**
 *
 * Óda Na datovou Konzistenci, Kof 2011, Video, Copyleft
 * 
 */

///////////////////////////////
float num = 1000;
float r = 1280;
float density = 10;
float size_of_dot = 22.0;


///////////////////////////////
float step = 0;

color c[] = {#FFFFaa,#FFFFFF,#FFFFFF}; 
color cn[] = {#000055,#000000,#000000};
int barvaCnt = 0;


///////////////////////////////
void setup(){
	size(700,400,P2D);
	smooth();
	frameRate(30);
	noStroke();
	fill(255);
	//frameCount = 6710;
}


boolean blink = false;
boolean blank = false;
boolean black = false;

void keyPressed(){
	if(key==' '){
		blink = true;

	}else if(keyCode==ENTER){
		black = true;
	}else if(key=='n'){
		blank=true;
	}

}

///////////////////////////////
void draw(){

	if(negative){
		background(0);
	}else{
		background(255);
	}

	density += 0.000231147713;


	float r2 = (sin(frameCount/5000.01)+1.0)*1.10;	
	r = (sin(frameCount/(r2))+3.0)*width/2;
	step = frameCount/300.332;
	num = (sin(frameCount/300.1235)+1.982393)*2000;


	// L1

	for(int X = 0; X <= width;X += width){

		for(int Y = 0; Y <= height;Y += height){

			for(int i = (int)num ; i > 0 ; i-- ){


				float _r = map(i,0,num,0,r);
				float _x = (cos((i+step)/density)*_r+X);
				float _y = (sin((i+step)/density)*_r+Y);

				float _size_of_dot = map(i,0,num,1,size_of_dot);

				_x+=cos((frameCount+X+i)/(2000.12346))*50;
				//_y+=sin((frameCount+Y+i)/(2000.0))*5;

				_x += (width/2.0-_x)/(sin(frameCount/500.0)+6.0);
				//_y += (height/2.0-_y)/(sin(frameCount/30.0)+6.0);

				if(
						_x<=width-_size_of_dot && 
						_x>=_size_of_dot && 
						_y>=_size_of_dot &&
						_y<=height-_size_of_dot// && 
				  ){




					if(X==0){
						if(blink){fill(255);
						}else if(black){
							fill(0);
						}else{


							fill(!negative?cn[(X+Y+i)%c.length]:c[(X+Y+i)%c.length],map(millis(),0,600000,0,255));
						}
					}else{

						if(blink){fill(255);
						}else if(black){
							fill(0);


						}else{
							fill(!negative?cn[(X^Y*i)%c.length]:c[(X^Y*i)%c.length],map(millis(),0,600000,0,255));
						}
					}	

					ellipse(_x,_y,_size_of_dot,_size_of_dot);

				}
			}
		}
	}

	blink = blank = black = false;

	// this is for the patient ones ;)
	if(millis()>(600000)){

		try{
			Runtime.getRuntime().exec("pkill scsynth");
			exit();
		}
		catch(java.io.IOException e){
			println(e); 
		}  
	}
	//saveFrame("/desk/visOhm/vohm#####.png");

}

boolean negative = true;
