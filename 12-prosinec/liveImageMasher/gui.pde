
class GUI{

	ArrayList interfaces;

	GUI(){
		noSmooth();
		textFont(createFont("SempliceRegular",8,false));
		textMode(SCREEN);
		textAlign(CENTER);

		interfaces = new ArrayList();

	}

	void addControl(int _id){
		interfaces.add(new Controller(_id));
	}



}

class Controller{
	int id;

	

}
