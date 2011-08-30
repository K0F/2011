set remove-scale(name) remove-scale
set remove-scale(short) rs
set remove-scale(purpose) {removes a scale from din}
set remove-scale(invoke) {remove-scale OR rs <name>}
set remove-scale(help) {name is the scale name. must exist.}
set remove-scale(examples) {
	remove-scale bad1 ;# removes scale bad1
	rs wrong1 ;# removes scale wrong1
	rs boring1 ;# removes scale boring1
	rs duplicate ;# removes scale duplicate}
