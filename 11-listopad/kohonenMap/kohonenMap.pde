
Mapa mapa;


void setup(){

	size(320,240,P2D);
	colorMode(HSB,1);

	noiseSeed(1);
	noSmooth();

	mapa = new Mapa(30);

}



int ns = 0;

void draw(){

//	mapa.iterate2();



	background(0);
	mapa = new Mapa(10);

	Node n = (Node)mapa.nodes.get( frameCount % mapa.nodes.size() );
	noiseSeed((long)(n.val.x/n.val.y/n.val.z));
	mapa.draw();


	if(frameCount%100==0){
		ns++;
		noiseSeed(ns);
	}



}



class Mapa{
	ArrayList nodes;
	float radius;
	int nx[] = {-1,0,1,-1,1,-1,0,1};
	int ny[] = {-1,-1,-1,0,0,1,1,1};

	Mapa(float _radius){

		radius = _radius;

		int cnt = 0;

		nodes = new ArrayList();
		for(int y = 0 ;y<height;y++){
			for(int x = 0 ; x < width ; x++ ){

				nodes.add(new Node(cnt));
				cnt++;
			}
		}
	}

	void draw(){

		int i = 0;

		for(int y = 0 ;y<height;y++){
			for(int x = 0 ; x < width ; x++ ){
				Node n = (Node)nodes.get(i);

				color c = color(n.val.x,n.val.y,n.val.z);
				stroke( noise(n.val.x), noise(n.val.y) , noise(brightness(c)) , 0.25);
				point(noise(noise(x))*width,noise(noise(noise(y)))*height);
				
				i++;

			}
		}

	}


	void iterate(){
		int i = 0;

		for(int y = 0 ;y<height;y++){
			for(int x = 0 ; x < width ; x++ ){

				int i2 = 0;
				Node n1 = (Node)nodes.get(i);


				for(int y2 = 0 ;y2<height;y2++){
					for(int x2 = 0 ; x2 < width ; x2++ ){
						float d = dist(x,y,x2,y2);
						if(d > radius){
							continue;
						}else if ( d!=0 ){
						

							Node n2 = (Node)nodes.get(i2);

							//PVector desired = n2.val.sub(n1.val,n2.val);

							PVector p = n2.val;
							p.mult(1/d);
							n1.val.add(p);
							n1.val.normalize();
							i2 ++;
						}

					}
				}
				i++;

			}
		}


	}

	void iterate2(){
		Node n = (Node)nodes.get(frameCount%nodes.size());
		
		for (int i = 0 ; i < nx.length ; i++){
			Node other = (Node)nodes.get( (i+nx[i]+ny[i]*width+width*height) / nodes.size());
			n.val.add(other.val);
			n.val.normalize();
		}
		
		

	}

}

class Node{
	PVector val;
	float w;
	int id;

	Node(int _id){
		id = _id;
		val = new PVector( noise(id*333.3), noise(id*222.2), noise(id*111.3) );

		w = noise(id*19.19);
	}



}
