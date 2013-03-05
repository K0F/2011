set bot(name) bot
set bot(short) :
set bot(purpose) {din irc bot}
set bot(invoke) {
	bot connect OR c <server> <name> <channel> <key>
	bot disconnect OR d <message>
	bot prefix OR p <prefix>}
set bot(help) {
	server is the irc server
	name is the bot name
	channel is the channel to join
		note: dont include # in channel name
	key is the password for the channel
	...
	bot allows access to your whole file system so will connect
	to password protected channels only. only use it among friends.}
set bot(examples) {
	bot connect irc.dinisnoise.org bot din letmein;# connects to irc.dinisnoise.org as bot and joins #din with password letmein
	bot d {i'm finished} ;# disconnect with a leaving message
	bot prefix alice ;# prefixes each message with alice:
	: happy deepavali folks ;# sends happy deepavali folks to channel}