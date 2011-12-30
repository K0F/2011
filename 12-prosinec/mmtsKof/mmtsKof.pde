import ddf.minim.*;



Minim minim;
AudioInput in;
AudioRecorder recorder;


/*##########################*/
int countname; //change the name
int name = 000000; //set the number in key's' function

// change the file name
void newFile()
{      
  countname =( name + 1);
  recorder = minim.createRecorder(in, "file/A08May" + countname + ".wav", true);
  // println("file/" + countname + ".wav");
}
/*###############################*/


void setup()
{
  size(512, 200, P2D);
  textMode(SCREEN);

  minim = new Minim(this);

  // get a stereo line-in: sample buffer length of 2048
  // default sample rate is 44100, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 2048);
  // create a recorder that  will record from the input to the filename specified, using buffered recording
  // buffered recording means that all captured audio will be written into a sample buffer
  // then when save() is called, the contents of the buffer will actually be written to a file
  // the file will be located in the sketch's root folder.

  newFile();//go to change file name
  textFont(createFont("SanSerif", 12));
}


void draw() {
  if ( recorder.isRecording() )
  {
    text("Currently recording...", 5, 15);
  }
  else
  {
    text("Not recording.", 5, 15);
  }
} 


void keyReleased()
{
  if ( key == 'r' )
  {
    // to indicate that you want to start or stop capturing audio data, you must call
    // beginRecord() and endRecord() on the AudioRecorder object. You can start and stop
    // as many times as you like, the audio data will be appended to the end of the buffer
    // (in the case of buffered recording) or to the end of the file (in the case of streamed recording).
    if ( recorder.isRecording() )
    {
      recorder.endRecord();
    }
    else
    {
      /*#######################################*/
      newFile();
      /*#######################################*/
      recorder.beginRecord();
    }
  }
}

