set note-distance(name) note-distance
set note-distance(short) nd
set note-distance(purpose) {print distance between two notes}
set note-distance(invoke) {note-distance OR nd note1 note2 [verbose/v]}
set note-distance(examples) {
	note-distance C G ;# prints 5
	note-distance C F ;# prints 4
	nd A E ;# prints 5
	nd B E ;# prints 4
	nd G D verbose ;# prints 5 perfect-fifth}
