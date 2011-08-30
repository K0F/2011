set get-font-size(name) get-font-size
set get-font-size(short) gfs
set get-font-size(purpose) {get font size}
set get-font-size(invoke) {get-font-size OR gfs}
set get-font-size(help) {
	prints 4 numbers. for eg.,
	2 2 4 4 where
	xsize = x cell size = 2
	ysize = y cell size = 2
	charspc = number of cells between 2 characters = 4
	headroom = number of cells between two lines = 4}
set get-font-size(examples) {
	get-font-size ;# prints xsize ysize charspc headroom
	gfs ;# short name}
