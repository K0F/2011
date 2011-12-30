import ddf.minim.*;
 
Minim minim;
AudioInput in;
AudioRecorder recorder;


void setup()
{
  size(512, 200);
 
  minim = new Minim(this);
  
  
} 
   
void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  // always stop Minim before exiting
  minim.stop();
 
  super.stop();
}
