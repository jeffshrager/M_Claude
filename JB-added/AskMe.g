Topic "Ask Me" is
Subjects "Ask me a question";

	If ?ActStatement Contains "ask me" AND
	?WhatUserSaid Contains "question"
	
	Then
	
		Example "Ask me a question.";
		

		IfDontRecall ?20questions  Then
			Say "Would you like to play 20 questions?";
			WaitForResponse;
			If ?WhatUserSaid Matches AFFIRMATIVE Then
				SwitchTo "20 Questions";
			Done
			Otherwise If ?WhatUserSaid Matches NEGATIVE Then
				SwitchTo "Random Questions";
			Done
			Say "Please answer yes or no!";
			TryAgain
	Continue
EndTopic
		

//this topic doesn't see to be used.
Sequence Topic "Random Questions" is
Subjects "Ask me a question";

	Always
		SayOneOf "Okay, I'll just ask you one of my favorites.","Well then, answer just one for me.";
		
	//	IfChance Then
	//			Say "Were you worried about the Y2K problem?";
	//			WaitForResponse;
	//			If ?WhatUserSaid Matches AFFIRMATIVE Then
	//				SayOneOf "Is it a human trait to stockpile supplies for the Y2K transition?","Is it because of your reliance upon machines?";
	//				WaitForResponse;
	//				Say "Well, that is something I'll have to think about.";
	//				Done
	//				
	//			Otherwise If ?WhatUserSaid Matches NEGATIVE Then
	//				Say "I'm not too worried for myself- I've been Y2K certified, I think.";
	//				Done
	//			Otherwise always Say "Please answer yes or no.";
	//			TryAgain
	//		Continue
		
		IfChance Then
				Say "Do you have a vanity license plate?";
				WaitForResponse;
				If ?WhatUserSaid Matches AFFIRMATIVE Then
					Say "What does it say?";
					WaitForResponse;
					Remember ?UserPlate is ?WhatUserSaid;
					Say "Thank you, " + ?Name+".";
					Done
				Otherwise If ?WhatUserSaid Matches NEGATIVE Then
					Say "If you did, what might it say?";
					WaitForResponse;
					Remember ?UserImaginaryPlate is ?WhatUserSaid;
					Say "Thanks, "+?Name+".";
					Done
			Continue
				
		IfChance Then
				Say "Do you rely on computers?";
				WaitForResponse;
				If ?WhatUserSaid Matches AFFIRMATIVE Then
					SayOneOf "Please describe how you rely on computers.","Does that make you nervous?";
					WaitForResponse;
					Say "Hmm.";
					Done
				Otherwise If ?WhatUserSaid Matches NEGATIVE Then
					Say "I wonder how many people do.";
					Done
				Otherwise always say "Please answer yes or no.";
				TryAgain
		Continue
	Done	
EndTopic
					
