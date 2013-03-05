set start-end(name) N/A
set start-end(short) N/A
set start-end(purpose) {
	go from a start value to end value and run a command for every inbetween value.
	...
	activated by MIDI slider/knob with #CC = 1
	...
	edit #CC in ~/.din/start-end.patch.tcl
	...
	can be used to set key, set bpm and set AM and FM depth.}
set start-end(invoke) {
	set suitable values for Tcl variables start, end and cmd and move MIDI slider/knob 1 to go from start to end. din runs
	command set in variable cmd for each inbetween value}
set start-end(help) {}
set start-end(examples) {set start [key value] ;# start is current value of key in Hz
	set end [expr 2 * $start] ;# end is twice the start ie octave above
	set cmd key ;# the key command executed for every inbetween value from current to octave above.}
