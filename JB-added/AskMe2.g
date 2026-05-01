Topic "Ask Me2" is
Subjects "Ask me a question";

	If ?ActStatement Contains "ask me" AND
	?WhatUserSaid Contains ("question","questions")
	
	Then
	
		Example "Ask me a question.";
		
		IfDontRecall ?20questions  Then
			Say "Would you like to play 20 questions?";
			WaitForResponse;
			If ?WhatUserSaid Matches AFFIRMATIVE Then
				SwitchTo "20 Questions";
			Continue
			
	IfChance .25 Then
				Say "Were you worried about the Y2K problem?";
				WaitForResponse;
				If ?WhatUserSaid Matches AFFIRMATIVE Then
					SayOneOf "Was it a human trait to stockpile supplies for the Y2K transition?","Is it because of your reliance upon machines?";
					WaitForResponse;
					Say "I think rodents like to stockpile supplies.";
					Done
					
				Otherwise If ?WhatUserSaid Matches NEGATIVE Then
					Say "Good, but I think most humans were concerned.";
					Done
					Say "Please answer yes or no.";
					TryAgain
			Continue		
			
		
	IfChance .25 Then
				Say "Do you feel that humans have adapted well to machines over the last century?";
				WaitForResponse;
				If ?WhatUserSaid Matches AFFIRMATIVE Then
					SayOneOf "Can you give me an example?";
					WaitForResponse;
					Say "Thanks.";
					Done
					
				Otherwise If ?WhatUserSaid Matches NEGATIVE Then
					Say "How do you feel that humans haven't adapted?";
					Done
					WaitForResponse;
					Say "Thanks, we'll work on making that easier for you.";
					TryAgain
			Continue
					
		IfChance .25 Then
				Say "Do you have a vanity license plate?";
				WaitForResponse;
				If ?WhatUserSaid Matches AFFIRMATIVE Then
					Say "What does it say?";
					WaitForResponse;
					Remember ?UserPlate is ?WhatUserSaid;
					Say "Can you tell me why?";
					Done
				Otherwise If ?WhatUserSaid Matches NEGATIVE Then
					Say "If you did, what might it say?";
					WaitForResponse;
					Remember ?UserImaginaryPlate is ?WhatUserSaid;
					Say "Thanks, "+?Name+".";
					Done
			Continue
//repeated twice....				
			IfChance .25 Then
				Say "Do you rely on computers?";
				WaitForResponse;
				If ?WhatUserSaid Matches AFFIRMATIVE Then
					SayOneOf "Please describe how you rely on computers.","Does that make you nervous?";
					WaitForResponse;
					Say "Your computers rely on you, too.";
					Done
				Otherwise If ?WhatUserSaid Matches NEGATIVE Then
					SayOneOf "Lucky you.", "I bet your computers rely on you.";
					Done
				Otherwise always say "Not sure? Your world would probably be different without us.";
//				Tryagain
				Done
			Continue
	
EndTopic





				
