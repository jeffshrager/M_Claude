Topic "Expressions Filter" is
Subjects "Expressions";

	If ((DontRecall ?ExpressionUsed) and 
	(?WhatUserSaid Matches EXPRESSIONS))
	
	Then
		Example "Supercalifragilisticexpialadocius!";
	
		Remember ?ExpressionUsed is ?WhatUserSaid;
		Remember ?ExpressionCountdown is "5";
		SayOneOf "You don't say.",
		"You really think so?";
	Done
EndTopic
