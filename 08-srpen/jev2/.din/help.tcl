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

	command help display

}

proc help {{cmd ""}} {

	global color

	if { [catch {open ~/.din/$cmd.help.tcl r} f]} {
		if {$cmd ne ""} {
			eval $color(error)
			echo "$cmd: not found."
		}

		eval $color(header)
		echo "Available commands are:"
			eval $color(text)
			nago [lsort [lsdotdin help.tcl]] 4
		eval $color(header)
		echo "Type help command_name for help on a command"
		return
	}

	source ~/.din/$cmd.help.tcl
	set headers {NAME: {SHORT NAME:} PURPOSE: {HOW TO USE:} NOTES: EXAMPLES:}
	set keys {name short purpose invoke help examples}
	for {set i 0; set j [llength $keys]} {$i < $j} {incr i} {
		set text [lindex [array get $cmd [lindex $keys $i]] 1]
		if {[llength $text] > 0} {
			eval $color(header)
			echo [lindex $headers $i]
			eval $color(text)
			echo $text
		}
	}
}

proc nago {target n} {
	set j 0
	foreach i [lrange $target 0 end-1] {
		if {$j < $n} {incr j} else {
			echo $out
			unset out
			set j 0
		}
		append out " $i, ";
	}

	append out "and [lindex $target end]"
	echo $out

}
