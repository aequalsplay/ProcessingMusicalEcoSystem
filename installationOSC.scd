

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
}, "/freq1.0");
)

(
OSCdef(\2, {
	arg msg;
	msg.postln;
	Ndef(\gnd,{LPF.ar(Gendy1.ar(2,4,msg[1] + 400,50,100,mul:0.3),msg[1],0.2)!2}).play;
	// Synth(\bpfsaw, [\sus, 0.01, \freq, msg[1] + 420]);
	~oscMsg2 = msg;
}, "/freq2.0");
)

(
OSCdef(\3, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\sus, 0.01, \amp, 0.1, \freq, msg[1] + floor(rrand(110, (265.. 220)))]);
	~oscMsg3 = msg;
}, "/freq3.0");
)

(
OSCdef(\4, {
	arg msg;
	msg.postln;
	Ndef(\rytm,{var r=8,fq=Duty.ar(8/r,0,rrand(4,16));Saw.ar(fq,0.4)*Decay2.ar(Impulse.ar(r),1/r,0.2)!2}).play;
	~oscMsg4 = msg;
}, "/freq4.0");
)

(
OSCdef(\5, {
	arg msg;
	msg.postln;
	Ndef(\rytm).stop;
	~oscMsg5 = msg;
}, "/freq5.0");
)




(
OSCdef(\6, {
	arg msg;
	msg.postln;
	Ndef(\bSw,{LPF18.ar(SyncSaw.ar({50.rand},msg[1]*2,0.1), 200,0.4,0.3)!2}).play;

	~oscMsg6 = msg;
}, "/freq6.0");
)

(
OSCdef(\7, {
	arg msg;
	msg.postln;
	Ndef(\bSw).stop(4);
	~oscMsg7 = msg;
}, "/freq0.0");
)



(
OSCdef(\born, {
	arg msg;
	msg.postln;

	Synth(\dsaf_multialarm, [\length, [0.03, 0.2].choose, \freqs, [400, 125, 0, 0], \timbre, [msg[1],2].choose, \repeats, [10, 40, 20, 60, 80, 20].choose, \pan, msg[1].linlin(200, 300, -1.0, 1.0)]);

	~born = msg;
}, "/born");
)


Ndef(\blip, {arg amp=0.2; var sig, env; sig=Blip.ar(660, 200, 0.2); env=Env.perc(0.01, 0.6, 0.2); sig = sig * env * amp; Out.ar(0, sig)}!2).play;

NdefMixer(s);

s.meter;



	Ndef(\dust, {arg pan=0.0; var sig, env; env=Env.perc(0.03, 0.5, 0.3, 'exponential'); sig=SyncSaw.ar([210, 220, 110, 105, 160, 320] * Dust.ar(100), 210, 0.2); sig=LPF.ar(sig, 500, 0.2); sig=Pan2.ar(sig, pan);Out.ar(0, sig)*0.2}).play;
	// NDef(\blip, {var sig; sig=Blip.ar(660, msg[1], 0.2) * Env.perc(0.01, 0.6, 0.2); Out.ar(0, sig)}!2).play;


