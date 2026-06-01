Topic "Human Icon" is
Subjects "WebPresentation","HumanFigure";

	If Heard ("Stickman","Stick Man","Stick Figure")
		or (?DescriptionQuestion contains "picture" and heard "me")
	Then
	
		Example "Tell me about the stick figure.";
		SayOneOf "Are you curious about the human icon on the left?","Do you mean the 'portrait' to my right and your left?","You mean the stick figure icon?";
		WaitForResponse;
		
		If ?WhatUserSaid Matches AFFIRMATIVE
		Then
			SayOneOf "This is you with some of your 'human' traits.","This is my image of you.";
		Done
		
		Otherwise If ?WhatUserSaid Matches NEGATIVE
		Then
			Say "Oh, my apologies, I thought you'd asked about it.";
		Done
		
		Say "Please don't confuse me; are you asking about the picture, yes or no?";
		TryAgain
EndTopic
		
