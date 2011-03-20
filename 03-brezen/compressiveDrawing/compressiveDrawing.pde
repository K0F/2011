
int size = 3;
boolean recording = false;

ArrayList gesture = new ArrayList();

Pattern p;
Follower f[] = new Follower[330];

PGraphics img;

float totW = 0;

int counter = 0;

void setup(){
	size(720,400,P2D);
	p = new Pattern();
	noSmooth();

	img = createGraphics(width,height,P2D);
	erase();
}

void erase(){
img.beginDraw();
img.background(0);
img.endDraw();
}

void keyPressed(){
    if(key==' '){
        img.save("/desk/patterns/pat"+nf(frameCount,4)+".png");
    }

}

void draw(){

	background(img);



	if(recording)
		gesture.add(new Pnt(mouseX,mouseY));


	if(gesture.size()>1)
		for(int i = 1;i<gesture.size();i++){
			Pnt tmp1 = (Pnt)gesture.get(i);
			Pnt tmp2 = (Pnt)gesture.get(i-1);
			stroke(255,70);
			line(tmp1.X,tmp1.Y,tmp2.X,tmp2.Y);

		}


	p.draw();

img.beginDraw();

	for(int i = 0 ;i<f.length;i++){
			if(f[i]!=null)
		f[i].draw();
	
	}
img.endDraw();

}

void mousePressed(){
if(mouseButton==LEFT){
	gesture = new ArrayList();
	recording = true;
}else{
erase();
}

}

void mouseReleased(){
if(mouseButton==LEFT){
	recording = false;

	p.learn(gesture);

	for(int i = 0;i<f.length;i++)
	f[i] = new Follower(p,i);
}
}


class Pattern{
	boolean [] state;
	float X[] =  new float[0];
	float Y[] =  new float[0];
	PVector vec[] = new PVector[0];
	Pattern(){
		state  = new boolean[(int)sq(size)];

	}

	void learn(ArrayList a){
		X = new float[a.size()];
		Y = new float[a.size()];
		vec = new PVector[a.size()];

		for(int i = 0 ;i<a.size();i++){
			Pnt tmp = (Pnt)a.get(i);
			X[i] = tmp.X;
			Y[i] = tmp.Y;
		}


		for(int i = 1 ;i<a.size();i++){
			Pnt tmp2 = (Pnt)a.get(i);
			Pnt tmp1 = (Pnt)a.get(i-1);
			vec[i-1] = new PVector(tmp2.X-tmp1.X,tmp2.Y-tmp1.Y);

		}

	}

	void draw(){
	//	stroke(0,127);
		
		totW += (X.length-totW)/20.0;


		if(X.length>0)
			for(int i = 1 ;i<X.length-1;i++){
		//	stroke(#ff0000);
				stroke(255,127);
				line(X[i-1],Y[i-1],X[i],Y[i]);
				
			pushStyle();
				if(f[0]!=null)
				if(f[0].phase==i){
					stroke(#ff0000);
					strokeWeight(5);
				}else{
					strokeWeight(3);
					stroke(255,127);
				}
			
				line(map(i,0,totW,0,width),height/2,map(i,0,totW,0,width)+vec[i].x,height/2+vec[i].y);
				popStyle();
			}


		//simulate();
/*
		int x =0;
		int y = 0;
		for(int i = 0;i<state.length;i++){

			fill(255);

			if(state[i])
				fill(0);


			rect(x,y,5,5);

			x+=5;
			if(x>=5*size){
				y+=5;
				x=0;
			}
		}*/


	}



	void simulate(){

		float theta = atan2(pmouseY-mouseY,pmouseX-mouseX);
		for(int i = 0 ; i < state.length;i++){
			if( 0.1 > abs(theta-map(i,0,state.length,-PI,PI)) )
				state[i] = true;
			else
				state[i]= false;
		}

	}
	//////////////////////////////
	void regen(){
		for(int i = 0;i<state.length;i++){
			if(random(100)>50)
				state[i] = true;
			else
				state[i] = false;
		}

	}

}

class Follower{

	Pattern pat;
	int phase;
	float x,y,lx,ly;
	color c;
    int id;

	Follower(Pattern _pat,int _id){
		pat = _pat;
		id = _id;
        phase = 0;
		lx = x = width/2;//random(width);
		ly = y = height / 2;//random(height);
		c = color(255);
	}


	void draw(){
	
	border();
	
	lx= x;
	ly = y;

	int sel = (int)random(pat.vec.length);

	if(pat.vec[sel]!=null){
	x += pat.vec[sel].x;//+random(-1,1)/3.0;
	y += pat.vec[sel].y;//+random(-1,1)/3.0;
	}
	phase++;

	if(phase>=pat.vec.length){
	phase = 0;
    lx = x = width/2;
    ly = y = height/2;

    if(id==0){
    img.noStroke();
    img.fill(0,22);
    img.rect(0,0,width,height);
    img.save("/desk/handPaint/hand"+nf(counter,4)+".png");
    counter++;
    }
    }
	
	img.stroke(c,10);
	img.line(lx,ly,x,y);

	}

	void border(){
	
	
	
		if(x<0){
			float tmpx = x;
			x=width+tmpx;
		
		}
	
		if(x>width){
		float tmpx = x-width;
			
			
			x=tmpx;
		}
	
	
		if(y<0){
			float tmpy = y;
			y=height+tmpy;
		
		}
	
		if(y>height){
		float tmpy = y-height;
			
			
			y=tmpy;
		}
	
	}

}

class Pnt{
	float X,Y;
	Pnt(float _X,float _Y){
		X=_X;
		Y=_Y;
	}
}
