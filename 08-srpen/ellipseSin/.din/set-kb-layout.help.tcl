set set-kb-layout(name) set-kb-layout
set set-kb-layout(short) skb
set set-kb-layout(purpose) {set keyboard layout}
set set-kb-layout(invoke) {set-kb-layout OR kbl [name]}
set set-kb-layout(help) {
	name can be:
		us or usa
		gb or uk}
set set-kb-layout(examples) {
	set-kb-layout us ;# us layout
	set-kb-layout uk ;# uk layout
	kbl ;# print current layout}