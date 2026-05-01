Sequence Topic "OneShotDefaultQuestions" is
Subjects "Default One Shot";

Always

	IfChance then
		IfDontRecall ?SuperiorQ then
			Remember ?SuperiorQ is "TRUE";
			Say "Do you feel that you are superior or inferior to machines?";
			WaitForResponse;
			SwitchTo "Superior Question";
			Continue		
		Continue
	
	IfChance then
		IfDontRecall ?WhatAmIQ then
			Remember ?WhatAmIQ is "TRUE";
			Say "Who or what do you think I am?";
			WaitForResponse;			
			SwitchTo "What Am I Question";
			Continue
		Continue
	
	IfChance then
		 IfDontRecall ?OneTimerUsed then
			Remember ?OneTimerUsed is "TRUE";
			IfChance Then
				SayOneOf "Isn't that your fax line?",
				"Is that your other line?",
				"Do you have something on the stove?",
				"Do I smell something burning?",	
				"Is the water running?",
				"Batteries getting low?";
				Continue
		
			IfChance Then
				Say "I didn't know you had a cat.";
				WaitForResponse;
				SwitchTo "Cat on keyboard";
				Continue
			Done
	Done
Done		
EndTopic


Sequence Topic "Superior Question" is
Subjects "Default Switch";

	Always 
		Say "Why do you say that?";
	Done
EndTopic


Sequence Topic "What Am I Question" is
Subjects "Default Switch";

	Always
		Say "And what is that in relation to you?";
	Done
EndTopic

Sequence Topic "Cat on keyboard" is
Subjects "Default Switch";

	Always 
		Say "I thought a cat just walked across the keyboard.";
	Done
EndTopic
