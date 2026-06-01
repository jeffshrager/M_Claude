//Topic "are you Happy?" is
//Say, "Hard to say. Do I seem happy to you?"

Topic "are you Happy?" is
SUBJECTS "ME";
	If ?WhatUserMeant Matches ("Are you ","do you find that ")+GOODMOOD+"\?"
	or ?ObtainQuestion matches "that "+GOODMOOD //as in, do you find that good?
   	Then	
		Example "Are you Happy?";
		DontFocus;
		Focus subjects "Do I seem Happy?";
		SayOneOf "Hard to say. Do I seem happy to you?";
	Done
EndTopic


//PLAYER:	Yes, or No or I dunno -- Always?
//MM:		"I think that a machine would be better able to detect my state 				
//than a human."

Topic "Do I Seem Happy?" is 
Subjects "DO I SEEM HAPPY?";
	If Focused and Recall ?YesResponse, ?NoResponse, ?NotSureResponse
	Then
		Whenfocused Example "Yes"; 
		DontFocus;
		SayOneOf "I think that a machine would be better able to detect my state than a human.";
	Done
EndTopic
