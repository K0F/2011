set set-style(name) set-style
set set-style(short) ss
set set-style(purpose) {set style of beat progression}
set set-style(invoke) {set-style OR ss <list of components> <style>}
set set-style(help) {
	component can be:
		gl - left channel gater
		gr - right channel gater
		fm - frequency modulator
		am - amplitude modulator
		os - octave shifter
	style can be:
		loop - beat goes from start to end, start to end and so on
		pong - beat goes from start to end, end to start, start to end and so on}
set set-style(examples) {
	set-style {gl gr} pong ;# set style of gl & gr to pong
	ss {gl gr} pong;# ditto but short form
	set-style [list-bpms] pong ;# set style of all available components to pong
	set-style fm loop ;# set style of fm to loop}