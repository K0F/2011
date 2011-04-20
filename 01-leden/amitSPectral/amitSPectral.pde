// fft utils for amit
// based on nullsoft VMS and stephan sprenger's FFT paper

class FFTutils {
  int WINDOW_SIZE,WS2;
  int BIT_LEN;
  int[] _bitrevtable;
  float _normF;
  float[] _equalize;
  float[] _envelope;
  float[] _fft_result;
  float[][] _fftBuffer;
  float[] _cosLUT,_sinLUT;
  float[] _FIRCoeffs;
  boolean _isEqualized, _hasEnvelope;

  public FFTutils(int windowSize) {
    WINDOW_SIZE=WS2=windowSize;
    WS2>>=1;
    BIT_LEN = (int)(Math.log((double)WINDOW_SIZE)/0.693147180559945+0.5);
    _normF=2f/WINDOW_SIZE;
    _hasEnvelope=false;
    _isEqualized=false;
    initFFTtables();
  }

  void initFFTtables() {
    _cosLUT=new float[BIT_LEN];
    _sinLUT=new float[BIT_LEN];
    _fftBuffer=new float[WINDOW_SIZE][2];
    _fft_result=new float[WS2];

    // only need to compute sin/cos at BIT_LEN angles
    float phi=PI;
    for(int i=0; i<BIT_LEN; i++) {
      _cosLUT[i]=cos(phi);
      _sinLUT[i]=sin(phi);
      phi*=0.5;
    }

    // precalc bit reversal lookup table ala nullsoft
    int i,j,bitm,temp;
    _bitrevtable = new int[WINDOW_SIZE];

    for (i=0; i<WINDOW_SIZE; i++) _bitrevtable[i] = i;
    for (i=0,j=0; i < WINDOW_SIZE; i++) {
      if (j > i) {
        temp = _bitrevtable[i];
        _bitrevtable[i] = _bitrevtable[j];
        _bitrevtable[j] = temp;
      }
      bitm = WS2;
      while (bitm >= 1 && j >= bitm) {
        j -= bitm;
        bitm >>= 1;
      }
      j += bitm;
    }
  }

  // taken from nullsoft VMS
  // reduces impact of bassy freqs and slightly amplifies top range
  void useEqualizer(boolean on) {
    _isEqualized=on;
    if (on) {
      int i;
      float scaling = -0.02f;
      float inv_half_nfreq = 1.0f/WS2;
      _equalize = new float[WS2];
      for (i=0; i<WS2; i++) _equalize[i] = scaling * (float)Math.log( (double)(WS2-i)*inv_half_nfreq );
    }
  }

  // bell filter envelope to reduce artefacts caused by the edges of standard filter rect
  // 0.0 < power < 2.0
  void useEnvelope(boolean on, float power) {
    _hasEnvelope=on;
    if (on) {
      int i;
      float mult = 1.0f/(float)WINDOW_SIZE * TWO_PI;
      _envelope = new float[WINDOW_SIZE];
      if (power==1.0f) {
        for (i=0; i<WINDOW_SIZE; i++) _envelope[i] = 0.5f + 0.5f*sin(i*mult - HALF_PI);
      } else {
        for (i=0; i<WINDOW_SIZE; i++) _envelope[i] = pow(0.5f + 0.5f*sin(i*mult - HALF_PI), power);
      }
    }
  }

