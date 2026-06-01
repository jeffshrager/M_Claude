Topic "Computers Don't Have" is
Subjects "ComputersCan't","ComputerTraits";

	If ?AnyStatement Contains (COMPUTER,AILIFE,BOTS) and Heard ("don't have #","do not have #")
	Then
	
		Example "Machines don't have legs!";
		
		Say "Do you have " + #1 + "?";
		WaitForResponse;
		If ?WhatUserSaid Matches AFFIRMATIVE
		Then
			Say "What is human about that?";
			Focus "Humans Are";
		Done
		
		If ?WhatUserSaid Matches NEGATIVE
		Then
			Say "Well, if I don't, and you don't either, that doesn't help me believe you're human.";
		Done
		
		Say "It would help me if you would answer yes or no.";
		TryAgain
	
EndTopic	 
