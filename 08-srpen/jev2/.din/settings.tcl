set-bpm fm 90 
set-bpm am 90 
set-bpm gl 90 
set-bpm gr 90 
set-bpm os 90 
set-style fm loop 
set-style am loop 
set-style gl loop 
set-style gr loop 
set-var am_depth 0
set-var fm_depth 0
set-delay left 1000.00
set-delay right 1000.00
set-curve-editor strength 1
set-curve-editor waveform 2
set-curve-editor channels 3
set-curve-editor modulation 4
set-curve-editor gater 5
set-curve-editor delay 6
set-curve-editor octave-shift 7
set-curve-editor drone 8
tuning set pytha
load-scale minor
key 261.625
notation numeric
set-font-size 2 2 4 4
set taptarget {gl gr}
set-var scroll rate 100 x 25 y 5
set-var zoom rate 100 amount 0.035
set-var pan rate 100 amount 0.03
set-var fps 1000
set-var usleep 1
set-var num_sine_samples 100
set-var show_cursor_info 0
set-var jog 3
set-var delta_bpm 1
set-var drone_handle_size 7
set-scope left {0.000000 1.000000 1.000000}
set-scope right {1.000000 1.000000 0.000000}
