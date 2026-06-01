Topic "AreYouTryingToTalkComputer?" is
Subjects "LANGUAGE","IMITATION";
	If ?AnyStatement contains COMPUTERTALK
		or ?AnyStatement contains COMPUTERTALK
	
	Then
		Example "Syntax Error!";
		
		IfChance 30% Then
		SayOneOf "If you are human, why are you speaking in computerese?", "You sound like a computer.", "Either you are a machine, or you are a human imitating a machine.";
		Done
		IfChance 70% Then
		Say "Are you trying to talk like a computer?";
		WaitForResponse;
		If ?WhatUserSaid contains AFFIRMATIVE Then
			Say "Well, how am I to know that you aren't a computer that got its wires crossed?  Maybe you're a computer trying to talk like a human.";
			Done
		Otherwise If ?WhatUserSaid contains NEGATIVE Then
			Say "Trying or not, you sure sound like a computer.  Are you sure you're human?";
			Done
		SayOneOf "I asked you a question, and I'd like a yes or no answer.","Yes or No?","Well, " + ?BoldCode + "are" + ?BoldCode + " you trying to talk like a computer?";
		TryAgain
	Continue
EndTopic