  // compute actual FFT with current settings (eq/filter etc.)
  float[] computeFFT(float[] waveInData) {
    float  u_r,u_i, w_r,w_i, t_r,t_i;
    int    l, le, le2, j, jj, ip, ip1, i, ii, phi;

    // check if we need to apply window function or not
    if (_hasEnvelope) {
      for (i=0; i<WINDOW_SIZE; i++) {
        int idx = _bitrevtable[i];
        if (idx < WINDOW_SIZE) _fftBuffer[i][0] = waveInData[idx]*_envelope[idx];
        else  _fftBuffer[i][0] = 0;
        _fftBuffer[i][1] = 0;
      }
    } else {
      for (i=0; i<WINDOW_SIZE; i++) {
        int idx = _bitrevtable[i];
        if (idx < WINDOW_SIZE) _fftBuffer[i][0] = waveInData[idx];
        else  _fftBuffer[i][0] = 0;
        _fftBuffer[i][1] = 0;
      }
    }

    for (l = 1,le=2, phi=0; l <= BIT_LEN; l++) {
      le2 = le >> 1;
      w_r = _cosLUT[phi];
      w_i = _sinLUT[phi++];
      u_r = 1f;
      u_i = 0f;
      for (j = 1; j <= le2; j++) {
        for (i = j; i <= WINDOW_SIZE; i += le) {
          ip  = i + le2;
          ip1 = ip-1;
          ii  = i-1;
          float[] currFFT=_fftBuffer[ip1];
          t_r = currFFT[0] * u_r - u_i * currFFT[1];
          t_i = currFFT[1] * u_r + u_i * currFFT[0];
          currFFT[0] = _fftBuffer[ii][0] - t_r;
          currFFT[1] = _fftBuffer[ii][1] - t_i;
          _fftBuffer[ii][0] += t_r;
          _fftBuffer[ii][1] += t_i;
        }
        t_r = u_r * w_r - w_i * u_i;
        u_i = w_r * u_i + w_i * u_r;
        u_r = t_r;
      }
      le<<=1;
    }
    // normalize bands or apply EQ
    float[] currBin;
    if (_isEqualized) {
      for(i=0; i<WS2; i++) {
        currBin=_fftBuffer[i];
        _fft_result[i]=_equalize[i]*sqrt(currBin[0]*currBin[0]+currBin[1]*currBin[1]);
      }
    } else {
      for(i=0; i<WS2; i++) {
        currBin=_fftBuffer[i];
        _fft_result[i]=_normF*sqrt(currBin[0]*currBin[0]+currBin[1]*currBin[1]);
      }
    }
    return _fft_result;
  }
}

// FIR filter based on http://www.dsptutor.freeuk.com/KaiserFilterDesign/KaiserFilterDesign.html

class FIRFilter {
  float[] a,x;
  float kaiserV, f1, f2, fN, atten, trband;
  int order, filterType, freqPoints;

  static final int LOW_PASS = 1;
  static final int HIGH_PASS = 2;
  static final int BAND_PASS = 3;

  public FIRFilter(int type, float fr, float fq1, float fq2, float att, float bw) {
    filterType=type;
    fN=fr*0.5;
    f1=fq1;
    f2=fq2;
    atten=att;
    trband=bw;
    initialize();
  }

  float I0 (float x) {
    // zero order Bessel function of the first kind
    float eps = 1.0e-6f;   // accuracy parameter
    float fact = 1.0f;
    float x2 = 0.5f * x;
    float p = x2;
    float t = p * p;
    float s = 1.0f + t;
    for (int k = 2; t > eps; k++) {
      p *= x2;
      fact *= k;
      t = sq(p / fact);
      s += t;
    }
    return s;
  }

  int computeOrder() {
    // estimate filter order
    order = 2 * (int) ((atten - 7.95) / (14.36*trband/fN) + 1.0f);
    // estimate Kaiser window parameter
    if (atten >= 50.0f) kaiserV = 0.1102f*(atten - 8.7f);
    else
    if (atten > 21.0f)
    kaiserV = 0.5842f*(float)Math.exp(0.4f*(float)Math.log(atten - 21.0f))+ 0.07886f*(atten - 21.0f);
    if (atten <= 21.0f) kaiserV = 0.0f;
    println("filter oder: "+order);
    return order;
  }

