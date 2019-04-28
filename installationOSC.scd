

(
OSCdef(\1, {
	arg msg;
	msg.postln;

// Pdef Pads
	Pbindef(\pads,
	\instrument, \bpfsaw,
	\dur, Pwhite(msg[1], msg[1]+ 2, inf),
	\stretch, Pwhite(0.1, 2, inf),
	\midinote, Pxrand(
			[
			Pxrand([23, 35, 54, 63, 64], inf),
			Pxrand([45, 52, 54, 4, 59, 61], inf),
			Pxrand([23, 35, 54, 16, 64], inf),
			Pxrand([23, 35, 54, 63], inf),
			Pxrand([16, 28, 40, 47, 56, 59], inf),
			Pxrand([42, 52, 57, 61, 63], inf),
	], inf),
	\detune, Pexprand(0.05, 0.2, inf),
	\cfmin, 100,
	\cfmax, Pwhite(msg[1] + 100, 300, inf),
	\c1, Pwhite(0.1, 10, inf),
	\c2, Pwhite(0.1, 10, inf),
	\rqmin, Pexprand(0.01, 0.15, inf),
	\rqmax, Pexprand(0.15,0.25, inf),
	\atk, Pwhite(2.0, 2.5, inf),
	\sus, Pwhite(0.5, 1, inf),
	\rel, Pwhite(6.5, 10.0, inf),
	\ldb, 4,
	\amp, 0.2,
	\out, 0,
	\pan, Pwhite(-1.0,1.0, inf),
).play;
	~oscMsg = msg;
}, "/freq1");
)

(
OSCdef(\2, {
	arg msg;
	msg.postln;
	Ndef(\gnd,{LPF.ar(Gendy1.ar(2,4,msg[1] + 400,50,100,mul:0.3),msg[1],0.2)!2}).play;
	// Synth(\bpfsaw, [\sus, 0.01, \freq, msg[1] + 420]);
	~oscMsg2 = msg;
}, "/freq2");
)

(
OSCdef(\3, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\sus, 0.01, \amp, 0.1, \freq, msg[1] + floor(rrand(110, (265.. 220)))]);
	~oscMsg3 = msg;
}, "/freq3");
)

(
OSCdef(\4, {
	arg msg;
	msg.postln;
	Ndef(\rytm,{var r=8,fq=Duty.ar(8/r,0,rrand(4,16));Saw.ar(fq,0.4)*Decay2.ar(Impulse.ar(r),1/r,0.2)!2}).play;
	~oscMsg4 = msg;
}, "/freq4");
)

(
OSCdef(\5, {
	arg msg;
	msg.postln;
	Ndef(\rytm).stop;
	~oscMsg5 = msg;
}, "/freq5");
)




(
OSCdef(\6, {
	arg msg;
	msg.postln;
	Ndef(\bSw).stop(4);
	~oscMsg6 = msg;
}, "/freq6");
)

(
OSCdef(\7, {
	arg msg;
	msg.postln;
	Ndef(\bSw,{LPF18.ar(SyncSaw.ar({50.rand},msg[1]*2,0.1), 200,0.4,0.3)!2}).play;
	~oscMsg7 = msg;
}, "/freq0");
)



(
OSCdef(\born, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\dec, 0.1, \sus, 0.0, \rel, 0.2, \freq, 2000, \gate, msg[1]]);
	~born = msg;
}, "/born");
)





