PImage bck;
Linka metroA;

float time = 0;

void setup(){
	size(800,600,P2D);
	metroA = new Linka("metroA.txt");
	bck = loadImage("vlak.png");
	textFont(createFont("Droid Sans",8,false));
	textMode(SCREEN);
	noSmooth();
}

void draw(){
	background(255);
	image(bck,width-200,0);
	metroA.kresli();
}

void mousePressed(){
	println(","+mouseX+","+mouseY);
}

class MHD{
}

class Souprava{
	PVector pos;
	Stanice vychozi;
	Stanice dalsi;
	Linka parent;
	int smer = -1;

	Souprava(Stanice _vychozi,Linka _parent){
		vychozi = _vychozi;
		parent = _parent;
		
		if(vychozi.id==0)
		smer = 1;

		pos = new PVector(vychozi.pos.x,vychozi.pos.y);
	}

	void draw(){
		
	

	}	
}

class Linka{
	String jmeno;
	ArrayList stanice;
	int typ;
	int intervaly[];
	float x[];
	float y[];
	float casy1[];

	ArrayList soupravy;

	Linka(String filename){
		loadData(filename);
	}
	
	/*
	Linka(String _jmeno,String[] _zastavky,int _typ){
		jmeno = _jmeno;
		typ = _typ;
		stanice = new ArrayList();
		for(int i = 0 ; i < _zastavky.length ; i++){
			stanice.add(new Stanice(_zastavky[i],typ));
		}
	}
	*/	
	
	void loadData(String filename){
		String [] raw = loadStrings(filename);
		jmeno = raw[0];
		String _intervaly[] = splitTokens(raw[1],",");
		intervaly = new int[_intervaly.length];
		String _x[] = splitTokens(raw[2],",");
		x = new float[_intervaly.length];
		String _y[] = splitTokens(raw[3],",");
		y = new float[_intervaly.length];
		typ = parseInt(raw[4]);

		int offset = 6;

		String casy[] = splitTokens(raw[5],",");
		casy1 = new float[casy.length];
		for(int i =0 ; i < casy.length ; i++){
			String[] sub = splitTokens(casy[i],":");
			casy1[i] = parseInt(sub[0])+60*parseInt(sub[1]);
		}

		for(int i =0 ;i<intervaly.length;i++){
			intervaly[i] = parseInt(_intervaly[i]);
			x[i] = parseFloat(_x[i]);
			y[i] = parseFloat(_y[i]);
		}

			stanice = new ArrayList();

		for(int i = offset ; i < raw.length ; i++){
			stanice.add(new Stanice(raw[i],x[i-offset],y[i-offset],typ,i-offset));
		}
	}

	void kresli(){
		noFill();
		stroke(0,20);
		strokeWeight(3);

		beginShape();

		noFill();
		stroke(0);
		strokeWeight(10);
		for(int i =0 ; i < stanice.size();i++){
			Stanice tmp1 = (Stanice)stanice.get(i);

	//		if(i==0||i==stanice.size()-1){
			vertex(tmp1.pos.x,tmp1.pos.y);
	//		}else{
	//		curveVertex(tmp1.pos.x,tmp1.pos.y);
	//		}

		}
		endShape();



		noStroke();
		fill(255);
		
		for(int i =0 ; i < stanice.size();i++){
			Stanice tmp1 = (Stanice)stanice.get(i);
			tmp1.kresli();
		}


	}
}

class Stanice{
	String jmeno;
	PVector pos;
	int typ;
	int id;

	Stanice(String _jmeno,float _x,float _y, int _typ,int _id){
		jmeno = _jmeno;
		typ = _typ;
		id = _id;
		pos = new PVector(_x,_y);
	}

/*
	Stanice(String _jmeno,int _typ){
		jmeno = _jmeno;
		typ = new int[1];
		typ[0] = _typ;
		pos = new PVector(0,0);
	}
*/

	void kresli(){

		int xx = -20;
		int yy = 40;

		fill(255);
		ellipse(pos.x,pos.y,10,10);
		fill(0);
		stroke(0,50);
		strokeWeight(1);
		text(jmeno,pos.x+xx,pos.y+yy);
		line(pos.x,pos.y,pos.x+xx,pos.y+yy);
		noFill();	
	}
}
