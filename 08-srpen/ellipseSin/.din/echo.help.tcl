set echo(name) {echo}
set echo(short) {echo}
set echo(purpose) {echoes text}
set echo(invoke) {echo <text>}
set echo(help) {echo uses current text color to output text. change this color with set-text-color command}
set echo(examples) {
	echo word ;# prints word
	echo {a fairly long sentence} ;# prints a fairly long sentence
	echo "2 + 2 is = [expr 2 + 2]" ;# prints 2 + 2 is = 4
	echo "we have [get-drone n] drones in din" ;# prints the number of drones in din}