set set-beat(name) set-beat
set set-beat(short) sbt
set set-beat(purpose) {set beat of component}
set set-beat(invoke) {set-beat OR sbt <list of components> <beat>}
set set-beat(help) {
	component can be:
		gl - left channel gater
		gr - right channel gater
		am - amplitude modulator
		fm - frequency modulator
		os - octave shifter
	beat is beat}
set set-beat(examples) {
	set-beat {gl gr} 0 ;# beat to 0 for left & right gaters
	set-beat gl [get-now gr] ;# snap beat of gl to beat of gr
	set-beat {fm am} 1 ;# beat to 1 for fm & am
	sbt {fm am} 1 ;# ditto but short form
	sbt {fm am} {0 1} ;# beat of fm to 0 and beat of am to 1}
