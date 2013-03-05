set get-var(name) get-var
set get-var(short) gv
set get-var(purpose) {get value of variables in din}
set get-var(invoke) {get-var <variable1> <variable2> ... <variableN>}
set get-var(help) {prints the value of requested variables. available variables are:
	scroll or sc -- scroll rate, amount in x and amount in y for wsad key press
	fm_depth or fmd -- FM depth
	am_depth or amd -- AM depth
	drone_master_volume or dmv -- drone master volume
	snap_drones or sd -- drones snapped to notes? 1 = yes or 0 = no
	tuning or tu -- name of current tuning
	scale -- name of current scale
	zoom -- zoom of all curve editors. returns rate and amount
	pan -- pan on all curve editors. returns rate and amount
	fps -- number of times din refreshes the ui every second
	usleep -- number of microseconds din sleeps to allow processor do other tasks
	num_sine_samples or nss -- number of samples used when converting sine waveform to bezier waveform
	show_cursor_info or sci -- show frequency/volume under mouse cursor? 1 = yes, 0 = no
	jog or j -- number of samples to jump upon <- and -> key presses when phrasor is playing}
set get-var(examples) {
	get-var scroll ;# print scroll parameters of din board
	get-var fmd amd ;# get both fm_depth & am_depth
	gv fmd amd ;# short form
	get-var fmd amd tuning ;# returns 2 numbers (fmd & amd) & 1 string (name of tuning)}