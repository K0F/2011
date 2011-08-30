set set-bpm(name) set-bpm
set set-bpm(short) sb
set set-bpm(purpose) {set bpm of a component}
set set-bpm(invoke) {set-bpm OR sb <list of component names> <list of bpms>}
set set-bpm(help) {component name can be:
	gl = left channel gater
	gr = right channel gater
	am = amplitude modulater
	fm = frequency modulater
	os = octave shifter}
set set-bpm(examples) {
	set-bpm gl 10 ;# set left channel gater bpm to 10
	sb gr 10;# set right channel gater bpm to 10
	set-bpm {gl gr} 10 ;# set both left & right channel gater bpm to 10
	set-bpm {fm am} {120 240} ;# set fm bpm to 120, am bpm to 240}
