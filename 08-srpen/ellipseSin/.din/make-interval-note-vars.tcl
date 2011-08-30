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

proc list2var {L} {
	for {set i 0; set j [llength $L]; set k [expr $j-1]} {$i < $k} {incr i 2} {
		set var [lindex $L $i]
		set val [lindex $L [+ $i 1]]
		uplevel #0 "set $var $val"
	}
}

proc make-interval-note-vars {} {
	list2var [get-intervals] ;# make intervals into variables eg., set 2b prints 1.05946
	list2var [get-intervals piano] ;# make piano notes into variables eg., set C prints 261.626
}

make-interval-note-vars