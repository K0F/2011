set list-notes(name) list-notes
set list-notes(short) ln
set list-notes(purpose) {list notes of a scale}
set list-notes(invoke) {list-notes OR ln <scale>}
set list-notes(help) {scale is the scale name}
set list-notes(examples) {
	list-scales ;# prints list of scales in din
	...
	list-notes major ;# lists notes of major scale
	list-notes minor5 ;# lists notes of minor5 scale
	llength [list-notes minor5] ;# prints number of notes in the scale minor5}
