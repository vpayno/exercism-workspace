package bob

// Source: exercism/problem-specifications
// Commit: 1904e91 Bob: Cleans up language on a couple of test cases
// Problem Specifications Version: 1.5.0

var testCases = []struct {
	description string
	input       string
	expected    string
}{
	{
		"asking a question",
		"Does this cryogenic chamber make me look fat?",
		"Sure.",
	},
	{
		"asking a numeric question",
		"You are, what, like 15?",
		"Sure.",
	},
	{
		"asking gibberish",
		"fffbbcbeab?",
		"Sure.",
	},
	{
		"question with no letters",
		"4?",
		"Sure.",
	},
	{
		"non-letters with question",
		":) ?",
		"Sure.",
	},
	{
		"prattling on",
		"Wait! Hang on. Are you going to be OK?",
		"Sure.",
	},
	{
		"ending with whitespace",
		"Okay if like my  spacebar  quite a bit?   ",
		"Sure.",
	},
	{
		"shouting gibberish",
		"FCECDFCAAB",
		"Whoa, chill out!",
	},
	{
		"shouting numbers",
		"1, 2, 3 GO!",
		"Whoa, chill out!",
	},
	{
		"shouting with special characters",
		"ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!",
		"Whoa, chill out!",
	},
	{
		"shouting with no exclamation mark",
		"I HATE THE DMV",
		"Whoa, chill out!",
	},
	{
		"shouting",
		"WATCH OUT!",
		"Whoa, chill out!",
	},
	{
		"forceful question",
		"WHAT'S GOING ON?",
		"Calm down, I know what I'm doing!",
	},
	{
		"silence",
		"",
		"Fine. Be that way!",
	},
	{
		"prolonged silence",
		"          ",
		"Fine. Be that way!",
	},
	{
		"alternate silence",
		"\t\t\t\t\t\t\t\t\t\t",
		"Fine. Be that way!",
	},
	{
		"other whitespace",
		"\n\r \t",
		"Fine. Be that way!",
	},
	{
		"talking forcefully",
		"Hi there!",
		"Whatever.",
	},
	{
		"using acronyms in regular speech",
		"It's OK if you don't want to go to the DMV.",
		"Whatever.",
	},
	{
		"no letters",
		"1, 2, 3",
		"Whatever.",
	},
	{
		"stating something",
		"Tom-ay-to, tom-aaaah-to.",
		"Whatever.",
	},
	{
		"statement containing question mark",
		"Ending with ? means a question.",
		"Whatever.",
	},
	{
		"multiple line question",
		"\nDoes this cryogenic chamber make me look fat?\nNo.",
		"Whatever.",
	},
	{
		"starting with whitespace",
		"         hmmmmmmm...",
		"Whatever.",
	},
	{
		"non-question ending with whitespace",
		"This is a statement ending with whitespace      ",
		"Whatever.",
	},
}
