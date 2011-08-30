set get-curve-editor(name) get-curve-editor
set get-curve-editor(short) gced
set get-curve-editor(purpose) {get name of curve editor on a screen number}
set get-curve-editor(invoke) {get-curve-editor OR gced <screen>}
set get-curve-editor(help) {}
set get-curve-editor(examples) {
	get-curve-editor 1 ;# print name of curve editor on screen 1
	get-curve-editor 8 ;# print curve editor on screen 8 (last screen)
	get-curve-editor 9 ;# invalid screen number
	get-curve-editor -1 ;# invalid screen number}