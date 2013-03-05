set get-delay(name) get-delay
set get-delay(short) gd
set get-delay(purpose) {get duration of a delay}
set get-delay(invoke) {get-delay OR gd <name>}
set get-delay(help) {name is the delay name:
		left or l
		right or r
		...
		returns delay duration in milliseconds}
set get-delay(examples) {
	get-delay l ;# get duration of left channel delay
	get-delay left ;# ditto
	get-delay r ;# get duration of right channel delay
	gd right ;# ditto
	gd r ;# ditto again}
