set droner(name) N/A
set droner(short) N/A
set droner(purpose) {assign drones to midi sliders and fade them in & out}
set droner(invoke) N/A
set droner(help) {
	you must instruct JACK to route MIDI data to din for this to work:
	...
	jackd -R -s -d alsa -r 44100 -X seq ;# -X seq allows din to get MIDI data
	use qjackctl to route MIDI data from your MIDI controller to din midi port
	...
	select a bunch of drones and assign to midi knob or slider with command:
		assign-drones OR asd <id>
	<id> is the slider/knob id
	keep the slider/knobs at max (ie 127) when making assignment
	so you can fade them out and back in smoothly instead of jumping to a value
	...
	command assign-drones without any arguments prints the current assignments}
set droner(examples) {
	assign-drones ;# print current assignments
	asd 1 ;# assign selected drones to midi slider/knob with id = 1}