puts -nonewline "+++ saving settings: "

set f [open ~/.din/settings.tcl w]
set set_cmd {set-bpm set-style set-var set-delay}
set get_cmd {get-bpm get-style get-var get-delay}
set runs { {fm am gl gr os} {fm am gl gr} {am_depth fm_depth} {left right}}
set ncmds [llength $set_cmd]
for {set i 0} {$i < $ncmds} {incr i} {
	set run [lindex $runs $i]
	foreach j $run {
		set setj [lindex $set_cmd $i]
		set getj [lindex $get_cmd $i]
		set str "$setj $j [$getj $j]"
		puts $f $str
	}
}

for {set i 1; set j [get-curve-editor n]} {$i <= $j} {incr i} {
	puts $f "set-curve-editor [get-curve-editor $i] $i"
}


proc check-scale {} {
	set scalelist [list-scales]
	set currentscale [get-var scale]
	set id [lsearch $scalelist $currentscale]
	if {$id eq -1} {return "major"} else {return [lindex $scalelist $id]}
}

foreach i {
	{"tuning set" "tuning get"}
	{load-scale check-scale} {key {key value}} {notation notation}
	{set-font-size get-font-size}
	{"set taptarget" "format {{%s}} [set taptarget]"}
	{"set-var scroll" "get-var scroll"}
	{"set-var zoom" "get-var zoom"}
	{"set-var pan" "get-var pan"}
	{"set-var fps" "get-var fps"}
	{"set-var usleep" "get-var usleep"}
	{"set-var num_sine_samples" "get-var num_sine_samples"}
	{"set-var show_cursor_info" "get-var show_cursor_info"}
	{"set-var jog" "get-var jog"}
	{"set-var delta_bpm" "get-var delta_bpm"}
	{"set-var drone_handle_size" "get-var drone_handle_size"}
	
	{"set-scope left" "format {{%s}} [get-scope left]"}
	{"set-scope right" "format {{%s}} [get-scope right]"}
	} {
	set setc [lindex $i 0]
	set getc [lindex $i 1]
	puts $f "$setc [eval $getc]"
}

close $f
puts "done. +++"
