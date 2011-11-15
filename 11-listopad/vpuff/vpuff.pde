
volpuff puff;

boolean damage = false;

void setup(){

	size(320,240);
	loadPixels();
	puff = new volpuff();
	puff.freshStart();
}


void draw(){
	puff.setPix(frameCount);
}


void mousePressed(){
	puff.mouseDown(mouseX,mouseY);

}

void mouseDragged(){
	puff.mouseDrag(mouseX,mouseY);

}

void mouseReleased(){
	puff.mouseUp(mouseX,mouseY);
}


public class VolumeApplet{
	public double light[] = {1,1,1}, hilite[] = {.5,.5,1};
	double T[][], M[][], D[][];
	double X, Y, Z, R, C = 1, S = 0;
	double xx, yy, zz;
	double normal[] = new double[3];
	double rgb[] = new double[3];
	double zRate = 1;
	int skip = 1;
	int animationFrame = 0;

	public void setBg(double r, double g, double b) {
		bg[0] = r; bg[1] = g; bg[2] = b;
	}
	public void setAmbient(double r, double g, double b) {
		ambient[0] = r; ambient[1] = g; ambient[2] = b;
	}
	public void setDiffuse(double r, double g, double b) {
		diffuse[0] = r; diffuse[1] = g; diffuse[2] = b;
	}
	public void setSpecular(double r, double g, double b, double p) {
		specular[0] = r; specular[1] = g; specular[2] = b;
		power = p;
	}

	public void initialize() { }
	public void restart() { }
	public void animate(int f) { }
	public double density(double x, double y, double z) { return 0; }

	void lighting(double normal[], double rgb[]) {
		double t = Math.max(0, .5 + .3 * (normal[0] + normal[1] + normal[2]));
		double s = Math.pow(t, power);
		rgb[0] = t * diffuse[0] + s * specular[0];
		rgb[1] = t * diffuse[1] + s * specular[1];
		rgb[2] = t * diffuse[2] + s * specular[2];
	}

	VolumeApplet() {
		
		D = new double[width][height];
		M = new double[width][height];
		T = new double[width][height];
		R = width/2;

		initialize();
		setToBackground();
	}

	void setToBackground() {
		background(f2i(bg[0]),f2i(bg[1]),f2i(bg[2]));
	}

	void freshStart() {
		frame0 = frame;
		initialize();
		setToBackground();
		restart();
		clearRender = true;
	}

	int frame, frame0 = 0;
	public void setPix(int frame) {
		this.frame = frame;
		if (skip == 3 && frame-frame0 == width/skip) {
			skip = 1;
			specular[0] *= .5;
			specular[1] *= .5;
			specular[2] *= .5;
			frame0 = frame;
			restart();
			clearRender = true;
		}
		if (frame-frame0 == width/skip) {
			outputImage();
			animate(animationFrame++);
			freshStart();
		}

		if (clearRender) {
			for (int x = 0 ; x < width ; x++)
				for (int y = 0 ; y < height ; y++) {
					D[x][y] = 0;
					M[x][y] = 1;
					T[x][y] = 1;
				}
			clearRender = false;
		}

		damage = true;
		for (int x = skip ; x < width ; x += skip)
			for (int y = skip ; y < height ; y += skip) {

				M[x-skip][y-skip] = M[x][y];

				if (isSlice) {
					D[x][y] = 0;
					M[x][y] = 1; // SHADOW MASKING
					T[x][y] = 1; // REMAINING FRONT-TO-BACK TRANSPARENCY
					Z = sliceZ;
				}
				else {
					if (T[x][y] < .01)
						continue;
					Z = (R - skip*zRate*(frame-frame0)) / R;
				}

				X =  (x - R) / R;
				Y =  (y - R) / R;

				double p = 1 + .2*Z;
				X /= p;
				Y /= p;

				xx = X;
				//yy =  Y*C+Z*S;
				//zz = -Y*S+Z*C;
				yy = Y;
				zz = Z;

				double d = Math.max(0, Math.min(.99,
							skip*zRate * density(xx, yy, zz)));

				if (d == .99)
					D[x][y] = 1;
				else if (d > .01 && d < .99) {
					if (isSlice) {
						int c = (int)(255 * d);
						pixels[xy2i(x,height-y)] = pack(c,c,c);
						continue;
					}

					double dx = D[x-skip][y];
					double dy = D[x][y-skip];
					double dz = D[x][y];
					if (isSlice)
						dz = 1;

					if (dx > 0 && dx < 1 && dy > 0 && dy < 1 && dz > 0 && dz < 1) {

						double transparency = Math.pow(2.71828, -d);
						double contrib = T[x][y] * (1 - transparency);

						double red = ambient[0];
						double grn = ambient[1];
						double blu = ambient[2];

						if (M[x][y] >= .01) {
							normal[0] = dx - d;
							normal[1] = dy - d;
							normal[2] = d - dz;
							if (normal[0]!=0 && normal[1]!=0 && normal[2]!=0)
								normalize(normal);
							lighting(normal, rgb);
							red += M[x][y] * rgb[0];
							grn += M[x][y] * rgb[1];
							blu += M[x][y] * rgb[2];
						}

						int i = xy2i(x,height-y);
						int rgb = pack(f2i(lerp(contrib, i2f(unpack(pixels[i],0)), red)),
								f2i(lerp(contrib, i2f(unpack(pixels[i],1)), grn)),
								f2i(lerp(contrib, i2f(unpack(pixels[i],2)), blu)));
						pixels[i] = rgb;
						if (skip > 1)
							for (int I = 0 ; I < skip ; I++)
								for (int J = 0 ; J < skip ; J++)
									pixels[i + width*I + J] = rgb;

						T[x][y] *= transparency;
						M[x-skip][y-skip] *= transparency;
					}
					D[x][y] = d;
				}
			}
		blur(M);
	}

