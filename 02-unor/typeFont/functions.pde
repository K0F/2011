float arrived() {
  float arrived = 0;
  if(coords != null) {
    for(int i = 0; i < seekers.size(); i++) {
      Boid seeker = (Boid) seekers.get(i);
      if(seeker.arrived == true) {
        arrived++;
      }
    }
    return (arrived/coords.size())*100;
  }
  else {
    return 0;
  }
}
 
void checkSeekerCount(int count) {
  if(count > 1) {
    if((seekers.size() < count) && (!pauze)) {
      for(int y = 0; y < 150; y++) {
        int px = (int) random(width);
        int py = (int) random(height);
        int c = color(19, 134, 214);
        newSeeker(px,py,c);
      }
    }
    if((seekers.size() > count)) {
      for(int z = 0; z < (seekers.size() - count); z++) {
        seekers.remove(seekers.size()-1);
      }
    }
    if(pauze && seekers.size() > 150) {
      for(int z = 0; z < 150; z++) {
        seekers.remove(0);
      }
    }
/* if(pauze && seekers.size() > 15) {
      for(int z = 0; z < 15; z++) {
        seekers.remove(0);
      }
    }*/
    else if(pauze && seekers.size() > 0) {
      //if((frameCount % 2) == 0) {
        seekers.remove(0);
      //}
    }
  }
}
 
void newSeeker(float x, float y, int c) {
  float maxspeed = random(13,20);
  float maxforce = random(0.5, 1000.6);
  seekers.add(new Boid(new PVector(x,y),maxspeed,maxforce,c,false));
}
 
void update(int count, RPoint[] pnts, int baseR) {
  for ( int i = 0; i < count; i++ )
  {
    float mx = (pnts[i].x)+width/2;
    float my = (pnts[i].y)+height/2;
 
    if(newtext) {
      coords.add(new Point(mx, my, false));
    }
 
    if((i < seekers.size()) && (i < coords.size())) {
      Boid seeker = (Boid) seekers.get(i);
      Point coord = (Point) coords.get(i);
      if(!pauze) {
        seeker.arrive(new PVector(coord.x,coord.y));
        seeker.update();
      }
      if((seeker.loc.x >= 0) && (seeker.loc.x < width-1) && (seeker.loc.y >= 0) && (seeker.loc.y < height-1)) {
        int currC = currFrame[(int)seeker.loc.x + ((int)seeker.loc.y)*width];
        currFrame[(int)seeker.loc.x + ((int)seeker.loc.y)*width] = blendColor(seeker.c, currC, ADD);
      }
 
      if(((seeker.loc.x > mx-1) && (seeker.loc.x < mx+1)) && ((seeker.loc.y > my-1) && (seeker.loc.y < my+1)) && (coord.arrived == false)) {
        seeker.arrived = true;
      }
      else {
        seeker.arrived = false;
      }
    }
  }
}
 
void keyPressed () {
  if(auto == false) {
    if (  keyCode == DELETE || keyCode == BACKSPACE ) {
      if ( inp.length() > 0 ) {
        inp = inp.substring(0,inp.length()-1);
      }
    }
    else if (key != CODED) {
      inp = inp + key;
    }
  }
}
 
void mouseReleased() {
  //skip word
  pauze =! pauze;
}

