import codeanticode.gsvideo.*;

GSMovie movie;

int newFrame = 0;
String [] raw;
FSScraper bank[];

ArrayList subs = new ArrayList();

float time = 0;

boolean debug = false;

boolean showMovie = true;


void setup(){
	size(320,240,P2D);


	textFont(createFont("Verdana",9,false));
	textMode(SCREEN);

	raw = loadStrings("test.srt");
	parseFile();


	bank = new FSScraper[subs.size()];
	for(int i = 0;i<subs.size();i++){
		Sub curr = (Sub)subs.get(i);
		bank[i] = (new FSScraper(this,curr.id,curr.text));
	}


	movie = new GSMovie(this,"SP2.mpg");
	movie.play();
	movie.volume(0);

}

void parseFile(){
	int cnt = 1;
	for(int i = 0 ;i<raw.length;i++){

		if(debug)
			println(i+" : "+parseInt(raw[i]));
		if(raw[i].length()<=3 && parseInt(raw[i]) != 0){

			if(parseInt(raw[i]) == cnt){
				String tim = raw[i+1];
				String txt = raw[i+2];

				subs.add(new Sub(txt,cnt,tim));
				cnt++;
			}
		}
	}

}



void movieEvent(GSMovie movie) {
	movie.read();
}

void draw(){

	//background(0);

	if(showMovie){
		// if (movie.available()) {
		image(movie, 0, 0, width, height);
		fill(240, 20, 30);
		//text("frame: "+movie.frame() + " / " + (movie.length() - 1) + "\ntime:"+time, 10, 30);
		//text();
		time = movie.time();

		for(int i = 0 ;i<subs.size();i++){
			Sub tmp = (Sub)subs.get(i);
			tmp.draw();

			if(!bank[i].ended){
				bank[i].draw();
			}

		}

		//}

	}else{
		time=millis()/1000.0;
		fill(240, 20, 30);
		text("frame: "+ frameCount + " / " + (movie.length() - 1) + "\ntime:"+time, 10, 30);

		for(int i = 0 ;i<subs.size();i++){
			Sub tmp = (Sub)subs.get(i);
			tmp.draw();
		}
	}

}



class FSScraper{
	String apiKey = "4daf76e033114821b7b686f955b86880";
	String query;
	PApplet parent;
	XMLElement response;
	int numResults;
	ArrayList sample = new ArrayList();
	int num = 1;
	int id;
	GSPipeline pipe;
	String url;
	float vol = 1.0;
	boolean ended = false;

	boolean fading = false;

	FSScraper(PApplet _parent,int _id,String _query){
		query = _query;
		parent = _parent;
		id = _id;

		reload();
	}

	void waitUntilEndAndReload(){
		fading = true;
	}

	void fadeOutAndReload(){
		if(!fading){
			fading = true;

		}

	}


	void reload(){
		if(pipe!=null)
			pipe.delete();

		fading = false;
		println("creating sample: "+query);
		String request = "http://tabasco.upf.edu/api/sounds/search?q="+query+"&api_key="+apiKey+"&format=xml";
		response = new XMLElement(parent,request);
		numResults = response.getInt("num_results");


		XMLElement tmp[] = response.getChildren("sounds/resource/preview");

		url = tmp[(int)random(tmp.length)].getContent();
		pipe = new GSPipeline(parent, "gnomevfssrc location="+url+" ! mad ! audioconvert ! audioresample ! alsasink", GSVideo.AUDIO);

		// println(url+" : "+pipe.duration());

	}

	void play(){
		if(pipe!=null){
			pipe.play();
		}
	}

	void draw(){
		if(pipe.time()>=pipe.duration()-0.4 && pipe.duration()>0){
			pipe.delete();
			ended = true;
		}



	}
}

class Sub{
	String text;
	int id;
	int sH,sM,sS,sMS,eH,eM,eS,eMS;
	boolean active = false;
	boolean notPlayed = true;

	Sub(String _text,int _id,String _time){

		//println(_text);
		text = _text;
		id = _id;
		String time = _time;

		String split[] = splitTokens(time,":, ->");

		sH = parseInt(split[0]);
		sM = parseInt(split[1]);
		sS = parseInt(split[2]);
		sMS = parseInt(split[3]);

		eH = parseInt(split[4]);
		eM = parseInt(split[5]);
		eS = parseInt(split[6]);
		eMS = parseInt(split[7]);

		if(debug)
			println("got sub: "+id+"\ntext:"+text+"\ntime:"+sH+":"+sM+":"+sS+"."+sMS+" --> "+eH+":"+eM+":"+eS+"."+eMS);


	}

	boolean active(){
		if (getStartTime()<=time && getEndTime()>=time)
			return true;
		else
			return false;
	}


	void draw(){
		active = active();

		if(active){
			if(notPlayed){
				bank[id-1].play();
				notPlayed = false;
			}

			text(text,10,height-20);
		}
	}

	float getStartTime(){
		String a = sS+"."+sMS;
		return (parseFloat(a)+sM*60+sH*60*60);
	}

	float getEndTime(){
		String a = eS+"."+eMS;
		return (parseFloat(a)+eM*60+eH*60*60);
	}

}
