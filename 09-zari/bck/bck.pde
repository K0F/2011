/*
* Gif anim -> use gimp to load as layers and save as gif animation
* by kof 2011
*/

int num = 100;

PVector pos[];
PVector smer[];
color col[];

int x[] = {0,-1,1,0};
int y[] = {-1,0,0,1};
int sp[] = {1,2,4};

void setup(){
    size(128,128);

    pos = new PVector[num];
    smer = new PVector[num];
    col = new color[num];

    for(int i = 0 ; i < pos.length;i++){
        pos[i] = new PVector((int)random(width),(int)random(height));
        int sm = (int)random(x.length);
        int mod = (int)random(sp.length);
        smer[i] = new PVector(x[sm]*sp[mod],y[sm]*sp[mod]);
        col[i] = color(random(170,250));
    }
}


void draw(){
    background(255);

    
    
    for(int i = 0;i<pos.length;i++){
        stroke(col[i]);
        point(pos[i].x,pos[i].y);
        
        pos[i].add(smer[i]);
        
        border(i);
        
        
    }

saveFrame("/desk/bck/fr####.png");

    if(frameCount==height-1){
        exit();
    }


}

void border(int id){
  if(pos[id].x>width)pos[id].x=0;
  if(pos[id].x<0)pos[id].x=width;
 
 
  if(pos[id].y>height)pos[id].y=0;
  if(pos[id].y<0)pos[id].y=height; 
}
