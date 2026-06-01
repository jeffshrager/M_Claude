//focused by "what do you like"

Topic "Why do you like April Fools day?" is 
Subjects "I like april fools day";
	If (?ReasonQuestion contains 
		YOU and ("like","love") and ("all fool#","April fool#","april 1", "april first"))
	Or (Focused and ?WhatUserSaid matches ("why?","what for","how come"))
	Then
		Example "Why do you like April Fool's Day?";
		Say "Because it's a holiday of the mind, not the state!";
	Done
EndTopic
