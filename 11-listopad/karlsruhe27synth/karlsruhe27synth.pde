import promidi.*;

MidiIO midiIO;
MidiOut midiOut;

int numBngs = 10;

float [] pitches = {
  45, 60, 85
};
float [] vols = {
  100, 75, 60
};
float [] lengths = {
  60, 120, 120
};

int [] ctlNums = {
  7, 8, 9
};

int [] instr = {
  1, 2, 3
};

ArrayList notes;
ArrayList seqs;
ArrayList ctls;
ArrayList bangers;

float t = 0;

void setup() {
  size(1600, 240, P2D);

  noiseSeed(19);

  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);

  //print a list with all available devices
  midiIO.printDevices();

  //open an midiout using the first device and the first channel
  midiOut = midiIO.getMidiOut(0, 0);

  notes= new ArrayList();
  seqs = new ArrayList();
  ctls = new ArrayList();
  bangers = new ArrayList();

  for (int i = 0 ; i < pitches.length;i++) {
    ctls.add(new Ctl(i));

    notes.add(new Noter(i, pitches[i], vols[i], lengths[i])); 
    seqs.add(new Seq(i));
    bangers.add(new Banger(i));
  }
}

void draw() {
  background(0);
  t = map(millis(), 0, 60000, 0, width)%width;

  stroke(#ff0000, 100);
  line(t, 0, t, height);

  for (int i = 0 ; i < seqs.size();i++) {
    Seq s = (Seq)seqs.get(i);
    Ctl c = (Ctl)ctls.get(i);
    Noter n = (Noter)notes.get(i);
    Banger b = (Banger)bangers.get(i);

    c.setVal( s.vals[ (int) t ] );

    s.plot();
    b.plot();
  }
}

class Ctl {
  float val;
  int id;

  Ctl(int _id) {
    id = _id;
  }

  void setVal(float _f) {
    val = _f;

    midiOut.sendController( new Controller(ctlNums[id], (int)val)  );
  }
}

class Seq {
  float[] vals;
  int id;

  Seq(int _id) {
    id = _id;
    vals = new float[width];
    for (int i = 0 ; i < width;i++) {
      vals[i] = noise((i+width*id)/30.0)*127.0;
    }
  } 

  void plot() {

    noFill();
    stroke(255, 100);
    beginShape();
    for (int i = 0;i<vals.length;i++) {
      vertex(i, map(vals[i], 0, 127, height, 0));
    } 
    endShape();
  }
}

class Banger extends Seq {

  int bng[];

  Banger(int _id) {
    super(_id);
    for (int i =0 ; i < vals.length;i++) {
      vals[i] = 0;
    }

    bng = new int[numBngs];
    for (int i= 0;i<bng.length;i++) {
      bng[i] = (int)(noise(id*456+i)*width);
    }
  }

  void plot() {
    for (int i = 0;i<bng.length;i++) {
      line(bng[i], 0, bng[i], height);
      if ( abs(t - bng[i])< 1) {
        Noter n = (Noter)notes.get(id);
        n.playNote();
      }
    }
  }
}

class Noter {
  Note note;
  float pitch;
  float vol;
  float len;
  int id;

  float tim;

  Noter(int _id, float _pitch, float _vol, float _len) {
    id = _id;
    pitch = _pitch;
    vol = _vol;    
    len = _len;
    tim = noise(id*123)*width;
  }

  void playNote() {
    midiOut.sendProgramChange(
    new ProgramChange(instr[id])
      );
    note = new Note( (int)pitch, (int)vol, (int)len );
    midiOut.sendNote(note);
  }
  
}

