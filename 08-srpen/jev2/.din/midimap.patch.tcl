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

	displays midi controller slider/knob/buttons/keys & misc others status

}

proc make-tracer {name outcmd} {
	proc $name [list status id val [list outcmd $outcmd] [list msg $name]] {
		$outcmd "$msg: [format {mesg = %x id = %d value = %d} $status $id $val]"
	}
}

proc midimap {{outcmd echo}} {
	make-tracer midi-note-on $outcmd
	make-tracer midi-note-off $outcmd
	make-tracer midi-cc $outcmd
}

proc midi-clock {} {}
proc midi-start {} {}

proc midi-program-change {status value {outcmd echo}} {
	$outcmd "midi-program-change; status = $status, value = $value"
}
proc midi-pitch-bend {status ivalue {outcmd echo}} {
	$outcmd "midi-pitch-bend, status = $status, value = $value, ivalue = $ivalue"
}

proc get-val {min max amount} { ;# get interpolated value from min to max
	set amount [/ $amount 127.0]
	return [expr { (1 - $amount) * $min + $amount * $max }]
}

midimap
