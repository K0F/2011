// organism form params
int chapadlaNum = 10;
int chapadlaLen = 80;
float chapadloPartLen = 5;

float smoothing1 = 4.0;
float smoothing2 = 10.0;

//show entrie neural structure
boolean showNet = true;

//resolution of a neural structure
float res = 5.0;


boolean control = false;

float blobX,blobY;

//// neural params

// rate of change
float rate = 0.1;
// jitter on synapses
float jitter = 0;
// average interconnection between neurons
int avgConnections = 2;
// change connection in net every N frame
int changeIndexRate = 10000;

float avg = 1.0;


int num;
ArrayList n;
ArrayList hand;

boolean debug = false;

int X = 0;
int Y = 0;


void setup(){
    size(400,300,P2D);
    noStroke();
    
    randomSeed(19);
    
        
    restart();
}

void draw(){
    background(0);
    noStroke();
    
    
    // learn creature new thinks
    if(control)
    cont();

    //// neural part
    // compute relations
    for(int i = 0;i< n.size();i++){
        Neuron tmp = (Neuron)n.get(i);
        tmp.compute();
    }

    // update whole state at once
    for(int i = 0;i< n.size();i++){
        Neuron tmp = (Neuron)n.get(i);
        tmp.update();
    }

    // if showNet draw network representation
    if(showNet)
    for(int i = 0;i< n.size();i++){
        Neuron tmp = (Neuron)n.get(i);
        tmp.draw();
    }   
    
    // draw entity hand by hand reacting on the structure
    for(int i = 0;i< hand.size();i++){
        Hand tmp = (Hand)hand.get(i);
        tmp.draw();
        
        //set its global position
        tmp.setXY(blobX,blobY);
    }   
    

}


