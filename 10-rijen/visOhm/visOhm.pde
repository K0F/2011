float num = 1000;
float r = 1280;
float density = 10;
float size_of_dot = 20.0;

float step = 0;

color c[] = {#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFbb}; 
int barvaCnt = 0;


void setup(){
	size(800,400,P2D);
	smooth();
	frameRate(30);
	noStroke();
	fill(255);
	frameCount = 2871;
}


void draw(){

	background(0);

	density += 0.00231147713;


	float r2 = (sin(frameCount/50.01)+1.0)*1.10;	
	r = (sin(frameCount/(r2))+3.0)*width/2;
	step = frameCount/30000.332;
	num = (sin(frameCount/30000.1235)+1.982393)*4000;

	
	// L1

	for(int X = 0; X <= width;X += width){

		for(int Y = 0; Y <= height;Y += height){

			for(int i = (int)num ; i > 0 ; i-- ){


				float _r = map(i,0,num,0,r);
				float _x = (cos((i+step)/density)*_r+X);
				float _y = (sin((i+step)/density)*_r+Y);
				
				float _size_of_dot = map(i,0,num,1,size_of_dot);
	
				_x+=cos((frameCount+X+i)/(200.12346))*50;
					//_y+=sin((frameCount+Y+i)/(200.0))*5;

				_x += (width/2.0-_x)/(sin(frameCount/50.0)+4.0);
				//_y += (height/2.0-_y)/(sin(frameCount/30.0)+1.0);

				if(
						_x<=width-_size_of_dot && 
						_x>=_size_of_dot && 
						_y>=_size_of_dot &&
						_y<=height-_size_of_dot// && 
						//((i+frameCount)%((int)(sin(frameCount/100.0)+1.0)*3.0+2.0)==0)
				  ){
					//float _al = (sin(frameCount%((i+1)/30.0))+1.0)*200;
					//fill(255,_al);

if(dist(_x,_y,width/2,height/2)<sin(frameCount/300.0)*height/2-_size_of_dot){

					fill(#00FF00);//lerpColor( #FFFFFF, c[(barvaCnt++)%c.length] , (sin((frameCount+1500)/3.0)+1.0)/2.0 )  );
			
					ellipse(_x,_y,_size_of_dot,_size_of_dot);
	}else{
					fill(c[(X^Y*i)%c.length]);
					//fill(lerpColor( #000000, c[(X+Y+i)%c.length] , (sin((frameCount+1500)/3.0)+1.0)/2.0 )  );
				}


				}
			}
		}
	}
	saveFrame("/desk/visOhm/vohm#####.png");

}
