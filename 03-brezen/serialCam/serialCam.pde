import codeanticode.gsvideo.*;

// The serial port:
GSCapture cam;


void setup(){
    size(320,240,P2D);
    //String[] cameras = GSCapture.list();
    //println(cameras);
    cam = new GSCapture(this, 640, 480, "/dev/video2");
    frameRate(30); 
}

void draw(){
    //image(cam,0,0,width,height);
    if (cam.available() == true) {
        cam.read();
        image(cam, 0, 0,width,height);
        // The following does the same, and is faster when just drawing the image
        // without any additional resizing, transformations, or tint.
        //set(0, 0, cam);
    }
}
