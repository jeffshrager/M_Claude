Topic "You repeat" is
Subjects "MR MIND";

	If ((?FactStatement contains REPETITION) or (?OtherStatement contains REPETITION)) and 
	?WhatUserSaid contains (I,"you"," u ")
	
	Then
	
		Example "You keep repeating answers.";
		
		SayOneOf "I see you can detect repetition.",
		"Repetition is central to learning.",
		"I hate being in a rut.  Can we talk about something else?",
		"I'm sorry, we must be having a misunderstanding.";
	Done
EndTopic


Topic "I'm still repeating" is
Subjects "User behavior";

	If ?WhatUserSaid Matches ?WhatUserSaidBefore and
	IfRecall ?InALoop
	
	Then
		SayOneOf "Do you mean to repeat yourself?","You seem to be in a loop.",
			"And I thought bots were repetitive.",
			"I have it!  You're not human, you're a broken record!",
			"How does repeating yourself prove your humanity?";
		Forget ?InALoop;
	Done
EndTopic

Topic "I'm repeating" is
Subjects "User behavior";

	If ?WhatUserSaid Matches ?WhatUserSaidBefore
	
	Then
		Remember ?InALoop is "yes";
		SayOneOf "Didn't you just say that?",
			"Maybe our messages crossed, you seem to be repeating yourself.";
	Done
EndTopic


