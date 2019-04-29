
MIDIClient.init;
m =  MIDIOut.newByName("Rev2", "Rev2");

m =  MIDIIn.new("Launch Control", "Launch Control");

n = MIDIOut.new("IAC Driver", "Bus 1");


ServerOptions.devices;
s.options.device_("Built-in Output");
s.options.device_("Soundflower (64ch)");
s.options.device_("Loopback Audio 2");
s.options.device_("Fireface 400 (F55)");

s.reboot;



(
~pdef = Pdef(\yep,
	Pbind(
	\instrument, \bpfsaw,
	\dur, Pwhite(0.1, 4, inf),
	\stretch, Pseq([0, 1, 0, 1, 0, 1, 2, 2, 0, 1], inf),
	\legato, Pseq([2, 4, 8], inf),
	\osc, Pxrand([0, 1, 2], inf),
	\midinote, Pxrand(
			[
			[23, 35, 54, 63, 64],
			[45, 52, 54, 59, 61, 64],
			[23, 35, 54, 63, 64],
			[23, 35, 54, 63, 64],
			[28, 40, 47, 56, 59, 63],
			[42, 52, 57, 61, 63],
	], inf),
	\rel, Pwhite(0.1, 2, inf),
	\rqmax, Pshuf([0, 2], inf),
	\cfhzmax, Pwhite(0.5, 3),
	\atk, Pwhite(0.05, 0.8, inf),
	\pan, Pwhite(-1, 1, inf),
	\amp, Pwhite(0, 0.2, inf),
	).play;
)
)

~pdef.play;


Ndef(\kick, { var a, freq, trig; a = Dseq([440, 880], inf); trig=Impulse.ar(8); freq=Demand.ar(trig, 0, a) * 300 + 340; SinOsc.ar(freq) * 0.4 }).play;

Ndef(\kick, { var a, freq, trig; a = Dseq([440, 440, 880], inf); trig=Impulse.ar(4); freq=Demand.ar(trig, 0, a) * 300 + 340; SinOsc.ar(freq) * 0.4 }).play;




Ndef(\kick).clear;

(
r = Routine({
10.do{
	a = Pdef(\bpfsaw, [
		\osc, rrand(0, 2),
		\dur, Pxrand([2, 1/2, 1/4, 1/8, 8, 4], inf),
		\midinote, Pxrand(
			[
			Pxrand([23, 35, 54, 63, 64], inf),
			Pxrand([45, 52, 54, 59, 61, 64], inf),
			Pxrand([23, 35, 54, 63, 64], inf),
			Pxrand([23, 35, 54, 63, 64], inf),
			Pxrand([28, 40, 47, 56, 59, 63], inf),
			Pxrand([42, 52, 57, 61, 63], inf),
	], inf),
		\rel, rrand(0.1, 2),
		\rqmax, rrand(0, 1),
		\atk, rrand(0.05, 0.8),
		\pan, rrand(-1, 1),
		\amp, 0.2,
		]).play;
};
	1.0.wait;
}).loop;

)

s.meter

r.play;


NetAddr.localAddr;


x = [];
Synth(\bpfsaw, [\gate, 1, \freq, 200]);

n = NetAddr.new("127.0.0.1", 57120);

(
OSCdef(\1, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\sus, 0.01, \freq, msg[1] + 400]);
}, "/test");
)


OSCdef(\2, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 420]);
}, "/freq2");


OSCdef(\3, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\freq, msg[1] + 440]);
}, "/freq3");
)
(
OSCdef(\4, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 460]);
}, "/freq4");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 480]);
}, "/freq5");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 500]);
}, "/freq6");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 520]);
}, "/freq7");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 540]);
}, "/freq8");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 560]);
}, "/freq9");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 580]);
}, "/freq10");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 600]);
}, "/freq11");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 620]);
}, "/freq12");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 640]);
}, "/freq13");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 660]);
}, "/freq14");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 680]);
}, "/freq15");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 700]);
}, "/freq16");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 720]);
}, "/freq17");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 740]);
}, "/freq18");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 760]);
}, "/freq19");
)
(
OSCdef(\x, {
	arg msg;
	msg.postln;
	Synth(\bpfsaw, [\gate, 1, \freq, msg[1] + 780]);
}, "/freq20");
)






