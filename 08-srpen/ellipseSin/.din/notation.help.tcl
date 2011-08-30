set notation(name) notation
set notation(short) no
set notation(purpose) {set the display notation}
set notation(invoke) {
	notation
	notation western or w
	notation numeric or n}
set notation(help) {}
set notation(examples) {
	notation w ;# display western notation
	notation n ;# display numeric notation
	no western ;# display western notation
	no numeric ;# display numeric notation
	notation ;# prints current notation

	;# useful in tandem with notation command:
	set-var show_frequency 1 ;# displays frequencies of notes & under mouse cursor}