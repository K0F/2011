set morse-code(name) morse-code
set morse-code(short) mc
set morse-code(purpose) {convert text to bezier curve using bezier curves for morse code patterns
	like dot, dash, inner letter spacing, letter spacing and word spacing}
set morse-code(invoke) {morse-code OR mc <text>}
set morse-code(help) {text can be a piece of text containing letters & numbers only.
	...
	generated curve is copied into the copy curve. paste into any curve in any curve editor.}
set morse-code(examples) {set-curve-editor morse-code 6 ;# set morse-code editor to screen 6
	;# edit the patterns for dot, dash, inner letter spacing, letter spacing and word
	;# in the morse-code editor

	;# generate bezier curve for sos using these patterns
	morse-code sos ;# generated bezier curve is in copy curve

	goto desired editor, select a curve and paste morse coded bezier curve.

	morse-code {a long piece of text} ;# a longer piece of text -> bezier curve}