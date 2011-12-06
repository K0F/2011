/**
 *   The Engine class scheduling new Threads
 *   for pre-redering image layers
 */


class TheEngine{

	ArrayList unit;
	ArrayList names;
	GUI gui;

	Thread thread; 


	TheEngine(){
		gui = new GUI();
		unit = new ArrayList();
	}

	void addImage(PImage _src){
		unit.add(new ImageMasher(unit.size(),_src));
		thread = new Thread((ImageMasher)unit.get(unit.size()-1));
		thread.start();
	}

	void addImage(String _name){
		ImageMasher tmp = new ImageMasher(unit.size(),_name);
 
		unit.add(tmp);
		thread = new Thread((ImageMasher)unit.get(unit.size()-1));
		thread.start();

	}

	void draw(){

		for(int i = 0 ; i < unit.size(); i++){

			ImageMasher one = (ImageMasher)unit.get(i);

			if(one.ready)
				one.draw();

		}
	}

}
