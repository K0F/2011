set set-drone(name) set-drone
set set-drone(short) sdro
set set-drone(purpose) {set drone volume}
set set-drone(invoke) {set-drone OR sdro <what> <list of drone ids> <list of values>}
set set-drone(help) {
	what is:
		volume or v
	drone id must be > -1
	...
	a value is usually in range 0 to 1 for volume but not enforced.}
set set-drone(examples) {
	set-drone volume 0 0.7 ;# set volume of drone 0 ie 1st drone to 0.7
	sdro v 1 -1 ;# set volume of drone 1 ie 2nd drone to -1 --> reverse phase
	set-drone volume {0 1 2} 0 ;# silence first 3 drones
	set-drone volume {0 1 2} {0 0.1 0.2} ;# first 3 drones assigned volumes 0, 0.1 and 0.2}