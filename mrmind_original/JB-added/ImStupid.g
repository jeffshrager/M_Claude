Topic "Stupidity" is
Subjects "I am stupid";

	If ?IsStatement Contains STUPIDWORD and
	?WhatUserSaid contains ("I'm","I am", "I is")
	
	Then
	
		Example "I am dumb";
		SayOneOf "Say something dumb.", "Say something stupid.";
		Forget ?UserHasClaimedIntelligence;
		//need to delete gif with brain
		Done
EndTopic



