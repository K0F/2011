/**
*    KM rendr pro Martina, kof 11
*/

///// SETTINGS ///////////////////////////

boolean render = false;

int W = 1280;
int H = 720;

int x = W-50;
int y = 100;

int pocetOken = 6000;

float start = 120;
float cil = 0;

float km = 0;
float km2 = 0;

boolean listFonts = false;

///// FONT ///////////////////////////////

int fontNum = 162;
int fontSize = 20;

////// RENDER ////////////////////////////

void setup(){
	size(W,H,P2D);
	fill(255);
	textFont(createFont(PFont.list()[fontNum],fontSize));
	textMode(SCREEN);

	textAlign(RIGHT);

	if(listFonts){
		println(PFont.list());
		exit();
	}
}

void draw(){
	background(0);
	
	km = map(frameCount,0,pocetOken,start,cil);
	text((int)km+" km",width-25,100);

	if(render){
		saveFrame("/desk/martin/frame#####.png");
	}
}

