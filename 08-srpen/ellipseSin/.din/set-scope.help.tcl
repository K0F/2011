set set-scope(name) set-scope
set set-scope(short) ssco
set set-scope(purpose) {set oscilloscope channel color}
set set-scope(invoke) {set-scope OR ssco <channel> {r g b}}
set set-scope(help) {
	valid channel:
		left or l
		right or r
	...
	{r g b} - list of 3 color components in range 0 to 1
}
set set-scope(examples) {
	set-scope left {1 0 0} ;# sets left channel color to pure red
	ssco r {0 1 0} ;# sets right channel color to pure green
	set-scope left {1 0.5 0.5} ;# sets left channel to a sort of reddy color}
