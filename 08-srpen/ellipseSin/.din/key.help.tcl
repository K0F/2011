set key(name) key
set key(short) key
set key(purpose) {set the key frequency}
set key(invoke) {
	key
	key note_name
	key note_name octave_shift
	key note
	key value}
set key(examples) {
	key ;# prints key value in Hz, nearest note name & distance in Hz from that note
	key C; # set key to note middle C
	key C -1; # set key to note C an octave below middle C
	key C 2; # set key to note C 2 octaves above middle C
	key 440; # set key to 440 Hz which is the note A
	key note; # prints note name nearest to key
	key value; # prints the frequency in Hz of key}