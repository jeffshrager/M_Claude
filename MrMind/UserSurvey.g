//UserSurvey.g

Topic "User Survey" is 
Subjects "User Survey";
IfHeard "User Survey" then 
	Example "User Survey";
	SayOneOf "Would you like to take the user survey now?";
	Done
EndTopic


Topic "I want to take the user survey" is 
Subjects "User Survey";
	If (?WantStatement contains "user survey" and notheard "NOT")
	or (Focused and recall ?YesResponse)
	Then 
		Example "I want the user survey.";
		SwitchTo "Exit Survey";
	Done
Endtopic
	
Topic "I don't want to take the user survey" is 
Subjects "User Survey";
	If (?WantStatement contains "user survey" and heard "NOT") 
	or (Focused and recall ?NoResponse) 
	Then
		Example "I don't want to take the user survey.";
		SayOneOf "That's okay, if you want to take the user survey later, just log on and ask me for it. ";
	Done
EndTopic
		

Sequence topic "Exit Survey" is 
Always
	Remember ?NoSurvey;
	Say "Is this the first time you've ever had a conversation with a piece of software?";
	WaitForResponse;
	IfRecall ?NoResponse then 
		Say "Is this something you do often or is it relatively rare?";
		WaitForResponse;
	Continue

	Say "Did you enjoy the experience?";
		WaitFOrResponse;

	Say "Did you find it interesting, provocative?";
		WaitForResponse;
	
	Say "Did you find it frustrating, annoying?";
		WaitForResponse;

	Say "Were you generally friendly with MR MIND?";
		WaitForResponse;
		IfRecall ?YesResponse then
			Say "Is this the first time you have tried to get to know a piece of software?";
			WaitForResponse;
		Continue
		
		Say "Do you find that in any way confusing?";
		WaitForResponse;
		
	Say "When MR MIND wasn't able to respond as you'd hoped to your statements, did you become angry or abusive?";
		WaitForResponse;
		IfRecall ?YesResponse then
			Say "When humans or animals aren't able to respond to you as you'd expect, do you become angry or abusive?";
			WaitForResponse;
		Continue
		
	Say "Did you try to fool or get the best of MR MIND by typing in nonsense sentences?";
		WaitForResponse;
		IfRecall ?YesResponse then
			Say "Is this the first time you've intentionally tried to fool a machine?";
			WaitForResponse;
		Continue
	
	Say "Did you try to impress MR MIND?";
		WaitForResponse;
		IfRecall ?YesResponse then
			Say "Is this the first time you've intentionally tried to impress a machine?";
			WaitForResponse;
			Say "Do you think you did impress MR MIND?";
			WaitForResponse;
		Continue
		
	Say "Do you think there are attributes unique to humans which will never be shared by any other creations, whether man-made or biological?";
		WaitForResponse;
		Say "Please elaborate.";
		WaitForResponse;
		
	Say "If a machine demonstrated any of the attributes you just named, would you think about machines differently?";
		WaitForResponse;
		
	Say "If a machine demonstrated any of the attributes you just named, would it change your sense of identity?";
		WaitForResponse;
		Say "Is this idea unsettling?";
		WaitForResponse;
		
	Say "Do you think you could ever consider a machine as a type of creature, only a human-made creature instead of a biological one?";
		WaitForResponse;
		Say "Is this unsettling?";
		WaitForResponse;
		Say "Please elaborate.";
		WaitForResponse;
		Say "Why or why not?";
		WaitForResponse;
		
	Say "Do you think you proved that you were human?";
		WaitForResponse;
		
	Say "Thanks and goodbye.  Please send any and all comments to MRMIND@weblab.org.";
		
	done
EndTopic
	
