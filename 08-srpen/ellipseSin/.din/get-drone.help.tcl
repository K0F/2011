set get-drone(name) get-drone
set get-drone(short) gdro
set get-drone(purpose) {get drone parameters}
set get-drone(invoke) {get-drone OR gdro <what> [list of drone ids]}
set get-drone(help) {
	what can be:
		volume OR v
		num-drones OR n
		selected OR s}
set get-drone(examples) {
	get-drone num-drones ;# returns number of drones in din
	get-drone n ;# returns number of drones in din
	...
	get-drone volume 0 ;# returns volume of drone 0 ie 1st drone
	gdro volume 24 ;# returns volume of drone 24 ie 25th drone if it exists else -1
	get-drone volume {0 2 4} ;# returns volume of 1st, 3rd and 5th drones
	gdro v -1 ;# returns bad drone id
	...
	get-drone selected ;# returns list of selected drones}
