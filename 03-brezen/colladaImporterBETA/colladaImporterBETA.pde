import peasy.*;

PeasyCam cam;


ColladaLoader loader;

float SCALE = 20.0;

void setup(){
	size(320,240,P3D);

	cam = new PeasyCam(this, 100);
	cam.setMinimumDistance(50);
	cam.setMaximumDistance(500);


	loader = new ColladaLoader(this,"cube.dae");

}

void draw(){
	background(255);

	loader.draw();

	stroke(0,12);
	fill(127);



}


class ColladaLoader{
	PApplet parent;
	XMLElement rawData;
	Model model;
	String filename;



	ColladaLoader(PApplet _parent, String _filename){
		parent = _parent;
		filename=_filename;

		loadData();
	}

	void loadData(){


		rawData = new XMLElement(parent, filename);
		XMLElement geometry[] = rawData.getChildren("library_geometries/geometry/mesh/source");
		String ObjName = rawData.getChildren("library_geometries/geometry")[0].getString("name");


		for(int i = 0;i<geometry.length;i++){

			if(geometry[i].getString("id").equals(ObjName+"-Position")){


				model = new Model(ObjName,geometry[i].getChild("float_array"));
				//println(geometry[i].getString("id")+" : \n"+geometry[i].getChild("float_array").getContent()+"\n\n");

			}

		}

		//println(version.getString("version"));


	}

	void draw(){


		lights();
		model.draw();
	}




}

class Model{
	String objName;
	ArrayList <Point3D>points;

	Model(String _objName,XMLElement pointlist){

		objName = _objName;
		String raw = pointlist.getContent();


		points = new ArrayList();
		String[] coords = splitTokens(raw," ");
		for(int i = 0;i<coords.length-2;i+=3){
			float _x = parseFloat(coords[i]);
			float _y = parseFloat(coords[i+1]);
			float _z = parseFloat(coords[i+2]);
			points.add(new Point3D(_x,_y,_z));
		}


	}

	ArrayList getPoints(){
		return points;
	}

	void draw(){

		pushMatrix();
		//translate(width/2,height/2);
		scale(SCALE);
	//	beginShape(TRIANGLE_STRIP);
		for(int i = 0 ;i<points.size();i++){
			Point3D tmp1 = (Point3D)points.get(i);
			//	Point3D tmp2 = (Point3D)points.get(i-1);
			//Point3D tmp3 = (Point3D)points.get(i);

			line(tmp1.x+1/SCALE,tmp1.y,tmp1.z,tmp1.x-1/SCALE,tmp1.y,tmp1.z);
		line(tmp1.x,tmp1.y+1/SCALE,tmp1.z,tmp1.x,tmp1.y-1/SCALE,tmp1.z);
	line(tmp1.x,tmp1.y,tmp1.z+1/SCALE,tmp1.x,tmp1.y,tmp1.z-1/SCALE);
			//vertex(tmp2.x,tmp2.y,tmp2.z);
			//vertex(tmp3.x,tmp3.y,tmp3.z);

		}
		//endShape();

		popMatrix();

	}


}

class Point3D{
	float x,y,z;

	Point3D(float _x,float _y,float _z){
		x = _x;
		y = _y;
		z = _z;
	}

}
