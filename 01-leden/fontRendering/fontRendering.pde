import processing.opengl.*;


import geomerative.*;
String raw[];

String fontName = "Aller_Rg.ttf";
int fontSize = 80;

RFont font;


ArrayList msg = new ArrayList(0);


void setup() {
	size(320, 240,OPENGL);

	RG.init(this);
	font = new RFont(fontName, fontSize, RFont.CENTER);

	raw = loadStrings("input.txt");

	for(int i = 0;i<raw.length;i++) {
		String radek = raw[i]+"";

		String[] tmp = splitTokens(radek,",. ");
		for(int q = 0;q<tmp.length;q++) {
			println(tmp[q]);
			msg.add((String)tmp[q]);
		}
	}

	//smooth();
	stroke(0,50);
	noFill();
}


void draw() {
	background(255);



	for(int i = 0;i<msg.size();i++) {
		//pushMatrix();
		//translate(width/2+sin(frameCount/(10+i))*10.0,height/2);
		//scale(1/(i+1));

		String tmp = (String)msg.get(i);
		font.draw(tmp);
	//	popMatrix();
	}
}

