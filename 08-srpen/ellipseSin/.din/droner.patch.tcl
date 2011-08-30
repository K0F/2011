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

	control selected drones from midi slider/knob

	cant delete drones after assignment. must reassign.

}

set assign_drones_body {{{cc -1}} { ;# assigns selected drones to midi cc

	global dronal

	if {$cc eq -1} {
		;# return current assignments
		echo "assigned sliders/knobs: [lsort [array names dronal]]"
		return
	}

	set sel [get-drone selected] ;# get selected drones

	;# set cc as dronal array variable's index
	;# and store selected drones & their initial volumes
	set dronal($cc) [list $sel [get-drone volume $sel]]  ;# get-drone is din built in command

}}

proc assign-drones {*}$assign_drones_body
proc asd {*}$assign_drones_body ;# short form

proc midi-cc {status cc value} { ;# called when user operates midi controller

	global dronal

	foreach id [array names dronal] {

		if {$cc eq $id} { ;# cc matches one of our drones assignments

			set pair $dronal($id) ;# get drones & initial volumes for this assignment
			set drones [lindex $pair 0] ;# get the attached drones
			set vols [lindex $pair 1] ;# get the initial volumes

			if {0} {
				run thru the drones list and assign volume based on midi slider position
			}

			for {set i 0; set j [llength $drones]} {$i < $j} {incr i} {
				set idrone [lindex $drones $i]
				set ivol [lindex $vols $i]
				set-drone volume $idrone [get-val 0 $ivol $value]
				;# set-drone is din built in command
				;# get-val from midimap.patch.tcl
			}

		}

	}

}

