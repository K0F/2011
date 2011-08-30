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

	tcl script to read midi slider/knob values and control oscilloscope color

}

proc change-color {channel component value} {
	set color [get-scope $channel] ;# get current color of channel
	lset color $component [get-val 0 1 $value] ;# change color component ie r, g or b
	set-scope $channel $color ;# set new channel color
	;# get-scope & set-scope are built in din commands to get and set oscilloscope color
	;# get-val maps midi slider/knob value (0 - 127) to target range (0 to 1 here)
}

proc midi-cc {status cc value} { ;# called when you operate sliders/knobs

	set ids {1 2 3 4 5 6} ;# your slider/knob ids -- change as appropriate
	set cmds {
		{change-color left 0 $value}
		{change-color left 1 $value}
		{change-color left 2 $value}
		{change-color right 0 $value}
		{change-color right 1 $value}
		{change-color right 2 $value}
	}

	for {set i 0; set j 6} {$i < $j} {incr i} {
		set id [lindex $ids $i]
		set cmd [lindex $cmds $i]
		if {$cc eq $id} {eval $cmd}
	}

}

