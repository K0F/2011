set set-kern(name) set-kern
set set-kern(short) sk
set set-kern(purpose) {set kerning between two characters of the font}
set set-kern(invoke) {set-kern OR sk character1 character2  amount}
set set-kern(help) {default kerning amount between any two characters is 0. }
set set-kern(examples) {
	set-kern @ ' 2 ;# shifts ' right 2 cells when following a @
	set-kern @ . 1 ;# shifts any character following @ right by 1 cell.
	set-kern . j -1 ;# shifts j left by 1 cell when it follows any character
	set-kern r j -2 ;# shifts j left by 2 cells when it follows r}
