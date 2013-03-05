set midimap(name) N/A
set midimap(short) N/A
set midimap(purpose) {displays MIDI activity on console}
set midimap(invoke) N/A
set midimap(help) {
	you must instruct JACK to route MIDI data to din for this to work:
	...
	jackd -R -s -d alsa -r 44100 -X seq ;# -X seq allows din to get MIDI data
	...
	use qjackctl to route MIDI data from your MIDI controller to din midi port
	...
	midimap displays midi control change, program change, pitch bend & note on & off messages
	...}
set midimap(examples) {}