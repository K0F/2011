set curve-value(name) curve-value
set curve-value(short) cv
set curve-value(purpose) {set x, y of a vertex or tangent of a curve}
set curve-value(invoke) {curve-value OR cv <name> <what> <id> <x> <y>}
set curve-value(help) {
	name: name of curve
	what: v (for vertex) or lt (for left tangent) or rt (for right tangent)
	x, y: x, y position
	...
	all arguments are compulsory}
set curve-value(examples) {
	curve-value bezier1 v 0 0 0 ;# set 1st vertex of curve bezier1 to origin
	cv bezier1 lt 0 -1 0 ;# set left tangent of 1st vertex to -1, 0
	cv bezier1 rt 0 1 0 ;# set right tangent of 1st vertex to 1, 0}