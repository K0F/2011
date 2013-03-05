set set-font-size(name) set-font-size
set set-font-size(short) sfs
set set-font-size(purpose) {sets font size}
set set-font-size(invoke) {set-font-size OR sfs <xsize> <ysize> <charspc> <headroom>}
set set-font-size(help) {
	xsize = x cell size
	ysize = y cell size
	charspc = number of cells between 2 characters
	headroom = number of cells between 2 lines}
set set-font-size(examples) {
	set-font-size 2 2 4 4 ;# xsize = 2, ysize = 2, charspc = 4 & headroom = 4
	set-font-size 2 2 ;# xsize = 2, ysize = 2; current values of others are used
	sfs . . 4 4 ;# keep current values of xsize & ysize, charspc = 4, headroom = 4}
