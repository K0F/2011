import traer.physics.*;

Soldier s;
ParticleSystem world;

float gravity = 1.0;
float drag = 1.0;

void setup(){
  size(320,240);
  world = new ParticleSystem( gravity, drag );
  
s = new Soldier();  
}

void draw(){
 background(255);

translate(width/2,height/2);
s.draw(); 
  
}


