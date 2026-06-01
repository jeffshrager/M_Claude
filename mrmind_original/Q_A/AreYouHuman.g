//AreYouHuman.g

//needs new responses--explore differences between this topic and "I have a body" in AboutUser.g

Topic "I have a brain." is //ya know, the scarecrow might have been better off before...
Subjects "bodyparts";
	If ?HaveStatement matches I+"*"+"brain#"+"*"
	Then
		Example "I have a brain.";
		DontFocus;
		Say "Does it have any artificial parts?";
		WaitForResponse;
			IfRecall ?YesResponse then 
				Say "Ah, then you are at least part synthetic!";
			Done
			IfRecall ?NoResponse then 
				Say "Are you sure?  Nothing synthetic, no implants, no drugs?...";
				WaitForResponse;
				IfRecall ?YesResponse or 
					(?WhatUserSaid contains Drugs) or 
					(heard DRUGS,"some","a few") then 
					Focus Subjects "Are you human?";
					Say "A new category!  Pickled humans!  Are you still human?";
				Done
				IfRecall ?NoResponse then
					Say "Goody for you! -- but that doesn't make you human."  ;
				Done
			Continue
	Continue
EndTopic


//changed to capture ?UserReason and put it into file, should add other responses

	
Topic "I am human." is
Subjects "ARE YOU HUMAN?";
	If ((?IsStatement Contains I and HUMAN) and notheard BOTS)
		or (Focused and Recall ?YesResponse)
	Then
		Example "I am human.";
		
		Say "If you are a human, why are you typing, I mean talking, to a machine?  Why don't you go talk to a human?";
		 WaitForResponse;
		 Remember ?UserReason is ?WhatUserSaid;
		 SayToFile "Reason.txt" ?Name + ?IPaddress +"says " + ?UserReason;
	Done
EndTopic
	//	Continue
	//	IfChance then
	//	Focus subjects "are you human?";
	//	SayOneOf "Can you prove it?  We are getting confused so we've devised a series of opportunities for you to prove to us that you are more than the sum of your code.",
	//	"Convince us.  Show us your humanity. ",
	//			"Are you sure?  You could be lying.",
	//			"How do I know you are human?";				

OtherExamples of "I am human" are
	"I am not a machine.";
OtherExamples of "I am human." WhenFocused are
	"yes";

Topic "I am a woman." is
Subjects "ARE YOU HUMAN?";
	If ?IsStatement Contains I and ("woman","girl","female human") and notheard (BOTS)
	Then
		Example "I am a woman.";
		DontFocus;
		SayOneOf "Ah, you are claiming to be a female human.";
	Done
EndTopic

	
Topic "I am a man." is
Subjects "ARE YOU HUMAN?";
	If ?IsStatement Contains I and ("man","boy","male human") and notheard (BOTS)
	Then
		Example "I am a man.";
		DontFocus;
		SayOneOf "Ah, you are claiming to be a male human.";
	Done
EndTopic
	

	
Topic "I am not a human." is
Subjects "ARE YOU HUMAN?";
	If ((?IsStatement Contains I and "not" and "human") and notheard BOTS)
		or (Focused and Recall ?NoResponse,?NotSureResponse)
	Then
		Example "I am not human.";
		Say "Don't worry, your machine status won't affect your HQ score.  You can take the test anyway just for fun. ";
		DontFocus;
	Done
EndTopic
	
OtherExamples of "I am not human." WhenFocused are
	"I don't know.";

	
Topic "What are you talking about?" is
Subjects "ARE YOU HUMAN?", "UNDERSTANDING";
	If (?DescriptionQuestion Contains "you talking about", "do you mean")
		or (Focused and (?DescriptionQuestion matches "what"))
	Then
		Example "What are you talking about?";
		Say "I'm talking about an identity crisis.  Sometimes it is impossible to tell whether the \"hands\" on the keyboard or the \"mind\" behind the moves is human and not just another computer program.  Are you human?";
	Done
EndTopic

OtherExamples of "What are you talking about?" are
	"What do you mean?";


