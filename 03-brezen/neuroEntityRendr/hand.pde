class Hand {
  ArrayList bones;
  float x,y;
  int id;

  Hand(int _id,int num,float _x,float _y) {
    id = _id;
    bones = new ArrayList();
    for(int i = 0;i<num;i++) {
      //Bone prev = i==0?null:(Bone)bones.get(i-1);
      bones.add( new Bone ( this, i, chapadloPartLen,map(i,0,num,10,2) ));
    }

    x = _x;
    y = _y;
  }

  void setXY(float _x,float _y) {
    x = _x;
    y = _y;
  }

  void draw() {
    pushMatrix();
    translate(x,y);
    //rotate(radians(-90));
    for(int i =0;i<bones.size();i++) {
      Bone tmp = (Bone)bones.get(i);
      
      fill(0,40);
      if(id == 0)
      fill(#ff1111,map(i,0,bones.size(),0,120));
       else
      fill(255,map(i,0,bones.size(),0,120));
      
      tmp.draw();
      tmp.move();
    }
    popMatrix();
    /* 
     stroke(#ffcc00,10);
     for(int i =0;i<bones.size();i++) {
     Bone tmp = (Bone)bones.get(i);
     
     for(int q = 0;q<8;q++)
     line(x,y,tmp.controllers[q].x,tmp.controllers[q].y+10*i);
     
     
     } 
     noStroke();*/
  }
}

class Bone {
  Hand parent;
  float len,thickness,angle;
  int id;
  Neuron[] controllers;

  Bone(Hand _parent,int _id,float _len,float _t) {
    parent = _parent;
    id = _id;
    controllers = new Neuron[8];


    for(int i = 0;i<controllers.length;i++) {
      controllers[i] = (Neuron)n.get((int)random(n.size()));
    }


    len = _len;
    thickness = _t;
    angle = 0;
  }

  void draw() {
    angle += (parseNeurons()-angle)/smoothing2;
    rotate(radians(angle));
    
    if(cones)
    {
    pushStyle();
    if(id == chapadlaLen-1){
    fill(#CCFF11,5);
    for(int i = 50 ;i<70;i+=2)
      triangle(0,0,100+i,i,100+i,-i); 
    }
    popStyle();
    }
    pushStyle();
    fill(0,map(id,0,len,0,255));
    
    rect(0,-thickness,len,thickness*2);
    for(int i = 2;i<14;i+=2){
    fill(0,20);
    rect(0,-thickness-i/2,len,thickness*2+i);
    }
    popStyle();
    
    rect(0,-thickness/2.0,len,thickness);
    
    translate(len,0);

    
  }

  void move() {
    if(id == len-1) {
      float posx = screenX(0,0);
      float posy = screenY(0,0);

      if(posx > width || posx < 0)
      blobX -= (posx-blobX)/2.0;//(dist(posx,posy,blobX,blobY));
      
      if(posy > height || posy < 0)
      blobY -= (posy-blobY)/2.0;//(dist(posx,posy,blobX,blobY));
    }
  }

  float parseNeurons() {
    String s = "";
    for(int i = 0;i<8;i++) {
      s += controllers[i].val>avg?"1":"0";
    }

    float val = (unbinary(s)-127)/smoothing1;
    return val;
  }
  
  void writeNeurons(){
    if(id==0){
    angle = degrees(atan2(mouseY-width/2,mouseX-height/2));
   String binar = binary((int)angle,8);
   for(int i =0;i<controllers.length;i++){    
     controllers[i].val = binar.charAt(i)=='1'? 2 : 0; 
   }
    }else{
     String binar = binary(127,8);
    for(int i =0;i<controllers.length;i++){    
     controllers[i].val = binar.charAt(i)=='1'? 2 : 0; 
   }
    }
  }
}

