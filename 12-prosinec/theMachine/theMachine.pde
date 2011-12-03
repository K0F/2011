
int num = 800;

ArrayList bases;

int frameLen = 1200;

void setup(){

	size(1280,720,P2D);

	bases = new ArrayList();

	for(int i =0 ; i< num ; i ++)
	bases.add(new Base(i));

	noiseSeed(19);
	
	stroke(0,120);

	background(255);
}

void draw(){
	background(250);

	for(int T = 0 ; T < frameLen ; T ++)
	for(int i = 0 ; i < bases.size() ; i ++){
		Base current = (Base)bases.get(i);
		current.act();
		current.plot();
	}
	
	for(int i = 0 ; i < bases.size() ; i ++){
		Base current = (Base)bases.get(i);
		current.animStep();
	}

	//frameLen++;

	saveFrame("/desk/rostlinka/rostlina#####.png");
}


class Base{
	PVector pos;
	PVector vel;
	
	PVector code[] = new PVector[33];

	int id;

	float speed = 10.0;


	float timeSpread = 3.0;

	float time;
	float step;

	Base(int _id){
		id = _id;

		reset();
		animStep();	

		

	}

	void animStep(){
		reset();
		speed += 1;
		timeSpread += 0.00001;

	}


	void reset(){
		
		time = 0.1;
		step = noise(id)/1000.0*timeSpread;

		pos = new PVector(width/3*2,height);
		vel = new PVector(0,0);

		for(int i = 0 ; i < code.length;i++){
		
			
			code[i] = new PVector(0,-1, (noise(i*id)*2-1.0) / speed );

			
		}

	}

	void act(){

		time += step;

 		for(int i = 0 ; i < code.length;i++){
			vel.add(code[i]);
			rotate2D(code[i], code[i].z );
		}
		vel.normalize();

		pos.add(vel);


		
		int ran = (int)(noise(time*id+123)*bases.size());	
		Base b = (Base)bases.get(ran);

		//for (int i =0 ; i < code.length;i++){ 	
		int r = (int)(noise(id*time*id)*(code.length));
		code[r].add(b.vel);
//		code[i].normalize();
		//}
		
	}

	void plot(){
		pushMatrix();

		translate(pos.x,pos.y);
		
		
		rotate(atan2(vel.y,vel.x)+HALF_PI);
		stroke(0,3);
		line(0,0,0,-1);
		popMatrix();
		
	}

	

 void rotate2D(PVector v, float theta) {
                 float xTemp = v.x;
                 v.x = v.x*cos(theta) - v.y*sin(theta);
                 v.y = xTemp*sin(theta) + v.y*cos(theta);
         }

}
