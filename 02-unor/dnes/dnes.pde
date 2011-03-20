
/* 
 * This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 */

/*
  Processing test client subscribing to all nodes and listening to TIKS
  using Smack Library 3.1.0 nightly build (includes pubsub service)
  see http://www.igniterealtime.org/projects/smack/documentation.jsp
  https://svn.igniterealtime.org/svn/repos/smack/trunk/documentation/extensions/pubsub.html
 */
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myBroadcastLocation;

TIK tik;
Map<String,Integer> clockList = new HashMap<String,Integer>();  //keep track of clocks and tiks
int y = 60;

class TIK
// Tik Class, wraps XMPP functions from the Smack API into easy TIK object
{ 
  //define static vars
  String server = "walls.okno.be";
  String user = "tester@walls.okno.be";
  String password = "tester";

  //define XMPP objects
  ConnectionConfiguration config;
  XMPPConnection connection;
  PubSubManager manager;

  TIK()
  {
    config = new ConnectionConfiguration(server, 5222);
    //config.setSASLAuthenticationEnabled(true); //throws an error, set to true?
    config.setSelfSignedCertificateEnabled(true);
    connection = new XMPPConnection(config);
  }

  // connect to XMPP server   
  void connect(){ 
    try 
    {
      connection.connect();
      text("connected", 10, 20);
      // we log in  
      connection.login(user, password);
      //connection.loginAnonymously();  //error on openfire prevents subscription of anonymous users
      text("logged in as "+connection.getUser(), 10, 30);
    } 
    catch (XMPPException e1) 
    {
      print("connection error:");
      e1.printStackTrace();
    }
    
    //open connection pubsub service
    manager = new PubSubManager(connection, "pubsub." + server);
  }

  //get list of clocks from pubsub and subscribe to them
  void getClocks()
  {      
    try {
      DiscoverItems items = manager.discoverNodes(null);
      Iterator<DiscoverItems.Item> it = items.getItems();

      while (it.hasNext()) {
        DiscoverItems.Item item = it.next();
        clockList.put(item.getNode(),new Integer(0));
        println("Clock found:"+item.getNode());

        //subscribe to every node
        subscribe(item.getNode());
      }
    } 
    catch(XMPPException e1) {
      System.out.println("retrieving nodes failed:");
      e1.printStackTrace();
    }
  }

  //subscribe to node and listen to published TIKS
  void subscribe(String clockId)
  {		
    try 
    {
      //retrieve nodes
      Node clock = manager.getNode(clockId);
      ItemEventListener myEventHandler = new ItemEventListener<PayloadItem>() 
      {
        // listen to new TIKS
        public void handlePublishedItems(ItemPublishEvent<PayloadItem> subNode) 
        {
          // parse TIKS we receive
          String tikEvent = subNode.getItems().toString();
          println("new tik:"+tikEvent);
          String clockId = tikEvent.substring(tikEvent.indexOf("<id>")+4,tikEvent.indexOf("</id>"));
          String tiks = tikEvent.substring(tikEvent.indexOf("<tiks>")+6,tikEvent.indexOf("</tiks>"));
          //keep track of them with clocklist
          clockList.put(clockId, Integer.parseInt(tiks));
        }
      }; 
      clock.addItemEventListener(myEventHandler);
      clock.subscribe(connection.getUser());
      println("subscribed to "+clockId);
    }
    catch (XMPPException e1)
    {
      println("xmpp error: "+e1.getXMPPError());
    }
  }
}

void setup() 
{
  size(500, 500);
  background(0);
  fill(255, 100, 100);
  
  tik = new TIK();
  //connect to TIK server
  tik.connect();
  //subscribe to all nodes on XMPP pubsub service  
  tik.getClocks();
  oscP5 = new OscP5(this,12000);
  myBroadcastLocation = new NetAddress("127.0.0.1",32000);
}
void connect() {
  OscMessage m;
  m = new OscMessage("/server/connect",new Object[0]);
  oscP5.flush(m,myBroadcastLocation);  

}
void draw() {
  background(0);
  
  // print all clocks to screen
  Set set = clockList.entrySet();
  Iterator i = set.iterator();
  int pos = 0;
  
  while(i.hasNext()){
    Map.Entry me = (Map.Entry)i.next();
    text(me.getKey()+": "+me.getValue(),10,20+15*pos);
    OscMessage myOscMessage = new OscMessage("/tiks/"+me.getKey());
    float oscvalue = me.getValue();
    myOscMessage.add();
    oscP5.send(myOscMessage, myBroadcastLocation);
    pos++;
  }
}

