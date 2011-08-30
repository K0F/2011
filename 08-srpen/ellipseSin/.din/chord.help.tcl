set chord(name) chord
set chord(short) ch
set chord(purpose) {display notes of a chord given its root}
set chord(invoke) {
	chord root name
	ch root name}
set chord(help) {
	root is the root note name of a chord
	name is the chord name
	...
	name can be:
		no chord name - major
		m - minor
		maj7 - major 7th
		m7 - minor 7th
		sus4 - suspended 4th
		7sus4 - dominant 7th, suspended 4th
		6 - major 6th
		m6 - minor 6th
		7 - dominant 7th
		9 - dominant 9th
		m9 - minor 9th
		maj9 - major 9th
		add9 - major, add 9th
		5 - power chord
		69 - major 6th, add 9th
		11 - dominant 11th
		13 - dominant 13th
		07 - diminished 7th
		0 - diminished triad
		+ - augmented}
set chord(examples) {
	chord C ;# prints notes of the C major chord
	ch C m ;# prints notes of the C minor chord
	chord F maj9 ;# prints notes of the F major 9th chord}