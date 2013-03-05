set set-var(name) set-var
set set-var(short) sv
set set-var(purpose) {set value of variables in din}
set set-var(invoke) {set-var <variable1> <value1> <variable2> <value2>... <variableN> <valueN>}
set set-var(help) {sets the value of variables. available variables are:
	scroll or sc -- scroll rate and amount in x and y for wasd key presses
	fm_depth or fmd -- depth of frequency modulation (FM)
	am_depth or amd -- depth of amplitude modulation (AM)
	delta_bpm or dbpm -- amount to increase/decrease when changing bpm of gaters, fm, am & octave shift modules	
	drone_master_volume or dmv -- master volume of all drones in din
	snap_drones or sd -- drones snapped to notes? 1 = yes or 0 = no
	drone_handle_size or dhs -- handle size of drones used for display/selection
	zoom -- zoom of all curve editors. sub-variables: rate and amount
	pan -- pan on all curve editors. sub-variables: set rate and amount
	fps -- number of times every second din refreshes the ui
	usleep -- number of microseconds din sleeps to allow processor do other waiting tasks
	num_sine_samples or nss -- number of samples for converting sine waveform to bezier waveform
	show_cursor_info or sci -- show frequency/volume under mouse cursor? 1 = yes, 0 = no
	jog or j -- number of samples to jump when phrasor is playing back
}
set set-var(examples) {
	set-var scroll rate 100 x 25 y 3;# scroll 25 units in x & 3 units in y upto 100 times a second on wasd key presses
	set-var amd 0 ;# set am_depth to 0
	set-var fmd 0 ;# set fm_depth to 0
	set-var am_depth -0.5 fm_depth 100 ;# set am_depth to -0.5 and fm_depth to 100
	set-var delta_bpm 5 ;# change bpm of gaters, fm, am & octave shift by 5 beats when asked	
	set-var drone_master_volume 0.9 ;# very loud drones. careful.
	set-var dmv 0 ;# silence all drones
	set-var snap_drones 1 ;# snap new drones or moved drones to notes
	set-var drone_handle_size 14 ;# twice the size of default drone handles which is 7
	set-var zoom rate 100 amount 0.03 ;# zoom 100 times a second at 0.03 units per zoom in all curve editors
	set-var pan amount 0.03 rate 100 ;# pan 100 times a second at 0.03 units per pan in all curve editors
	set-var fps 30 ;# refresh din ui 30 times a second
	set-var usleep 0 ;# dont sleep at all - max processor usage but ultra performance (in theory)
	set-var num_sine_samples 100 ;# number of samples for converting sine waveform -> bezier waveform
	set-var show_frequency 1 ;# display frequency of notes and frequency & volume of pitch under mouse cursor
	sv sf 1 ;# same as above but short form
	set-var jog 10 ;# jump 10 samples when jogging the phrasor}
