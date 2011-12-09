int num = 5;
ArrayList bases;

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

	for(int i = 0 ; i < bases.size() ; i ++){
		Base current = (Base)bases.get(i);
		current.act();
		current.plot();
	}
}



class Base{
	PVector pos;
	PVector vel;
	
	PVector code[] = new PVector[100];

	int id;

	float speed = 10.0;

	float timeSpread = 3000.0;

	float time;
	float step;

	float [] w;

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

		pos = new PVector(random(height),random(height));
		vel = new PVector(0,0);
		w = new float[code.length];

		for(int i = 0 ; i < code.length;i++){
			w[i] = random(0,1)/100.;			
			code[i] = new PVector(0,-1, (noise(i*(id+1.0))*2-1.0) / speed );
		}
	}

	void bordr(){
		if(pos.x > width || pos.x < 0)
		for(int i = 0 ; i < code.length;i++)
		code[i].x *= -1.0;

		if(pos.y > height || pos.y < 0)
		for(int i = 0 ; i < code.length;i++)
		code[i].y *= -1.0;
	}

	void loopInside(){
		int i = (int)random(code.length);
		//for(int i = 0 ; i < code.length;i++){
		for(int q = 0 ; q < code.length;q++){
			PVector p = code[q];
			p.mult(w[i]);
			code[i].add(p);

		}
		code[i].normalize();
		//}
	}

	void act(){

		time += step;

 		for(int i = 0 ; i < code.length;i++){
		
		loopInside();
	
		rotate2D(code[i], code[i].z );
		vel.add(code[i]);
			
		}

		vel.normalize();
		pos.add(vel);

		bordr();

		for(int i = 0 ; i < bases.size() ; i++ ){
			Base b = (Base)bases.get(i);
			if(dist(pos.x,pos.y,b.pos.x,b.pos.y)<100){
				repulse(b);

			}

		}
		
		//int ran = (int)(noise(time*id+123)*bases.size());	
		//Base b = (Base)bases.get(ran);

		//for (int i =0 ; i < code.length;i++){ 	
		//int r = (int)(noise(id*time*id)*(code.length));
		//code[r].add(b.vel);
//		code[i].normalize();
		//}
		
	}

	void repulse(Base _b){
		for(int i =0 ; i < code.length;i++){
			
			PVector.sub(code[i],code[i].cross(_b.code[i]));
			code[i].normalize();
		}
	}

	void plot(){
		pushMatrix();
		translate(pos.x,pos.y);
		pushMatrix();	
		rectMode(CENTER);
		rotate(atan2(vel.y,vel.x)+HALF_PI);
		stroke(0,160);
		rect(0,0,5,10);
		popMatrix();

		int y = -20;
		int x = -5;
		for(int i =0 ;i<code.length;i++){
		stroke(atan2(code[i].y,code[i].x)*255);
		
		point(x,y);

		x++;

		if(i%10==0){
		y++;
		x = -5;
		}
		}
		
		popMatrix();
	}

 void rotate2D(PVector v, float theta) {
                 float xTemp = v.x;
                 v.x = v.x*cos(theta) - v.y*sin(theta);
                 v.y = xTemp*sin(theta) + v.y*cos(theta);
         }
}
