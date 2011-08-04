float x;
float y;

float anim = 0;
int frame = 0;

void setup(){
    size(1280,720);

    smooth();


    noiseSeed(123);

    x = width/2;
    y = height/2;

    background(255);
}


void draw(){

    frame=0;

    save("/desk/anim/weird"+nf((int)anim,5)+".png");
    anim++;

    background(255);


    for(int i = 0 ;i<3000;i++){


        x = noise((frame+anim)/30.0)*width+noise(anim*frame);
        y = noise((frame+anim)/15.0)*height+noise(anim*frame);

        ellipse(x,y,x-width/2,x-width/2);
        frame++;
    }
}
