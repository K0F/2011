/**
*    KM rendr pro Martina, kof 11
*/

///// SETTINGS ///////////////////////////

boolean render = true;

int W = 1280;
int H = 720;

int x = W-50;
int y = 100;

int pocetOken = 7750;

float start = 0;
float cil = 125.5;

float km = 0;
float km2 = 0;

boolean listFonts = false;

///// FONT ///////////////////////////////

int fontNum = 159;
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

	String txt = (((int)(km*100000.0))/100000.0)+"";
	String num[] = new String[2];
	num = splitTokens(txt,".");

	if(num[1].equals("")){
		num[1] = "00000";
	}else{

	while(num[1].length()<5){
		num[1]+="0";
	}
}
	
		
	text(num[0]+"."+num[1].substring(0,3)+"."+num[1].substring(3,num[1].length())+" km",x,y);

	if(render){
		saveFrame("/desk/martin/frame#####.png");
	}
}
