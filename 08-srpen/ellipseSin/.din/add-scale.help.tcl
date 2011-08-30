set add-scale(name) add-scale
set add-scale(short) as
set add-scale(purpose) {adds a scale to din}
set add-scale(invoke) {add-scale OR as <name> <notes>}
set add-scale(help) {
	valid note names depend on tuning (see help tuning) but usually are:
		1 = key note
		2b = minor second
		2 = second
		3b = minor third
		3 = third
		4 = perfect fourth
		5b = diminished fifth
		5 = perfect fifth
		6b = minor sixth
		6 = sixth
		7b = minor seventh
		7 = seventh
		8 = octave
	notes 1 and 8 must be used.}
set add-scale(examples) {
	add-scale everything 1 2b 2 3b 3 4 5b 5 6b 6 7b 7 8 ;# a scale with all available notes
	add-scale major 1 2 3 4 5 6 7 8 ;# add major scale
	as minor5 1 3b 4 5 7b 8 ;# add minor pentatonic scale}
