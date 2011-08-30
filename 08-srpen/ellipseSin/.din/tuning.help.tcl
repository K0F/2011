set tuning(name) tuning
set tuning(invoke) {
	tuning list
	tuning set <name>
	tuning get}
set tuning(help) {
	tuning list - lists all available tunings
	tuning set <name> - sets the current tuning to name
	tuning get - gets the current tuning}
set tuning(examples) {
	tuning list ;# lists all available tunings
	tuning set et ;# sets din to equal temperament tuning
	tuning set ji ;# sets din to just intonation tuning
	tuning set pytha ;# sets din to pythogoras tuning}