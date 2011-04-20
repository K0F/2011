class Part {
  PImage mapa;
  Particle A,B;
  Spring bone;
  int id;

  float x,y;

  Part(int _id,PImage _map) {
    id = _id;
    mapa = _map;

    switch(id) {
    case 0:
      x=0;
      y = mapa.height/2;
      break;

    case 1:
      x=0;
      y=-4;
      break;
      case 2:
      x=0;
      y=55;
      break;
      case 3:
      x=0;
      y=80;
      break;
    }

    A = world.makeParticle(1,x+mapa.width/2,y,0);
    B = world.makeParticle(1,y+mapa.width/2,y+mapa.height,0);    

    bone = world.makeSpring( A, B, 5.0, 0.2, 0.0 );
  }
}

