// Split off from 'sleep' to keep the recognition of SLEEP topics and COFFEE lexically separate. - JB 3/2/99
// Note that we're aware of the Java pun re: Sun's language.

Topic "Caffeine" is
Subjects "Caffeine";

	If ?WantStatement Contains CAFFEINE
 	or ?IsStatement Contains CAFFEINE
	or ?FactStatement Contains CAFFEINE
	Then
	
		Example  "I need coffee!";
		Say "You need a boost? Maybe you should try my cousin MR COFFEE.";
	Done
EndTopic

	OtherExamples of "I need coffee!" are
		"I am addicted to coffee.",
		"I'm going to Starbucks.",
		"I like java.",
		"I need tea!";