set load-resonators(name) load-resonators
set load-resonators(short) lre
set load-resonators(purpose) {load resonators from a file}
set load-resonators(invoke) {load-resonators name}
set load-resonators(help) {name is expanded to: ~/.din/name.res}
set load-resonators(examples) {
	load-resonators one ;# default just one resonator
	load-resonators many ;# sphagetti of resonators
	lre two ;# 2 resonators, short name of command
	load-resonators three ;# yes 3 resonators
	load-resonators six ;# yes 6 resonators}