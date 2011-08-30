set curve-library(name) curve-library
set curve-library(short) cl
set curve-library(purpose) {manipulate the curve library attached to current curve editor}
set curve-library(invoke) {curve-library OR cl <operation>}
set curve-library(help) {operation can be:
	add OR a -- add selected curve to library
	delete OR d -- delete current curve in library
	update OR u -- replace current curve in library with selected curve
	insert OR i -- insert selected curve into library at current curve position}
set curve-library(examples) {
	cl d ;# delete current curve in library
	curve-library add ;# add selected curve to library}