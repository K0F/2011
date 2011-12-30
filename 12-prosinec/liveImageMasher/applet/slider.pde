
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


  Slider(Controller _parent, String _name, float _x, float _y, float _minval, float _maxval,float _def) {
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
      constrain(map(mouseX, absX, w+absX, minval, maxval),maxval,minval):
      constrain(map(mouseX, absX, w+absX, minval, maxval),minval,maxval);
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
    rect(map(val,minval,maxval,absX,absX+w), absY, 3, 5);
    

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

