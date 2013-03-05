set set-curve-editor(name) set-curve-editor
set set-curve-editor(short) sced
set set-curve-editor(purpose) {assign a curve editor to a screen}
set set-curve-editor(invoke) {set-curve-editor OR sced <name> <screen>}
set set-curve-editor(help) {8 screens are available. Each screen can have 1 editor.
...
name can be strength, waveform, channels, modulation, gaters, delay,
octave-shift, compressor & drone.
...
screen 0 is the din board. Not changeable.}
set set-curve-editor(examples) {
	set-curve-editor modulation 1 ;# press 1 to switch to modulation editor
	set-curve-editor waveform 7 ;# press 7 to switch to waveform editor
	...
	;# below is a snippet to replicate default assignment
	set defaults {strength 1 waveform 2 channels 3 modulation 4 gaters 5 delay 6 octave-shift 7 drone 8}
	foreach {i j} $defaults { set-curve-editor $i $j}
}
