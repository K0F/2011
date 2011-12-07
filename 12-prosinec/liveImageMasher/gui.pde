import java.lang.reflect.*;

boolean mousedown = false;


class GUI {

  ///////////////////////////////////
  ///////////////////////////////////
  
  String DEFAULT_NAMES[] = {
    "x", 
    "y",
    "R",
    "G",
    "B",
    "blink_speed",
    "shake_speed",
    "amplitude", 
    "alpha",
    "effect_smooth"
  };

  ///////////////////////////////////
  float defaults[] = {
   width/2-215,
   25,
   255,
   255,
   255,
   30.0+random(-1,1),
   40.+random(-1,1),
   20.+random(-1,1),
   120.,
   1.4
  };
  ///////////////////////////////////
  
  float mins[] = {
    0,
    height,
    0,
    0,
    0,
    300,
    300,
    1,
    1,
    0.8
  };
  
  ///////////////////////////////////
  
  float maxs[] = {
    width,
    -300,
    255,
    255,
    255,
    1,
    1,
    100,
    255,
    1.8
  };
  
  
  ///////////////////////////////////
  ///////////////////////////////////
  
  String BLEND_NAMES [] = {
    "BLEND",
    "ADD",
    "SUBTRACT",
    "DARKEST",
    "LIGHTEST",
    "DIFFERENCE",
    "EXCLUSION",
    "MULTIPLY",
    "SCREEN",
    "OVERLAY",
    "HARD_LIGHT",
    "SOFT_LIGHT",
    "DODGE",
    "BURN"
  };

  int rozpal = 12;

  ArrayList controllers;
  TheEngine parent;

  GUI(TheEngine _parent) {
    parent = _parent;
    noSmooth();
    textFont(loadFont("SempliceRegular.vlw"));
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

