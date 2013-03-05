if {0} {

	/*
		* This file is part of din.
		*
		* din is copyright (c) 2006 - 2011 S Jagannathan <jag@dinisnoise.org>
		* For more information, please visit http://dinisnoise.org
		*
		* din is free software: you can redistribute it and/or modify
		* it under the terms of the GNU General Public License as published by
		* the Free Software Foundation, either version 2 of the License, or
		* (at your option) any later version.
		*
		* din is distributed in the hope that it will be useful, but WITHOUT
		* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
		* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
		* for more details.
		*
		* You should have received a copy of the GNU General Public License along
		* with din.  If not, see <http://www.gnu.org/licenses/>.
		*
	*/

}

puts -nonewline "+++ loading Tcl init script: "

;# bring the math functions to use them LISP style eg., + 2 3
namespace import ::tcl::mathop::*

;# short for sourcing tcl scripts / patches
proc src {name} {
	uplevel #0 source ~/.din/$name.tcl
}

;# console colors
set color(header) {set-text-color 1 0.75 0.5}
set color(text) {set-text-color 0.8 1 0.8}
set color(error) {set-text-color 1 0.6 0.6}
set color(fine) {set-text-color 0.6 1 0.6}

proc tap-bpm-changed {name element op} {
	;# tap bpm changed
	upvar taptarget target tapbpm bpm
	echo "tap bpm: $bpm"
	set-bpm $target $bpm
}

trace add variable tapbpm write tap-bpm-changed

;# list files in ~/.din matching extension
proc lsdotdin {{ext *} {orient h} } {
	set mapping [list .$ext {}]
	if {$orient eq "v" || $orient eq "vertical"} {lappend mapping { } \n}
	string map $mapping [lsort [glob -nocomplain -tails -directory ~/.din *.$ext]]
}

;# list-resonators command
set lsr_body {{{orient h} {ext res}} {lsdotdin $ext $orient}}
proc list-resonators {*}$lsr_body
proc lsr {*}$lsr_body

;# delete-disabled-resonators command
proc delete-disabled-resonators {} {
	save-resonators . 1
	load-resonators .
}

proc bad-sub-command {c} {
	upvar $c cmds
	set err "bad sub-command. should be: "
	foreach i [lrange $cmds 0 end-1] {
		append err "$i, "
	}
	append err "or [lindex $cmds end]"
}

proc exec-sub-command {ucmds uactions ucmd uargs} {
	upvar $ucmds cmds $uactions actions $ucmd cmd $uargs args
	set j 0
	foreach i $cmds {
		if {$cmd eq $i} {
			return [{*}[lindex $actions $j] {*}$args]
		}
		incr j
	}
	bad-sub-command cmds
}

;# find-scale command -> lists scales that match pattern
proc find-scale {pattern} {
	lsort [lsearch -all -inline [list-scales] $pattern]
}

;# tuning command -> list, set and get available tunings
proc tuning {cmd args} { ;# tuning command
	set cmds {list set get}
	set actions {"lsdotdin tuning" "set-var tuning" "get-var tuning"}
	exec-sub-command cmds actions cmd args
}

;# called when drones are deleted
proc drones-deleted {args} {}

;# called once every din loop
proc loop {} {} ;# required

;# list-patches command
set lsp_body {{{v ""}} {
	lsdotdin patch.tcl $v
}}

eval "proc list-patches $lsp_body"
eval "proc lp $lsp_body"

;# load-patch command
set lop_body {{patch} {
	if [catch {src $patch.patch}] {
		set-text-color 1 0.5 0.5
		echo "bad $patch"
	} else {
		set-text-color 0.5 1 0.5
		echo "loaded $patch"
		echo "help $patch for more information"
	}
}}

eval "proc load-patch $lop_body"
eval "proc lop $lop_body"

;# make interval note variables based on current tuning
src make-interval-note-vars

;# load help displayer
src help

;# load midi mapper
src midimap.patch

puts "done. +++"
