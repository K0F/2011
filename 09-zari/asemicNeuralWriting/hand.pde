class Hand {
	ArrayList bones;
	ArrayList trail = new ArrayList<PVector>(0);
	float x,y;
	int id;


	Hand(int _id,int num,float _x,float _y) {
		id = _id;
		bones = new ArrayList();
		for(int i = 0;i<num;i++) {
			//Bone prev = i==0?null:(Bone)bones.get(i-1);
			bones.add( new Bone ( this, i, chapadloPartLen,map(i,0,num,10,2) ));
		}

		x = _x;
		y = _y;
	}

	void setXY(float _x,float _y) {
		x = _x;
		y = _y;
	}

	void drawTrail(){

		if(trail.size()>0){

			for(int i = 1 ; i< trail.size();i++){
				stroke(255,map(i,0,trail.size(),15,150));
				int modx = 0;

				//if(trail.size()<trailLength)
				modx = trailLen-trail.size();
				//strokeWeight(map(i,0,trail.size(),1,3));
				PVector one = (PVector)trail.get(i-1);
				PVector two = (PVector)trail.get(i);
				line(one.x+i-trailLen+modx,one.y,two.x+i-trailLen+modx,two.y);

			}
		}


		noStroke();

	}

	void draw() {
		pushMatrix();
		translate(x,y);
		//rotate(radians(-90));
		for(int i =0;i<bones.size();i++) {
			Bone tmp = (Bone)bones.get(i);
			if(id == 0)
				fill(#ff1111,map(i,0,chapadlaLen-1,0,255));

			else
				fill(map(i,0,bones.size(),0,120));
			tmp.draw();

		}

		popMatrix();
		x = blobX;
		y = blobY;

		/*
		   stroke(#ffcc00,10);
		   for(int i =0;i<bones.size();i++) {
		   Bone tmp = (Bone)bones.get(i);

		   for(int q = 0;q<8;q++)
		   line(x,y,tmp.controllers[q].x,tmp.controllers[q].y+10*i);


		   } 
		   noStroke();*/
	}


	PVector simulate(){
		PVector result;

		pushMatrix();
		translate(x,y);

		for(int i = 0; i < bones.size();i++){
			Bone tmpB = (Bone)bones.get(i);
			tmpB.simulate();
		}

		result = this.getVector();

		popMatrix();

		return result;
	}

	PVector getVector(){
		Bone tmp = (Bone)bones.get(bones.size()-1);
		return tmp.getVector();

	}

	void teach(){
		for(int i =0  ;i<bones.size();i++){
			Bone tmp = (Bone)bones.get(i);
			tmp.teach();
		}

	}
}

class Bone {
	Hand parent;
	float len,thickness,angle;
	int id;
	Neuron[] controllers;
	float[] backup;

	float dist1,dist2;

	Bone(Hand _parent,int _id,float _len,float _t) {
		parent = _parent;
		id = _id;
		controllers = new Neuron[8];
		backup = new float[8];

		for(int i = 0;i<controllers.length;i++) {
			controllers[i] = (Neuron)n.get((int)random(n.size()));
		}


		len = _len;
		thickness = _t;
		angle = 0;
	}

	void simulate(){
		float angle2 = angle;
		angle2 = (parseNeurons()*noise(frameCount/400.0)*40.0-angle2)/smoothing2;
		rotate(radians(angle2));

		translate(len,0);

	}

	PVector getVector(){
		return new PVector(screenX(0,0),screenY(0,0));
	}

	void draw() {
		
		// simple defence
		if(dist(mouseX,mouseY,screenX(0,0),screenY(0,0))<150){

			angle += random(-4,4)/10.0;
			if(angle<5){
				angle += 0.4;
				
			}

		}else{
			angle += (parseNeurons()*noise(frameCount/400.0)*40.0-angle)/smoothing2;
		}	

		rotate(radians(angle));

		pushStyle();

		fill(0,40);


		rect(0,-thickness-3,len+4,thickness*2+6);
		fill(0);
		rect(0,-thickness,len+4,thickness*2);
		popStyle();

		rect(-2,-thickness/2.0,len+2,thickness);
		translate(len,0);

		if(id == chapadlaLen - 1 && parent.trail.size() >= trailLen){
			parent.trail.remove(0);

		}


		if(id == chapadlaLen - 1 && parent.trail.size() < trailLen){
			parent.trail.add(new PVector(screenX(0,0),screenY(0,0)));
		}
		//    move();
	}

	void move() {
		if(id == len-2) {
			float posx = screenX(0,0);
			float posy = screenY(0,0);

			// if(posx > width || posx < 0)
			blobX -= (posx-blobX)/1000.5;//(dist(posx,posy,blobX,blobY));

			// if(posy > height || posy < 0)
			blobY -= (posy-blobY)/1000.5;//(dist(posx,posy,blobX,blobY));

			// parent.x = blobX;
			// parent.y = blobY;
		}
	}

	float parseNeurons() {
		String s = "";
		for(int i = 0;i<8;i++) {
			s += controllers[i].val>avg?"1":"0";
		}

		float val = (unbinary(s)-127)/smoothing1;
		return val;
	}

	void writeNeurons(){
		if(id==0){
			angle = degrees(atan2(mouseY-width/2,mouseX-height/2));
			String binar = binary((int)angle,8);
			for(int i =0;i<controllers.length;i++){    
				controllers[i].val = binar.charAt(i)=='1'? 2 : 0; 
			}
		}else{
			String binar = binary(127,8);
			for(int i =0;i<controllers.length;i++){    
				controllers[i].val = binar.charAt(i)=='1'? 2 : 0; 
			}
		}
	}

	// exporimental !!
	void teach(){




		for(int q = 0;q<teachRate;q++){

			PVector curpos = parent.simulate();			
			dist2 = dist(curpos.x,curpos.y,mouseX,mouseY);

			//for(int i = 0;i<backup.length;i++){

			int choose = (int)random(controllers.length);

			backup[choose] = controllers[choose].val;
			controllers[choose].val = random(200)/100.0;
			//controllers[choose].update();


			//if(screenX(0,0))

			//	}

			curpos = parent.simulate();
			dist1 = dist(curpos.x,curpos.y,mouseX,mouseY);

			if(dist1>=dist2){
				for(int i = 0;i<backup.length;i++){
					controllers[i].val = backup[i];
				}

			}


		}


	}
}

