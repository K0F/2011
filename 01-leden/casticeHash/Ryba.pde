class Castice {
  PVector pos;
  PVector acc;
  PVector vel;
  PVector lpos;
  ArrayList ohon = new ArrayList(0);





  int vyvolena = 0;

  boolean seeking = true;

  Castice() {
    //random(40,120);
    pos = new PVector(random(width),random(height));
    acc = new PVector(0,1);
    vel = new PVector(0,0);
    lpos =new PVector(pos.x,pos.y);
    vyvolena = (int)random(num);
  }

  void update() {
    pos.add(vel);
    vel.add(acc);



    for (Enumeration e = c.keys(); e.hasMoreElements();)
    {
      Castice other = (Castice)(c.get(e.nextElement()));


      //  for(int i = 0 ;i<c.size();i++) {
      //Castice other = (Castice)c.get(i);

      if(other!=this) {

        if(dist(other.pos.x,other.pos.y,pos.x,pos.y) < R ) {
          //seeking = false;
          PVector tmp = new PVector(acc.x,acc.y);
          PVector othervel = other.vel;
          PVector otherpos = other.pos;

          PVector mezi = new PVector(otherpos.x,otherpos.y);
          mezi.sub(pos);
          tmp.add(mezi);


          PVector crss = tmp.cross(othervel);
          tmp.add(crss);

          //crss = tmp.cross(otheracc);
          // tmp.add(crss);

          acc.add(tmp);
          acc.normalize();
        }
      }
    }


    acc.mult(dens);
    vel.limit(maxSpeed);
  }

  void track() {

    if(ohon.size()<len) {
      ohon.add(new PVector(pos.x,pos.y));
    }
    else {
      ohon.remove(0);
      ohon.add(new PVector(lpos.x,lpos.y));
    }

    for(int i = 1;i<ohon.size();i++) {
      PVector curr = (PVector)ohon.get(i);
      PVector last = (PVector)ohon.get(i-1);
      if(dist(curr.x,curr.y,last.x,last.y)<width/2) {
        stroke(lerpColor(#FFCC00,#FFFFFF,norm(i,0,len)),map(i,0,len,10,90));
        strokeWeight(map(i,0,len,1,3));
        line(curr.x,curr.y,last.x,last.y);
      }
    }
  }

  void draw() {

    update();
    //border();
    prubeh();

    pnt();
    track();
    lpos =new PVector(pos.x,pos.y);

    //sipka(acc,color(#FFCC00));
    // sipka(vel,color(#FF0000));
  }


  void border() {
    if(pos.x>width) {
      pos.x=width;
      vel.x*=-1;
    }
    if(pos.x<0) {
      pos.x=0;
      vel.x*=-1;
    } 

    if(pos.y>height) {
      pos.y=height;
      vel.y*=-1;
    }
    if(pos.y<0) {
      pos.y=0;
      vel.y*=-1;
    }
  }

  void prubeh() {
    if(pos.x>width) {
      pos.x=0;
      lpos =new PVector(pos.x,pos.y);
    }
    if(pos.x<0) {
      pos.x=width;
      lpos =new PVector(pos.x,pos.y);
    } 

    if(pos.y>height) {
      pos.y=0;
      lpos =new PVector(pos.x,pos.y);
    }
    if(pos.y<0) {
      pos.y=height;
      lpos =new PVector(pos.x,pos.y);
    }
  }



  void pnt() {
    stroke(255,240);
    line(pos.x,pos.y,lpos.x,lpos.y);
  }

  void sipka(PVector vec,color c) {
    pushStyle();
    pushMatrix();
    stroke(c,100);
    translate(pos.x,pos.y);
    strokeWeight(2);
    PVector n = new PVector(vec.x,vec.y);
    n.normalize();
    n.mult(20);
    line(0,0,n.x,n.y);
    stroke(c,200);
    strokeWeight(3);
    line(vec.x,vec.y,lerp(0,vec.x,0.9),lerp(0,vec.y,0.9));
    popMatrix();
    popStyle();
  }
}

