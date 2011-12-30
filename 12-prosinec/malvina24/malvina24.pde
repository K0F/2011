////////////////////////////////////////////////

import saito.objloader.*;
OBJModel model;
//OBJModel tmpmodel;

float rotX;
float rotY;

////////////////////////////////////////////////

void setup()
{
  size(600, 600, P3D);
  frameRate(30);
  model = new OBJModel(this);
 // tmpmodel = new OBJModel(this);
  model.enableDebug();
  model.load("skull.obj");
 // tmpmodel.load("skull.obj");
  stroke(255);
 // smooth();
}

/////////////////////////////////////////////////

void draw()
{
  background(0);
  lights();
  pushMatrix();
  translate(width/2, height/2+450, 0);
  rotateX(rotY);
  rotateY(rotX+=0.02);
  scale(25.0);


  noStroke();
  // renders the temporary model
  //tmpmodel.draw();
  
  for (int j = 0; j < model.getSegmentCount(); j++) {

        Segment segment = model.getSegment(j);
        Face[] faces = segment.getFaces();
  
    beginShape(TRIANGLES);

       

        for(int i = 0; i < faces.length; i ++)
        {
            PVector[] v = faces[i].getVertices();
            PVector n = faces[i].getNormal();
            
            float nor = 0.0;//abs(sin(radians((frameCount+i))) * 0.1);
            fill(noise( (i+frameCount)/30.0 ) * 255);


            for (int k = 0; k < v.length; k++) {
                
                vertex(v[k].x + (n.x*nor), v[k].y + (n.y*nor), v[k].z + (n.z*nor));
            }
        }

       
        endShape();
        
  }

  popMatrix();
}


