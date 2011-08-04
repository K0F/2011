ArrayList values;

void setup(){
    size(320,240,P2D);

    values = new ArrayList(0);

    randomSeed(19);

    loadPixels();

    for(int i = 0;i<width*height;i++){
        pixels[i] = color(random(0,255));
    }

    //loadPixels();
}

void draw(){

    int radius = 3;

    loadPixels();

    for( int i =0 ; i<pixels.length ; i++){

        int X = i%width;
        int Y = i/width;


        float avg = 0;
        int cntr = 0;


        for(int x = X-radius ;x < X+radius ;x++){
            for(int y = Y-radius;y < Y+radius;y++){

                if(x<0)x=x+width;
                if(x>width)x=x-width;
                if(y<0)y=y+height;
                if(y>width)y=y-height;

                avg += brightness(pixels[y*width+x]);
                cntr ++;
                //pixels[i] = 0;//lerpColor(pixels[y*width+x],pixels[i],0.5);
            }
        }

        avg /= (cntr + 0.0);

        if(i == 255){
            println(avg);
        }
    }

    updatePixels();
}

