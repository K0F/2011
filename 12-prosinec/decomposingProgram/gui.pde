import java.lang.reflect.*;

boolean mousedown = false;
int GLOB = 0;

class GUI {

 int x,y;


  float maxs[] = {
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255
  };
  float mins[] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  };


  int rozpal = 12;

  Object object;
  Class<?> monitoredClass;
  Field[] fields;
  Method[] methods;
  String [] monitor_names;
  
  String superName;

  Controller c;

  ArrayList ctl;

  GUI(Object _parent, int _x,int _y, String toMonitor[]) {
    object = _parent;
    x = _x;
    y = _y;
    monitor_names = toMonitor;
    
    superName = _parent.getClass().toString();
    
    textFont(createFont("Semplice Regular",8,false));
    
    harvest();
    
  }
  
   GUI(Object _parent, int _x,int _y, String toMonitor[],float _mins[],float _maxs[]) {
     object = _parent;
    x = _x;
    y = _y;
    monitor_names = toMonitor;
    
    mins= _mins;
    maxs = _maxs;
    
    superName = _parent.getClass().toString();
    
    textFont(createFont("Semplice Regular",8,false));
    
    harvest();
    
  }
  
  void harvest(){
   
    monitoredClass = object.getClass();
    fields = monitoredClass.getDeclaredFields();
    methods = monitoredClass.getDeclaredMethods();

    ctl = new ArrayList();


    for (int ii = 0; ii < monitor_names.length; ii++) {
      for (int i = 0; i < fields.length; i++) {
        if (fields[i].getName().equals(monitor_names[ii])) {
          println("got "+monitor_names[ii]);

          ctl.add(fields[i]);
        }
      }
    }

    c = new Controller(this, GLOB++, ctl); 
  }

  void draw() {
    c.draw();
  }
}


class Controller {
  color bckCol = color(#1a1a1a);
  color overCol = color(#FFCC22);
  color normCol = color(#B9B9B9);

  int id;
  ArrayList sliders;
  PVector pos;
  boolean ready = true;
  GUI parent;

  PGraphics rohy[];
  PGraphics roh;
  ArrayList ctlFields;

  float percent = 0;

  int w = 127;

  int cx = -10;
  int cy = -10;
  int wx = 85;

  String name;

  ArrayList ctl;

  Controller(GUI _parent, int _id, ArrayList _ctl) {
    parent = _parent;
    ctl = _ctl;
    name = parent.superName;

    id = _id;

    roh =  createGraphics(8, 8, JAVA2D);
    roh.beginDraw();
    roh.noSmooth();
    roh.fill(bckCol);
    roh.stroke(normCol);
    roh.ellipse(7, 7, 14, 14);
    roh.endDraw();


    rohy = new PGraphics[4];

    for (int i = 0 ; i < rohy.length;i++) {
      rohy[i] = createGraphics(roh.width, roh.height, JAVA2D);
      rohy[i].beginDraw();
      rohy[i].noSmooth();
      rohy[i].imageMode(CENTER);
      rohy[i].translate(roh.width/2, roh.height/2);
      rohy[i].rotate(HALF_PI*i);
      rohy[i].image(roh, 0, 0);


      rohy[i].endDraw();
    }


    pos = new PVector(parent.x, parent.y);

    initSliders();
  }


  void draw() {

    //if (ready)
    updateFields();


    drawBorder();


    for (int i =0 ; i < sliders.size(); i++) {
      Slider s = (Slider)sliders.get(i);
      s.draw();
    }
  }






  void initSliders() {
    sliders = new ArrayList();



    for (int i =0;i<ctl.size();i++) {
      Field tmp = (Field)ctl.get(i);
      sliders.add(new Slider(this, tmp.getName(), 0, parent.rozpal*i, parent.mins[i], parent.maxs[i], (parent.maxs[i]+parent.mins[i]) / 2. ));
    }
  }

  void updateFields() {
    for (int i =0;i<ctl.size();i++) {
      Field tmp = (Field)ctl.get(i);
      Slider s = (Slider)sliders.get(i);

      try {
        tmp.set(parent.object, s.val);
      }
      catch(IllegalAccessException e) {
      }
    }
  }

  void drawBorder() {

    rectMode(CORNER);
    fill(bckCol);
    noStroke();
    rect(pos.x+cx+roh.width, pos.y+cy, wx+w-roh.width, parent.rozpal*sliders.size()+roh.height);
    rect(pos.x+cx, pos.y+cy+roh.height, wx+w+roh.width, parent.rozpal*sliders.size()-roh.height);

    stroke(255);

    image(rohy[0], pos.x+cx, pos.y+cy);
    image(rohy[1], pos.x+w+wx+cx, pos.y+cy);
    image(rohy[2], pos.x+w+wx+cx, pos.y+sliders.size()*parent.rozpal+cy);
    image(rohy[3], pos.x+cx, pos.y+sliders.size()*parent.rozpal+cy);

    // horizontal
    line(pos.x+cx+roh.width, pos.y+cy, pos.x+cx+wx+w, pos.y+cy);
    line(pos.x+cx+roh.width, pos.y+cy+parent.rozpal*sliders.size()+roh.height-1, pos.x+cx+wx+w, pos.y+cy+parent.rozpal*sliders.size()+roh.height-1);

    // vertical
    line(pos.x+cx, pos.y+cy+roh.height, pos.x+cx, pos.y+cy+parent.rozpal*sliders.size() );
    line(pos.x+cx+wx+roh.width+w-1, pos.y+cy+roh.height, pos.x+cx+wx+roh.width+w-1, pos.y+cy+parent.rozpal*sliders.size() );

    noStroke();
    fill(255);

    if (!ready) {
      arc(pos.x+cx+wx+w-2, pos.y+cy+10, 10, 10, 0, map(percent, 0, 100, 0, TWO_PI));
    }
    
    text(name,pos.x-8,pos.y-13);
  }
}



class Slider {
  Controller parent;
  float val;
  float minval, maxval;
  PVector pos;
  String name;
  int w;
  boolean over;

  float absX;
  float absY;

  float def;


  Slider(Controller _parent, String _name, float _x, float _y, float _minval, float _maxval, float _def) {
    def = _def;
    parent = _parent;
    name = ""+_name;
    pos = new PVector(_x, _y);
    minval = _minval;
    maxval = _maxval;
    absX = pos.x+parent.pos.x;
    absY = pos.y+parent.pos.y;
    w = parent.w;

    val = _def;
  }

  void draw() {
    absX = pos.x+parent.pos.x;
    absY = pos.y+parent.pos.y;


    over = isOver();


    if (over&&mousedown) {
      val = minval>maxval?
      constrain(map(mouseX, absX, w+absX, minval, maxval), maxval, minval):
      constrain(map(mouseX, absX, w+absX, minval, maxval), minval, maxval);
    }



    if (parent.ready) {

      if (over) {
        stroke(parent.overCol);
        fill(parent.overCol);
      }
      else {
        stroke(parent.normCol);
        fill(parent.normCol);
      }
    }
    else {
      stroke(parent.normCol, 120);
      fill(parent.normCol, 120);
    }

    rectMode(CENTER);
    text(name, absX+w+10, absY);
    noFill();
    line(absX, absY, w+absX, absY);
    rect(map(val, minval, maxval, absX, absX+w), absY, 3, 5);
  }


  boolean isOver() {
    if (mouseX>absX-5&&mouseX<absX+w+20&&mouseY>absY-5&&mouseY<absY+5)
      return true;
    else
      return false;
  }
}

void mousePressed() {
  mousedown = true;
}

void mouseReleased() {
  mousedown = false;
}


