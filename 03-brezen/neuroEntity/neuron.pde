
class Neuron{
    int id;
    float val;
    float sum;
    ArrayList inputs = new ArrayList();
    ArrayList weights = new ArrayList();
    int x,y;
    float dir = 1.0;
    float innerRate;

    Neuron(int _id,int _ins){

        id = _id;
        val = random(200.0)/100.0;
        innerRate = rate+(random(-40,40));


        for(int i = 0 ; i < _ins;i++){
            int cal = (int)(random(num));
            if(cal==id){
                cal += 1;
                cal = cal%num;
            }
            inputs.add(cal);
            weights.add((float)(random(200.0)/100.0));
        }

        if(debug)
            debugAssoc();
        
        x = X;
        y = Y;//(int)(noise(id*2.0)*height);

        shiftXY();
    }
    
    void shiftIndex(){
      for(int i = 0 ; i < inputs.size();i++){
        inputs.set(i,((Integer)inputs.get(i)+1)%num); 
      }
      
    }

    void shiftXY(){
        X+=res;
        if(X>width){
            X=0;
            Y+=res;
        }
    }

    void debugAssoc(){
        println(id+" ----------------V");
        for(int i = 0;i<inputs.size();i++){
            int tmp = (Integer)inputs.get(i);
            float w = (Float)weights.get(i);
            println("    "+tmp + " -> "+ w);
        }

    }

    void moveVal(){      
        val += random(-jitter,jitter)/100.0;
        avg += (val-avg)/(num+0.0);
    }

    void compute(){
        moveVal();
        
        if(frameCount%changeIndexRate==0)
        shiftIndex();
        
        sum = 0;
        int cnt = 0;
        for(int i = 0;i<inputs.size();i++){
            int index = (Integer)inputs.get(i);
            Neuron tmp = (Neuron)n.get(index);
            float w = (Float)weights.get(i);
            sum += tmp.val*w*(2.0-avg);
            cnt++;  
        }

        sum = sum/cnt;

    }

    void update(){
        val += (sum - val) * rate;
        //cycleVal();
    }

    void cycleVal(){
        if(val < 0.0 || val > 2.0){
            //dir*=-1;
            val = 1;
        }
    }

    void draw(){
        fill(dist(blobX,blobY,x,y)/3.0-50*val);
        rect(x,y,res,res);
    }
}

