set get-beat(name) get-beat
set get-beat(short) gbt
set get-beat(purpose) {get beat info of components}
set get-beat(invoke) {get-beat OR gbt <list of components> [what]}
set get-beat(help) {
	component name can be:
		fm - frequency modulater
		am - amplitude modulater
		os - octave shifter
		gl - left channel gater
		gr -right channel gater
	what can be:
		all
		first
		last}
set get-beat(examples) {
	get-beat {gl gr} ;# return current beat of gl & gr
	gbt {fm am} ;# get beat of fm & am}

	get-beat {gl gr} all ;# return current beat, first beat & last beat of gl & gr
	{0.5 0 1} {0.75 0 1} ;# sample response}
