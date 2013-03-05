set list-patches(name) list-patches
set list-patches(short) lp
set list-patches(purpose) {list patches in din}
set list-patches(invoke) {list-patches OR lp [style]}
set list-patches(help) {style of listing can be:
	vertical or v
	...
	default is horizontal listing}
set list-patches(examples) {
	list-patches ;# lists all available patches on 1 line
	list-patches v ;# list 1 patch per line}
