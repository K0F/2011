

float[] graph;

float compress = 70.0;
float speed = 26.0;


void setup(){
	size(600,600,P2D);

	graph = new float[width];

	stroke(255,20);


}

float theta = 0;
float smoothing = 2000.0;

float mx,mn;


float R = 300;

void draw(){


	compress= 30+frameCount/100.0;	

	background(#000000);

	fill(#020202);
	noStroke();

	ellipse(width/2,height/2,width,height);	

	mn = 30000.0;
	mx = 0;
	for(int i =0 ; i < width;i++){
	graph[i] = noise(i/compress+frameCount/speed)*height;
	
	mx = max(mx,graph[i]);
	mn = min(mn,graph[i]);
	}


	translate(width/2,-height/2);

	pushMatrix();

	translate(0,height);

	float x1 = 0,x2 = 0,y1 = 0,y2 = 0;

	for(float s = smoothing;s >= 1;s*=0.8)
	for(int i =1 ; i < width;i++){
		x1 = 0;
		x2 = 0-1;
		
		pushMatrix();

		y1 += (map(graph[i],mn,mx,0,R) - y1) / s;
		y2 += (map(graph[i-1],mn,mx,0,R) - y2) / s;
		

		stroke(#ffcc00,120);
		strokeWeight(3);

		rotate(map(width-i,0,width,-PI,PI));


		//if((mn==graph[i] || mn==graph[i-1]) )
		//line(0,0,0,10);


		//if((mx==graph[i] || mx==graph[i-1]) )
		//line(0,y1,0,0);

		
		theta = atan2(y1-y2,x1-x2) ;
		strokeWeight(theta*3);
		stroke(lerpColor(#FF0000,#00FF00,norm(theta,-2,2)),map(s,0,smoothing,50,3));

		line(x1,y1,x2,y2);
		
		
		

		if(false){
		stroke(#aaaaaa,map(s,0,smoothing,50,0));
		pushMatrix();
		translate(x1,y1);
		rotate(theta-HALF_PI);
		line(0,20,0,0);
		popMatrix();
		}

		
		popMatrix();
	}

	popMatrix();

}
