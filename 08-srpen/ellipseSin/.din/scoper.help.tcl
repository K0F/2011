set scoper(name) N/A
set scoper(short) N/A
set scoper(purpose) {change colors of left & right channels of oscilloscope}
set scoper(invoke) {
	slider 1, 2 & 3 change red, green & blue components of left channel
	slider 4, 5 & 6 change red, green & blue components of right channel}
set scoper(help) {
	you must instruct JACK to route MIDI data to din for this to work:
	...
	jackd -R -s -d alsa -r 44100 -X seq ;# -X seq allows din to get MIDI data
	...
	use qjackctl to route MIDI data from your MIDI controller to din midi port
	...
	edit ~/.din/scoper.patch.tcl to change slider ids}
set scoper(examples) {}