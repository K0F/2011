set find-scale(name) find-scale
set find-scale(purpose) {find a scale matching a pattern}
set find-scale(invoke) {find-scale <pattern>}
set find-scale(help) {
	pattern is a regular expression pattern.}
set find-scale(examples) {
	find-scale m* ;# find scales with name starting with letter m
	find-scale {[0-9]*} ;# find all scales with name starting with a number
	find-scale ???? ;# find all scales with exactly 4 characters in their name.}