import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import javax.sound.sampled.*;

import cami.jmootcher.*;

import sun.audio.*; //import the sun.audio package

import javazoom.jlgui.basicplayer.BasicPlayer;
import javazoom.jlgui.basicplayer.BasicPlayerException;
import cami.jmootcher.AudioSample;

cami.jmootcher.AudioSample f;

JMootcher mootcher;

String username = "kof";
String passwd = "cigareta";

String keywords = "speech";

void setup() {


  try {
    mootcher = JMootcher.factory("kof", "cigareta");
    //mootcher.setPreviewCacheDirName(sketchPath);
    mootcher.checkogin() ;
    println("1 one");

    try {
      f = mootcher.getSamplesByKeyword(keywords)[0];
      println("got some sample !");
    }
    catch(Exception e) {
      println(e);
    }


    //BufferedReader br = new BufferedReader(new InputStreamReader(f.getPreviewInputStream()));
    //println(br.readLine());

    //println(f.getOriginalFileName());

    AudioFormat playbackFormat = new AudioFormat(44100, 16, 2, true,false);

    AudioInputStream stream = AudioSystem.getAudioInputStream(f.getPreviewInputStream());
    // source = AudioSystem.getAudioInputStream(playbackFormat, source);

    //          DataLine.Info info = new DataLine.Info(Clip.class, stream
    //                  .getFormat(), ((int) stream.getFrameLength() * format
    //                 .getFrameSize()));

    Clip clip = (Clip) AudioSystem.getClip();
    //            clip.addLineListener(this);
    clip.open(stream);
    clip.start();

    //System.out.println(mootcher.getSimilar(4030));
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}


void exit() {
  mootcher.logout();
  super.exit();
}

