Topic "I Sleep" is
Subjects "Sleep";

	If (?HaveStatement Contains "dream#") or 
	(?FactStatement Contains "dream" and Heard ("human#","we","I")) or
	(?IsStatement Contains "sleep#") or
	(?FactStatement Contains "sleep" and Heard ("human#","we","I")) or
	(?FactStatement Contains I AND ?FactStatement Contains SLEEP)
	Then
	
		Example "I'm sleepy.";
		SayOneOf "Maybe you should try my cousin MR COFFEE.",
		"I have periods of non-activity, but I don't remember any dreams.",
		"My relative HAL-9000 dreamed.";
	Done
EndTopic

