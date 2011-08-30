set set-delay(name) set-delay
set set-delay(short) sd
set set-delay(purpose) {set duration of a delay}
set set-delay(invoke) {set-delay OR sd <name> <msecs>}
set set-delay(help) {name is the delay name. delay name can be:
		left or l
		right or r
	...
	msecs is duration in milliseconds.}
set set-delay(examples) {
	set-delay left 1000 ;# set left channel delay to 1 second.
	set-delay right 5000 ;# set right channel delay to 5 seconds.
	set-delay l 250 ;# set left channel delay to quarter of a second.
	set-delay r 500 ;# set right channel delay to half a second.}
