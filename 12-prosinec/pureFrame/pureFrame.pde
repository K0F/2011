int w,h,i=0;void setup(){
	size(w=1600,h=900,P2D);
	background(0);
}
void draw(){
	background(255);
	line(i,0,i++,height);
	i=i>w?0:i;
}
