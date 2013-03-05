set save-resonators(name) save-resonators
set save-resonators(short) sre
set save-resonators(purpose) {save resonators in din session to file}
set save-resonators(invoke) {save-resonators <name> <dump-disabled-resonators?>}
set save-resonators(help) {name is expanded to ~/.din/name.res
	if dump-disabled-resonators is 1, does not save disabled resonators}
set save-resonators(examples) {
	sre . 1 ;# overwrite current resonators file and delete disabled resonators
	save-resonators copy ;# save resonators to ~/.din/copy.res
	sre another-copy ;# save resonators to ~/.din/another-copy.res}