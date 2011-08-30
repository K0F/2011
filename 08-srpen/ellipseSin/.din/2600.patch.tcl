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

	turns a list of very offensive English language words into morse code and 
  applies it as gater patterns when midi sliders/knobs are operated

}

set ::redact 0 ;# print fuck as f*ck if ::redact is 1

proc read-word-list {} {
	;# read banned words list compiled by 2600 magazine: http://www.2600.com/googleblacklist/
	global wordlist
	set wordlist {}
	set f [open ~/.din/2600 r]
	while {[gets $f line] >= 0} { lappend wordlist $line }
	close $f
}

proc midi-cc {status cc value} {

	global wordlist id redact

	set sliders {1 2 3 4} ;# slider ids. change these values to match ids of your midi slider/knobs
	set j 0
	foreach i $sliders {
		if {$cc eq $i} { # matched 1 of the (4) banks of words

			;# find word
			set step [expr $j * 127]
			set id [expr $step+$value]
			set word [lindex $wordlist $id]

			if {$word ne ""} {
				;# print word in pretty random text color
				set-text-color [expr rand()] [expr rand()] [expr rand()]
				if {$redact eq 1} {
					;# redact is 1 so simply replace the vowels with a special char
					set word [string map "a * e # i & o % u !" $word]
					echo $word
				} else {
					echo $word
				}
				do-morse-code $word ;# word -> morse code -> gaters
			}
			return
		}
		incr j
	}

}

proc do-morse-code {str} {
	morse-code [string toupper $str] ;# create morse code bezier curves
	paste-gaters ;# paste the curves into gater left & right
}

read-word-list

