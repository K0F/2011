set get-style(name) get-style
set get-style(short) gs
set get-style(purpose) {get style of beat progression}
set get-style(invoke) {get-style OR gs <list of components>}
set get-style(help) {
	component can be:
		gl - left channel gater
		gr - right channel gater
		am - amplitude modulator
		fm - frequency modulator
		os - octave shifter
set get-style(examples) {
	get-style {gl gr} ;# get style of gl & gr
	pong pong ;# sample output from get-style

	gs {gl gr} pong;# ditto but short form
	get-style [list-bpms];# get style of all available components
	get-style fm ;# get style of fm}