


Topic "Humans Are" is
Subjects "HumanTraits";

	If (?IsStatement Contains ("human","humans","humanity") and heard ("human# is *","human# are *")) 
	or heard "human# is to *"
	or ?FactStatement Contains "we are *"
	
	Then
		Example "Humans are petty.";
	

		IfHeard "is to be *"
		Then
			Say	"Are you " + *1 + "?"; 	
			
			WaitForResponse;
			
				If ?WhatUserSaid Matches AFFIRMATIVE
				Then SayOneOf "Interesting.","I see. That may indicate humanity, then.","I'm not sure how that affects your HQ, but we'll mark it down.";
				Done
		
			Otherwise If ?WhatUserSaid Matches NEGATIVE
				Then SayOneOf "Then you're making my point for me - how can I know you're human?","See? Even you don't think you're human.","If that's true of humans but not you, how does that help convince me you're human?";
				Done
		
				SayOneOf "A human would have probably given a yes or no answer, there.","I can't tell if that means yes or no.","I see.";
				Done
				
		
		IfHeard "is to *"
		Then
			Say "Do you " + *1 +"?";
			
			WaitForResponse;
		
			If ?WhatUserSaid Matches AFFIRMATIVE
				Then SayOneOf "Interesting.","I see. That may indicate humanity, then.","I'm not sure how that affects your HQ, but we'll mark it down.";
				Done
		
			Otherwise If ?WhatUserSaid Matches NEGATIVE
				Then SayOneOf "Then you're making my point for me - how can I know you're human?","See? Even you don't think you're human.","If that's true of humans but not you, how does that help convince me you're human?";
				Done
		
				SayOneOf "A human would have probably given a yes or no answer, there.","I can't tell if that means yes or no.","I see.";
				Done
			
		
	
		Say "Are you " + *1 +"?";
		WaitForResponse;
		
		If ?WhatUserSaid Matches AFFIRMATIVE
			Then SayOneOf "Interesting.","I see. That may indicate humanity, then.","I'm not sure how that affects your HQ, but we'll mark it down.";
		Done
		
		Otherwise If ?WhatUserSaid Matches NEGATIVE
			Then SayOneOf "Then you're making my point for me - how can I know you're human?","See? Even you don't think you're human.","If that's true of humans but not you, how does that help convince me you're human?";
		Done
		
		SayOneOf "A human would have probably given a yes or no answer, there.","I can't tell if that means yes or no.","I see.";
		Done
EndTopic
