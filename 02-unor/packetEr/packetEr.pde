// A Simple Carnivore Client -- print packets in Processing console
//
// Note: requires Carnivore Library for Processing (http://r-s-g.org/carnivore)
//
// + Windows:  first install winpcap (http://winpcap.org)
// + Mac:      first open a Terminal and execute this commmand: sudo chmod 777 /dev/bpf*
//             (must be done each time you reboot your mac)

import org.rsg.carnivore.*;
import org.rsg.lib.Log;

CarnivoreP5 c;

ArrayList data = new ArrayList(0);

int logsize = 100;

void setup(){
	size(1024, 768,P2D);
	background(255);
	Log.setDebug(true); // Uncomment for verbose mode
	c = new CarnivoreP5(this);
	//c.setVolumeLimit(4); //limit the output volume (optional)
	//c.setShouldSkipUDP(true); //tcp packets only (optional)
	textFont(createFont("Dialog",10,false));
	textMode(SCREEN);
}

void draw(){
	background(0);

fill(#00ff00);

	for(int i = 0;i<data.size();i++){
		String tmp = (String)data.get(i);
		text(tmp,5,i*10);
	}


}

// Called each time a new packet arrives
void packetEvent(CarnivorePacket p){
	//  println("(" + p.strTransportProtocol + " packet) " + p.senderSocket() + " > " + p.receiverSocket());
	//println("Payload: " + p.ascii());

	String a = p.ascii();

	if(a.length()>0)
		data.add(a);

	if(data.size()>logsize)
		data.remove(0);


}