  void initialize() {
    computeOrder();
    // window function values
    float I0alpha = 1f/I0(kaiserV);
    int m = order>>1;
    float[] win = new float[m+1];
    for (int n=1; n <= m; n++)
    win[n] = I0(kaiserV*sqrt(1.0f - sq((float)n/m))) * I0alpha;

    float w0 = 0.0f;
    float w1 = 0.0f;
    switch (filterType) {
      case LOW_PASS:
      w0 = 0.0f;
      w1 = PI*(f2 + 0.5f*trband)/fN;
      break;
      case HIGH_PASS:
      w0 = PI;
      w1 = PI*(1.0f - (f1 - 0.5f*trband)/fN);
      break;
      case BAND_PASS:
      w0 = HALF_PI * (f1 + f2) / fN;
      w1 = HALF_PI * (f2 - f1 + trband) / fN;
      break;
    }

    // filter coefficients (NB not normalised to unit maximum gain)
    a = new float[order+1];
    a[0] = w1 / PI;
    for (int n=1; n <= m; n++)
    a[n] = sin(n*w1)*cos(n*w0)*win[n]/(n*PI);
    // shift impulse response to make filter causal:
    for (int n=m+1; n<=order; n++) a[n] = a[n - m];
    for (int n=0; n<=m-1; n++) a[n] = a[order - n];
    a[m] = w1 / PI;
  }

  float[] apply(float[] ip) {
    float[] op = new float[ip.length];
    x=new float[order];
    float sum;
    for (int i=0; i<ip.length; i++) {
      x[0] = ip[i];
      sum = 0.0f;
      for (int k=0; k<order; k++) sum += a[k]*x[k];
      op[i] = sum;
      for(int k=order-1; k>0; k--) x[k] = x[k-1];
    }
    return op;
  }
}

FFTutils  fft;
FIRFilter filter;

float[] signal,filtered;
float[]   fft_result;

void setup() {
  size(1024,256);
  fft=new FFTutils(width);
  fft.useEqualizer(true);
  fft.useEnvelope(true,1);
  // setup new lowpass filter to cut off after 18.6kHz
  filter=new FIRFilter(FIRFilter.LOW_PASS,44100f,0,18600,60,3400);
  signal=new float[width];
}

void draw() {
  background(50);
  
  // synthesize some basic sine wave as test signal
  for(int i=0; i<fft.WINDOW_SIZE; i++) {
    // mouseX as base frequency
    float phi=TWO_PI*mouseX*10/44100*i;
    // use 4 oscillators which should show up in the spectrum
    // watch how the highest osc. gets mirrored in the spectrum when pitch is greater than nyquist freq
    // use mouseY to control amplitude
    signal[i]=(mouseY/256f)*(0.5*sin(phi)-0.25*sin(phi*1.5)+0.12*sin(phi*2)-0.1825*sin(phi*PI));
  }

  // show waveform in red
  for(int i=0; i<signal.length; i++) {
    stroke(128+abs(signal[i])*128,0,0);
    line(i,128,i,128+signal[i]*128);
  }
  
  // apply lowpass filter
  filtered=filter.apply(signal);
  
  //show filtered signal in orange (you can see the filter impact at the beginning of the buffer)
  stroke(255,200,0,140);
  for(int i=0; i<filtered.length; i++) line(i,128,i,128+filtered[i]*128);

  // compute fft and show spectrum
  fft_result=fft.computeFFT(filtered);

  // only display the real part spectrum (freq <= WINDOW_SIZE/2)
  for(int i=0; i<fft.WS2; i++) {
    stroke(255,255,0);
    line(i*2,255,i*2,255-fft_result[i]*256);
    stroke(0,255,0);
    line(i*2,255,i*2,255-fft._fftBuffer[i][0]);
    
    // show bellcurve of filter window
    if (fft._hasEnvelope) {
      stroke(255);
      point(i*2,255-fft._envelope[i*2]*255);
    }
    
    // show EQ function in cyan
    if (fft._isEqualized) {
      stroke(0,255,255);
      point(i*2,255-fft._equalize[i]*255);
    }
  }
}


