import java.lang.reflect.*;
boolean mousedown = false;

class GUI {

  String DEFAULT_NAMES[] = {
    "x", 
    "y", 
    "tras", 
    "shake_speed"
  };

  float mins[] = {
    0, 0, 0, 0
  };
  float maxs[] = {
    127, 127, 127, 127
  };

  int rozpal = 15;

  ArrayList controllers;
  TheEngine parent;

  GUI(TheEngine _parent) {



    parent = _parent;
    noSmooth();
    textFont(createFont("SempliceRegular", 9, false));
    textMode(SCREEN);
    textAlign(LEFT);

    resetControllers();
  }

  void resetControllers() {
    controllers = new ArrayList();

    for (int i =0 ; i<parent.unit.size();i++) {
      addController(i);
    }
  }

  void addController(int _id) {
    controllers.add(new Controller(this, _id));
  }

  void draw() {
    for (int i = 0;i<controllers.size();i++) {
      Controller c = (Controller)controllers.get(i);
      c.draw();
    }
  }
}

class Controller {

  int id;
  ArrayList sliders;
  PVector pos;
  boolean ready = false;
  GUI parent;
  TheEngine engine;
  PGraphics rohy[];
  PImage roh;
  ArrayList ctlFields;

  int w = 127;

  Object unit;
  Class<?> myClass;
  Field[] fields;

  Controller(GUI _parent, int _id) {
    parent = _parent;
    engine = parent.parent;



    harvestFields();


    id = _id;


    roh =  loadImage("corner.png");


    rohy = new PGraphics[4];



    for (int i = 0 ; i < rohy.length;i++) {
      rohy[i] = createGraphics(roh.width, roh.height, JAVA2D);
      rohy[i].beginDraw();
      rohy[i].imageMode(CENTER);
      rohy[i].translate(roh.width/2, roh.height/2);
      rohy[i].rotate(HALF_PI*i);
      rohy[i].image(roh, 0, 0);
      rohy[i].endDraw();
    }

    pos = new PVector(10, height/2);

    initSliders();
  }

  void harvestFields() {

    ctlFields = new ArrayList();

    unit = engine.getUnit(id);
    myClass = unit.getClass();
    fields = myClass.getDeclaredFields();

    for (int i = 0; i < fields.length; i++) {
      for (int ii = 0; ii < parent.DEFAULT_NAMES.length; ii++) {

        if (fields[i].getName().equals(parent.DEFAULT_NAMES[ii])) {
          println("got "+parent.DEFAULT_NAMES[ii]);
          ctlFields.add(fields[i]);
        }
      }
    }
  }


  void initSliders() {
    sliders = new ArrayList();

    harvestFields();

    for (int i =0;i<ctlFields.size();i++) {
      Field tmp = (Field)ctlFields.get(i);
      sliders.add(new Slider(this, tmp.getName(), 0, parent.rozpal*i, parent.mins[i], parent.maxs[i]));
    }
  }

  void updateFields() {
    for (int i =0;i<ctlFields.size();i++) {
      Field tmp = (Field)ctlFields.get(i);
      Slider s = (Slider)sliders.get(i);

      try {

        tmp.set(unit, s.val);
      }
      catch(IllegalAccessException e) {
      }
    }
  }

  void drawBorder() {
    int cx = -10;
    int cy = -12;
    int wx = 50;

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
  }

  void draw() {
    ready = engine.getUnit(id).ready;

    if(ready)
    updateFields();

    drawBorder();

    for (int i =0 ; i < sliders.size(); i++) {
      Slider s = (Slider)sliders.get(i);
      s.draw();
    }
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

  color overCol = color(#22FF11);
  color normCol = color(#FFFFFF);

  float absX;
  float absY;


  Slider(Controller _parent, String _name, float _x, float _y, float _minval, float _maxval) {
    parent = _parent;
    name = ""+_name;
    pos = new PVector(_x, _y);
    minval = _minval;
    maxval = _maxval;
    absX = pos.x+parent.pos.x;
    absY = pos.y+parent.pos.y;
    w = parent.w;
  }

  void draw() {
    absX = pos.x+parent.pos.x;
    absY = pos.y+parent.pos.y;


    over = isOver();


    if (over&&mousedown) {
      val = map(mouseX, absX, w+absX, minval, maxval);
    }

    if (parent.ready) {

      if (over) {
        stroke(overCol);
        fill(overCol);
      }
      else {
        stroke(normCol);
        fill(normCol);
      }
    }
    else {
      stroke(normCol, 120);
      fill(normCol, 120);
    }

    rectMode(CENTER);
    text(name, absX+w+10, absY);
    noFill();
    line(absX, absY, w+absX, absY);
    rect(absX+val, absY, 3, 5);
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

