import processing.pdf.*;

void setup() {
    size(400, 400);
    noLoop();
    beginRecord(PDF, "filename.pdf"); 
    stroke(0,50);
}

void draw() {
    // Draw something good here
    
    for(int i = 0;i<500;i++){
    line(random(width), noise(i/30.0)*height, width-noise(i/20.0)*40, height);
    }
    endRecord();
    exit();
}
