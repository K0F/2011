/**
 *   The Engine class scheduling new Threads
 *   for pre-redering image layers
 */


class TheEngine {

  ArrayList unit;
  ArrayList names;
  GUI gui;

  Thread thread; 


  int[] layoutX = {
    20, 420
  };
  int[] layoutY = {
    height-130, height-130
  };

  TheEngine() {
    unit = new ArrayList();
    gui = new GUI(this);
  }

  void addImage(PImage _src) {
    unit.add(new ImageMasher(unit.size(), _src));
    gui.addController(unit.size()-1);
    thread = new Thread((ImageMasher)unit.get(unit.size()-1));
    thread.start();
  }

  void addImage(String _name) {

    unit.add(new ImageMasher(unit.size(), _name));
    gui.addController(unit.size()-1);
    thread = new Thread((ImageMasher)unit.get(unit.size()-1));
    thread.start();
  }

  ImageMasher getUnit(int _which) {
    return (ImageMasher)unit.get(_which);
  }

  void draw() {

    for (int i = 0 ; i < unit.size(); i++) {
      ImageMasher one = (ImageMasher)unit.get(i);

      if (one.ready)
        one.draw();
    }

    gui.draw();
  }
}

