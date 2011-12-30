import java.lang.reflect.*;

boolean mousedown = false;


class GUI {

  ///////////////////////////////////
  ///////////////////////////////////
  
  String DEFAULT_NAMES[] = {
    "R",
    "G",
    "B",
    "alpha",
    "blink_speed",
    "shake_speed",
    "amplitude", 
    "effect_smooth",
    "x", 
    "y",
    
  };

  ///////////////////////////////////
  float defaults[] = {
   255,
   255,
   255,
   100.,
   3.0,
   40.,
   20.,
   
   1.4,
   width/2-215,
   25,
   
  };
  ///////////////////////////////////
  
  float mins[] = {
    0,
    0,
    0,
    0.1,
    300,
    300,
    1,
    0.8,
     0,
    height,
   
  };
  
  ///////////////////////////////////
  
  float maxs[] = {
    255,
    255,
    255,
    255,
   
    1,
    1,
    100,
    1.8,
     width,
    -300,
   
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

