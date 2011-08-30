set get-scope(name) get-scope
set get-scope(short) gsco
set get-scope(purpose) {get oscilloscope channel color}
set get-scope(invoke) {get-scope OR gsco <channel>}
set get-scope(help) {
	channel can be:
		left OR l
		right or r
	prints r g b values in range 0 to 1}
set get-scope(examples) {
	get-scope left ;# returns color of left channel on oscilloscope
	1 0 0 ;# sample response}
