import javazoom.jlgui.basicplayer.BasicPlayer;

import cami.jmootcher.JMootcher;

String username = "kof";
String passwd = "cigareta";

String keywords []= {"recording","speech"};


JMootcher mootcher_;
BasicPlayer player_;
AudioSample pl[];

void setup() {
  mootcher_ = null;
  player_ = new BasicPlayer();
  login();
  
  
}

void login() {
  boolean succeded_login = false;

  try {
    mootcher_ = JMootcher.factory(username, passwd);
    succeded_login = true;
    System.out.println("//// succeded to login ////");
    
    
  pl = mootcher_.getSamplesByKeyword(keywords);
  println("got "+pl.length+" hits");
  println( pl[0].getFileType() );
  } 
  catch (Exception e) {
    System.out.println("Provided username / password-combination wasn't correct!");
    succeded_login = false;
  }
}

void exit() {
  mootcher_.logout();
  System.exit(0);
}

