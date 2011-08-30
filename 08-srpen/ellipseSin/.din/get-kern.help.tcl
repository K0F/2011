set get-kern(name) get-kern
set get-kern(short) gk
set get-kern(purpose) {get kerning amount between two characters of the font}
set get-kern(invoke) {get-kern OR gk character1 character2  }
set get-kern(examples) {
	get-kern a b ;# prints kerning amount when b follows a.
	get-kern b a ;# prints kerning amount when a follows b.
	get-kern . a ;# prints kerning amount for each character when it precedes a.
	get-kern a . ;# prints kerning amount for each character when it follows a.
	gk i j ;# prints kerning amount when j follows i.}
