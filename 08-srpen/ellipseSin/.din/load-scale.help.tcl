set load-scale(name) load-scale
set load-scale(short) los
set load-scale(purpose) {loads a scale.}
set load-scale(invoke) {load-scale OR los <name>}
set load-scale(examples) {
	load-scale major ;# loads major scale
	load-scale minor ;# loads minor scale
	load-scale dorian ;# loads the dorian church mode
	load-scale bhairav ;# loads raga bhairav
	load-scale [lindex [list-scales] 1] ;# loads 2nd scale from list of available scales in din}
