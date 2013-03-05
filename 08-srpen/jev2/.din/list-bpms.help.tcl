set list-bpms(name) list-bpms
set list-bpms(short) lb
set list-bpms(purpose) {list components that take bpm}
set list-bpms(invoke) {list-bpms OR lb}
set list-bpms(help) {
	always prints:
		gl gr am fm os
	where:
		gl - left channel gater
		gr - right channel gater
		am - amplitude modulator
		fm - frequency modulator
		os - octave shifter}
set list-bpms(examples) {
	list-bpms ;# list components that accept bpm
	fm am gl gr os ;# output of list-bpms
	...
	;# some uses
	set-bpm [list-bpms] 90 ;# set bpm of all components to 90
	get-bpm [list-bpms] ;# get bpm of all components}
