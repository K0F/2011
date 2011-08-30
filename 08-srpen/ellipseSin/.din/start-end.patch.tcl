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

	go from a start value to an end value executing a command for each inbetween value

	can be used to:

		set AM and FM depth
		set bpm
		set drone master volume
		set key

}

set procs(midi) { ;# evaluated when input is midi

	catch [rename interp {}] ;# dont need interp created in procs(mouse)

	proc loop {} {} ;# reset loop function created in procs(mouse)

	proc midi-cc {status cc value} { ;# handle MIDI CC

		set slider 1 ;# assumes your MIDI slider has #CC = 1, change as appropriate

		if {$cc eq $slider} {

			;# moved slider
			global start end cmd
			set current [get-val $start $end $value] ;# interpolate start-end value to get current value
			eval "$cmd $current" ;# execute command with current value as argument

		}

	}

}

set procs(mouse) { ;# evaluated when input is mouse

	catch [rename midi-cc {}]

	proc interp {start end value} { ;# interpolate start/end with value in range 0, 1
		return [expr (1 - $value) * $start + $value * $end]
	}

	proc loop {} { ;# called once every din cycle

			;# could throttle at a frame rate but we keep it simple

			global start end cmd
			global volume ;# mouse height on din board mapped to (0, 1)

			set current [interp $start $end $volume] ;# interpolate start-end value to get current value based on volume
			eval "$cmd $current" ;# execute command with current value as argument

	}

}

;# fm depth
set start -100
set end 100
set cmd {set-var fm_depth}

;# other possibilities:

# for drone master volume
# set start 0
# set end 0.25 ;# careful, very high means very loud!
# set cmd {set-var drone_master_volume}

# for AM depth
# set start 0
# set end 1
# set cmd {set-var am_depth}

# for bpm
# set start 1
# set end 1024
# set cmd {set-bpm {gl gr}}

# for modulating key from C to G
# set start $C
# set end $G
# set cmd key

proc input-changed {name ops value} { ;# input mode has changed, create suitable procedures (procs)

	global input procs

	if {$input eq "midi"} {
		eval $procs(midi) ;# create procedures to use MIDI
	} elseif {$input eq "mouse"} {
		eval $procs(mouse) ;# create procedures to use mouse
	} else { ;# too bad
		set-text-color 1 0 0;
		echo "bad input mode"
	}
}

trace add variable input write input-changed ;# setup trace that calls input-changed when user sets input

set input mouse ;# input mode is mouse --> when mouse is at the bottom of din board fm_depth = start, when at top fm_depth = end




