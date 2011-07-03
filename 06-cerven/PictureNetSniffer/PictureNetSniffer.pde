// A Simple Carnivore Client -- print packets in Processing console
//
// Note: requires Carnivore Library for Processing (http://r-s-g.org/carnivore)
//
// + Windows:  first install winpcap (http://winpcap.org)
// + Mac:      first open a Terminal and execute this commmand: sudo chmod 777 /dev/bpf*
//             (must be done each time you reboot your mac)

import org.rsg.carnivore.*;
import org.rsg.lib.Log;
import java.awt.Toolkit;
import java.util.Iterator;

HashMap nodes = new HashMap();


int counter= 0;

CarnivoreP5 c;
InputStream in ;
BufferedImage image;
ArrayList buffer = new ArrayList(0);

boolean rec = false;
boolean cap = false;

ArrayList imgs = new ArrayList(0);

void setup() {
  size(600, 400);
  background(255);

  Log.setDebug(false); // Uncomment for verbose mode
  c = new CarnivoreP5(this); 
  c.setShouldSkipUDP(true); //tcp packets only (optional)
}

void draw() {
  background(0);
  for(int i = 0;i<imgs.size();i++) {
    PImage tmp = (PImage)imgs.get(i);
    if(tmp!=null)
      image(tmp,10,10);
  }
  //println(imgs.size());
}


void packetEvent(CarnivorePacket p) {
 // println(p.toString());
  if((p.senderPort == 80) || (p.receiverPort == 80) && p.toString().indexOf(".png")>-1) {
    println(p.payload());
  }
}

// Called each time a new packet arrives
void packetEvent2(CarnivorePacket p) {
  counter++;


  if((p.senderPort == 80) || (p.receiverPort == 80)) { 
    counter = 0 ;


    // println(msg);


    String msg = p.ascii();
    String[] hase = splitTokens(msg," ");
    byte data[] = p.data;

    if(hase.length>1) {
      if(hase[1].indexOf(".gif")>-1) {

        buffer = new ArrayList(0);
        buffer.add((byte[])data);
        println("Got somtehing like an Image! Look:\nhttp:/"+p.receiverAddress.ip+hase[1]+"\n");
        cap = true;
        println(imgs.size());
      }
    }

    if(data.length>1 && cap) {

      byte[] tmp = new byte[data.length];
      boolean hasEnd = false;

      for(int i = 0;i<data.length;i++) {



        if(data[i] == -1) {
          println("EOF!");
          hasEnd = true;
          break;
        }

        tmp[i] = data[i];
      }

      buffer.add((byte[])tmp);

      if(hasEnd) {
        println(counter);
        cap = false;

        byte [] trans = new byte[buffer.size()];
        for(int i = 0;i<buffer.size();i++) {
          trans[i] = (byte)(Byte)buffer.get(i);
        }

        //Image result = new Image(1,1,0);
        try
        {


          imgs.add(new PImage(Toolkit.getDefaultToolkit().createImage(trans)));

          //result = Toolkit.getDefaultToolkit().createImage(trans);
        }
        catch ( Exception e )
        {

          println("-------------   FUCK !!! :"+e);
        }
      }
    }
  }
}

