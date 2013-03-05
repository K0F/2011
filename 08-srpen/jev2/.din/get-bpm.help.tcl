set get-bpm(name) get-bpm
set get-bpm(short) gb
set get-bpm(purpose) {get the bpm}
set get-bpm(invoke) {get-bpm OR gb <list of components>}
set get-bpm(help) {
	component can be:
		gl - left gater
		gr - right gater
		fm - frequency modulator
		am - amplitude modulator
		os - octave shifter}
set get-bpm(examples) {
	get-bpm fm ;# get bpm of frequency modulator
	get-bpm {gl gr} ;# get bpm of left & right gater
	gb am ;# get bpm of amplitude modulator}