ServerOptions;

s.options.blockSize_(1025);
s.options.hardwareBufferSize_(1025);

o = OSCFunc.trace(true);





////// It all starts here


(
 SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1),
	freq = 300, freq2 = 150, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, gate=0,
	lsf=200, ldb=0, out=0, amp=0.2, osc=2;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0], [atk, sus, rel], [c1, 0, c2]), gate, doneAction:2)!2;
	sig = Mix.fill(3,
	[
	LFTri.ar(freq * {LFNoise1.kr(0.5,detune).midiratio}, mul: 0.2),

	SyncSaw.ar(freq / 2 * {LFNoise1.kr(0.5,detune).midiratio}, freq2 * {LFNoise1.kr(0.5,detune).midiratio}, mul: 0.2),

	SinOsc.ar(freq + 200 * {LFNoise1.kr(0.5,detune).midiratio}, mul: 0.2),
	]);

	sig = MoogFF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin, rqmax)}!2,
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;
)
s.meter;



(
SynthDef(\dsaf_multialarm, {
	|length=0.05, freqs=#[600,800,600,800], timbre=1, repeats=inf, pan=0.0|
	var freq, out, operations;
	freq = Duty.ar(length, 0, Dseq(freqs, repeats), doneAction: 2);
	freq = LPF.ar(freq, 70);
	out = LeakDC.ar(SinOsc.ar(freq));
	out = Select.ar(timbre, [out, (out * pi).sin, (out * pi).cos, ((out+0.25) * pi).cos]);
	// NOTE: when writing a synthdef always remember the Out ugen!
	// (Handy shortcuts like Ndef and {}.play often add Out on your behalf)
	Out.ar(0, Pan2.ar(out * 0.1, pan))
}).add;
)





a = Scale.dorian;
b = Scale.locrian;

// t = TempoClock(120/60);

a.postln;

(
// Pdef Pads
	Pbindef(\pads,
	\instrument, \bpfsaw,
	\dur, Pwhite(1, 7, inf),
	\stretch, Pwhite(0.1, 2, inf),
	\midinote, Pxrand(
			[
			Pxrand([23, 35, 54, 63, 64], inf),
			Pxrand([45, 52, 54, 4, 59, 61, 64], inf),
			Pxrand([23, 35, 54, 63, 16, 64], inf),
			Pxrand([23, 35, 54, 63, 64], inf),
			Pxrand([16, 28, 40, 47, 56, 59, 63], inf),
			Pxrand([42, 52, 57, 61, 63], inf),
	], inf),
	\detune, Pexprand(0.05, 0.2, inf),
	\cfmin, 100,
	\cfmax, Pwhite(100, 1500, inf),
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
)


	Ndef(\gnd,{LPF.ar(Gendy1.ar(2,4,MouseX.kr(90,9),50,100,mul:0.3),MouseY.kr(30,1000),0.2)!2}).play;

	Ndef(\gnd).clear;

	Ndef(\bSw,{LPF18.ar(SyncSaw.ar({50.rand},MouseX.kr(40,400),0.1), 200,0.4,0.3)!2}).play;

	Ndef(\bSw).clear;

	Ndef(\rytm,{var r=8,fq=Duty.ar(8/r,0,rrand(4,16));Saw.ar(fq,0.4)*Decay2.ar(Impulse.ar(r),1/r,0.3)!2}).play;

	Ndef(\rytm).clear;

	Ndef(\arpy,{ var a,fq,tr;a=Dseq([2, 65, 73, 120, 322],inf);tr=Impulse.ar(MouseX.kr(0, 500)); 	fq=Demand.ar(tr, 0,a)*20;Pan2.ar(SinOsc.ar(fq)*0.2,0.0)!2}).play;

	Ndef(\arpy).clear;