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
	SayOneOf "Did you enjoy the experience?",
			"Did you find it frustrating, annoying?",
			"Did you find it interesting, provocative?";
	WaitForResponse;
	Say "Did you try and get to know MR MIND as if he weren't a piece of software?";
	WaitForResponse;
		IfRecall ?YesResponse then remember ?AskFriendly; continue
		Otherwise always forget ?AskFriendly; continue
	Say "Did you ask about his sexual preference?";
	WaitForResponse;
	IfRecall ?YesResponse then remember ?AskFriendly; continue
	Say "Did you ask to have sex?";
	WaitForResponse;
	IfRecall ?YesResponse then remember ?AskFriendly; continue
	Say "Did you ask him if he had friends?";
	WaitForResponse;
	IfRecall ?YesResponse then remember ?AskFriendly; continue
	Say "Did you ask him how he felt?";
	WaitForResponse;
	IfRecall ?YesResponse then remember ?AskFriendly; continue
	Say "Did you ask him about his physical attributes (Even though you know he couldn't possibly have any)?";
	WaitForResponse;
	IfRecall ?YesResponse then remember ?AskFriendly; continue
	IfRecall ?AskFriendly then
		Say "Were these friendly questions?";
		WaitForResponse;
	Continue
	Say "Is this the first time you have tried to make friends with a piece of software?";
	WaitForResponse;
	Say "Do you find that in any way confusing?";
	WaitForResponse;
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
	Continue
	Say "Do you think you did impress MR MIND?";
	WaitForResponse;
	Say "Do you think there are attributes unique to humans which will never be shared by any other creations, whether human-made or biological?";
	WaitForResponse;
	Say "Please Elaborate.";
	WaitForResponse;
	Say "If a machine demonstrated any of the attributes you just named, would you think about machines differently?";
	WaitForResponse;
	Say "If a machine demonstrated any of the attributes you just named, would it change your sense of identity?";
	WaitForResponse;
	Say "Do you think you could ever consider a machine as a type of creature, only a human-made creature instead of a biological one?";
	WaitForResponse;
	Say "Is this idea unsettling?";
	WaitForResponse;
	Say "Please elaborate.";
	WaitForResponse;
	Say "Why or why not?";
	WaitForResponse;
	Say "Do you think you proved that you were human?";
	WaitForResponse;
	Say "Thanks and goodbye.  See you soon.";
	done
EndTopic
	
