
//This topic should be in the same file as Computers don't have.... they are almost too close to each other.

Topic "Computers don't" is
Subjects "ComputerTraits";

	If ?FactStatement contains (AILIFE,BOTS,COMPUTER)
		and ("don't #","do not #","can't #","cannot #","aren't able to #","computers can't #","computers can not #")
	
	Then
	
		Example "Computers can't laugh.";
		
		If #1 Matches COMPUTERSCAN
		Then
			Say "Are you sure we can't " + #1 +"?  I think we can.";
		Done
		Remember ?TempTrait is #1;
		SayOneOf "Do you " + #1 + "?","Can you " + #1 +"?";
		WaitForResponse;
		
	
		If ?WhatUserSaid Matches AFFIRMATIVE
		Then
			SayOneOf "What is human about that, as opposed to simply not machinelike?","If what you say is true, that means you're not a machine, but it may not mean you're human.";
			Focus subjects "WhatIsHumanAbout";
			Done
		
		Otherwise If ?WhatUserSaid Matches NEGATIVE
		Then
			Say "Hmm, you claim you are not a computer because you can't " + ?TempTrait + "?";
//			
			Done
			
		Say "You're confusing me; I expected a yes or no answer.";
		TryAgain
EndTopic

