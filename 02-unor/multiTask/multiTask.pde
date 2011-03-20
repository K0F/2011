int num = 20;
ArrayList <Node> node = new ArrayList <Node>();


void setup(){

    size(320,240,P2D);


    for(int i = 0;i<num;i++){

        node.add(new Node(this));
        Node n = node.get(i);
        n.start();
    }
    background(255);
}

void keyPressed(){
    background(255);

}


void draw(){

    stroke(0,50);


    int x = 0;
    Iterator it = node.iterator();
    while(it.hasNext()){
        Node tmp = (Node)it.next();

        x++;
        float t = tmp.getVal();
        line(map(x,0,num,0,width),tmp.cntr%height,map(x,0,num,0,width)+width/num,tmp.cntr%height);
    }



}


class Node extends Thread{

    float cntr = 0;
    PApplet parent;

    Node(PApplet _parent){
        parent = _parent;
    }


    void run(){
        while(true){

            Node tmp = (Node)node.get((int)random(node.size()));
            cntr += (tmp.cntr-cntr)/30.0;
//          cntr += random(2);
            cntr+=mouseX/10.0;
            delay(10);

        }

    }



    synchronized float getVal(){
        return cntr;
    }

}
