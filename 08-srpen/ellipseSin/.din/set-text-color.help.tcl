set set-text-color(name) set-text-color
set set-text-color(short) stc
set set-text-color(purpose) {set color of text coming next on console}
set set-text-color(invoke) {set-text-color r g b}
set set-text-color(help) {
	r - red
	g - green
	b - blue
	...
	r, g, b must be in range 0 to 1}

set set-text-color(examples) {
	set-text-color 1 0 0 ;# red
	echo "this will be printed in red"
	...
	stc 0 1 0 ;# green, command name in short form
	echo "this will be in green"
	...
	set-text-color 0 0 1 ;# blue
	echo "and this will be in blue"}