	double tmpX[], tmpY[];

	void blur(double M[][]) {

		if (tmpY == null)
			tmpY = new double[height];
		for (int x = 0 ; x < width ; x++) {
			for (int y = 1 ; y < height-1 ; y++)
				tmpY[y] = M[x][y-1]/6 + 2*M[x][y]/3 + M[x][y+1]/6;
			for (int y = 1 ; y < height-1 ; y++)
				M[x][y] = tmpY[y];
		}

		if (tmpX == null)
			tmpX = new double[width];
		for (int y = 0 ; y < height ; y++) {
			for (int x = 1 ; x < width-1 ; x++)
				tmpX[x] = M[x-1][y]/6 + 2*M[x][y]/3 + M[x+1][y]/6;
			for (int x = 1 ; x < width-1 ; x++)
				M[x][y] = tmpX[x];
		}
	}

	void normalize(double v[]) {
		double t = Math.sqrt(dot(v,v));
		v[0] /= t;
		v[1] /= t;
		v[2] /= t;
	}

	//////////////// MATH PRIMITIVES //////////////////////////

	double dot(double a[], double b[]) { return a[0]*b[0]+a[1]*b[1]+a[2]*b[2]; }
	double scurve(double t) { return t < 0 ? 0 : t > 1 ? 1 : t*t*(3-t-t); }
	double lerp(double t,double a,double b) { return a + t * (b - a); }
	double i2f(int i) { return i / 255.; }
	int f2i(double f) { return Math.max(0,Math.min(255,(int)(255 * f))); }
	double boundary(double t) { return 10 * scurve(t); }
	double clip(double lo,double hi,double t) {
		return Math.max(lo, Math.min(hi, t));
	}
	 final double LOG_HALF = Math.log(0.5);
	 double gain(double a, double b) {
		double p;

		if (a<.001)
			return 0.;
		else if (a>.999)
			return 1;

		b = (b<.001) ? .0001 : (b>.999) ? .999 : b;
		p = Math.log(1. - b) / LOG_HALF;
		if (a < 0.5)
			return Math.pow(2 * a, p) / 2;
		else
			return 1. - Math.pow(2 * (1. - a), p) / 2;
	}
	 double bias(double a, double b) {
		if (a < .001)
			return 0.;
		else if (a > .999)
			return 1.;
		else if (b < .001)
			return 0.;
		else if (b > .999)
			return 1.;
		else
			return Math.pow(a, Math.log(b) / LOG_HALF);
	}

	//////////////// COLORS //////////////////////////

	private double ambient[] = {.2,.2,.2};
	private double diffuse[] = {.8,.8,.8};
	private double specular[] = {0,0,0}, power = 2;
	private double bg[] = {.5,.5,.8};
	public  double fg[] = {1,1,1};

	//////////////// GEOMETRIC PRIMITIVES //////////////////////////

	public double ball(double cx, double cy, double cz, double r) {
		double x = xx - cx, y = yy - cy, z = zz - cz;
		double xyz = x*x + y*y + z*z;
		return transition(.04 * R * (r*r - xyz) / r);
	}
	public double superquadric(double cx, double cy, double cz, double r, double p) {
		double x = Math.abs(xx - cx), y = Math.abs(yy - cy), z = Math.abs(zz - cz);
		if (x > r || y > r || z > r)
			return 0;
		double xyz = Math.pow(x,p) + Math.pow(y,p) + Math.pow(z,p);
		double rr = Math.pow(r,p);
		return transition(.1 * R * (rr - xyz) / (p * rr/r));
	}
	public double transition(double t) {
		return clip(0,1,t);
	}

	///////////////// USER INTERACTION FUNCTIONS //////////////////////

	boolean clearRender = true;
	boolean isSlice = false;
	double sliceZ = 0.0;
	double theta = 0;
	int mx = 0;

	
	public boolean mouseDown(int x, int y) {
		mx = x;
		return true;
	}


	public boolean mouseDrag(int x, int y) {
		if (isSlice) {
			sliceZ = 2. * y / height - 1;
			clearRender = true;
		}
		theta += (double)(x - mx) / width;
		mx = x;
		return true;
	}
	
