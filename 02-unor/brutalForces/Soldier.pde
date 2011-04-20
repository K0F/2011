
class Soldier {
  ArrayList parts = new ArrayList(0);

  Soldier() {
    parts.add(new Part(parts.size(),loadTransparent("trunk.gif")));
    parts.add(new Part(parts.size(),loadTransparent("head.gif")));
    parts.add(new Part(parts.size(),loadTransparent("leg1.gif")));
    parts.add(new Part(parts.size(),loadTransparent("leg2.gif")));
    parts.add(new Part(parts.size(),loadTransparent("arm1.gif")));
    parts.add(new Part(parts.size(),loadTransparent("arm2.gif")));
    
  }

  void draw() {

    for(int i = 0 ;i<parts.size();i++) {

      Part part = (Part)parts.get(i);
      image(part.mapa, part.x,part.y);
    }
  }


  PImage loadTransparent(String name) {
    PImage tmp = loadImage(name);
    PImage result = createImage(tmp.width,tmp.height,ARGB);

    tmp.loadPixels();
    result.loadPixels();

    for(int i = 0;i<tmp.pixels.length;i++) {

      if(tmp.pixels[i]==-65321)continue;

      result.pixels[i] = tmp.pixels[i];
    }

    return result;
  }
}

