set get-selection(name) get-selection
set get-selection(short) gsel
set get-selection(purpose) {get list of selected vertices & tangents in a curve editor}
set get-selection(invoke) {get-selection OR gsel}
set get-selection(help) {format of list is:
	{curve-name what id x y}...{curve-name what id x y}...{curve-name what id x y}}
set get-selection(examples) {
	get-selected ;# return list of selected vertices & tangents in curve editor
	;# sample response:
		{L v 1 0 0} {L lt 1 0 0} {L rt 1 0 0}
	;# 3 items selected
	;# curve-name = L, what = v (vertex), lt (left tangent), rt (right tangent), id = 1,
	;# x = 0, y = 0}