	public boolean mouseUp(int x, int y) {
		if (isSlice) {
			sliceZ = 2. * y / height - 1;
			clearRender = true;
		}
		else {
			System.out.println(theta);
			C = Math.cos(theta);
			S = Math.sin(theta);
			freshStart();
		}
		return true;
	}


	void outputImage() {
		System.out.println(animationFrame + " " + width + " " + height);
		int i = 0;
		for (int y = 0 ; y < height ; y++)
			for (int x = 0 ; x < width ; x++) {
				System.out.print(int2hex(pixels[i++]));
				if (i % 10 == 0)
					System.out.println();
			}
		System.out.println();
	}
	String int2hex(int n) {
		return i2h(n >> 16) + i2h(n >> 8) + i2h(n);
	}
	String i2h(int n) {
		n &= 255;
		return nibble(n >> 4) + nibble(n);
	}
	String nibble(int n) {
		n &= 15;
		return "" + (char)(n < 10 ? '0' + n : 'a' + (n-10));
	}

	void inputImage() {
	}
}



class volpuff extends VolumeApplet
{
	Random R = new Random(0);
	int blur = 20, mode = 0;
	double P[][];
	double freq = 6.;

	boolean isAddingNoise = false;
	public void setAddingNoise(boolean tf) {
		isAddingNoise = tf;
		freshStart();
	}

	// THINGS TO INITIALIZE WHEN STARTING THE APPLET

	//public void initialize() {
	volpuff(){
		super.initialize();
		setSpecular(.5,.7,.7,.01);
		setAmbient(.5,0,0);

		// CREATE CLOUD OF PARTICLES

		P = new double[200][3];
		for (int i = 0 ; i < P.length ; i++) {
			double rr = 10;
			do {
				double z = (1 - 2. * i / P.length);
				P[i][2] = z;
				double r = Math.sqrt(1 - z*z);
				P[i][0] = r * (2 * (R.nextDouble() % 1) - 1);
				P[i][1] = r * (2 * (R.nextDouble() % 1) - 1) / 1.414;
				rr = P[i][0]*P[i][0] + 2*P[i][1]*P[i][1] + P[i][2]*P[i][2];
			} while (rr > 1.01);
		}

		C = 1;
		S = 0;
	}

	double r = .3, rxr = r*r;
	int i0 = 0;

	public void restart() {
		i0 = 0;
	}

	public double density(double x, double y, double z) {

		x /= .7;
		y /= .7;
		z /= .7;

		for ( ; i0 < P.length ; i0++)
			if (P[i0][2] < z+r)
				break;

		double d = 0;
		for (int i = i0 ; i < P.length && P[i][2] > z-r ; i++) {
			double pu = P[i][0], py = P[i][1], pv = P[i][2];
			double px = C * pu - S * pv;
			double pz = S * pu + C * pv;
			px -= x; py -= y; pz -= z;
			double rr = (px*px + py*py + pz*pz) / rxr;
			if (rr < 1)
				d += .5 + .5 * Math.cos(Math.PI * Math.sqrt(rr));
		}
		if (d > 0) {
			if (isAddingNoise)
				d += 4 * addNoise(x, y, z);
			d = Math.max(.01, Math.min(.99, d));
			d = .1 * filter(d);
		}
		return d;
	}

	double rot = Math.PI/3, c = Math.cos(rot), s = Math.sin(rot);
	double addNoise(double x, double y, double z) {
		double u, v;
		x += 100;
		double d = 0;
		d += abn(1, x,y,z); u = x; v = y; x = c*u-s*v; y = s*u+c*v;
		d += abn(2, x,y,z); u = x; v = y; x = c*u-s*v; y = s*u+c*v;
		d += abn(4, x,y,z);
		return 1.2 * d / freq;
	}
	double abn(double f, double x, double y, double z) {
		double freq = this.freq * f;
		return (Math.abs(noise( (float)(freq*x) , (float)(freq*y),(float)(freq*z)) )-.5)/f;
	}

	double filter(double t) {
		t = bias(t, .67);
		if (t < .5)
			t = gain(t, .86);
		t = bias(t, .35);
		return t;
	}
}


public int xy2i(int x, int y) { return y * width + x; }

    // PACK RGB VALUES INTO AN IMAGE PIXEL

    public int pack(int rgb[]) { return pack(rgb[0],rgb[1],rgb[2]); }

    public int pack(int r, int g, int b) {
       return ((r&255)<<16) | ((g&255)<< 8) | ((b&255)) | 0xff000000;
    }

    // UNPACK RGB VALUES FROM AN IMAGE PIXEL

    public int unpack(int packed, int i) { return packed >> 16-8*i & 255; }

    public void unpack(int rgb[], int packed) {
       rgb[0] = (packed >> 16) & 255;
       rgb[1] = (packed >>  8) & 255;
       rgb[2] = (packed      ) & 255;
   }
