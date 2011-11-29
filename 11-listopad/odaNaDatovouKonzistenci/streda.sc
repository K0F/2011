/**
 *
 *	Óda Na datovou Konzistenci, Kof 2011, Audio, Copyleft
 *
 */

// boot server /////////////////// 
(
 b = Server.default;
 b.boot();

 )

// filtr //////////////////////
(
 {var amp = SinOsc.ar(100.rand*0.001,0,0.2);
 [Out.ar(0, LPF.ar(WhiteNoise.ar(amp,0),500.rand,1,0)),Out.ar(0, LPF.ar(WhiteNoise.ar(amp,0),500.rand,1,0))];}.play
 )


// hlavní část /////////////////
(
 {
 var amp = 0.8;
 var fq = XLine.kr(723.33,72.333,580) * SinOsc.ar(72.333,0,1.0);
 [Decay.ar(Impulse.ar(XLine.kr(0.1,5000,590), 0.25), 3, SinOsc.ar(fq*6.333,0,amp), 0.8),Decay.ar(Impulse.ar(XLine.kr(0.11,5000,610), 0.25), 3, SinOsc.ar(fq*3,0,amp ), 0.8)]  }.play;


 )


(
 // čekání ///////////////////

 var n = 20;
 var r = ((3.0.rand)*2.0+1);
 var amp2 = 1;
 { 

 Mix.fill(n, { arg index; 

	 var freq;

	 freq = 72/4.0*r*n-n + index;

	 [SinOsc.ar(freq + n / 2.0 , 20 / n , amp2 / n),SinOsc.ar(freq + n / 2.0 , 21 / n , amp2 / n)] 

	 })

 }.play;
 )


