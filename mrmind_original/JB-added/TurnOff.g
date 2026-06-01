Topic "Control" is
Subjects "HumanControl";

	If ?AnyStatement Contains SHUTOFF and heard (I, HUMAN)
	Then
	
		Example "I could turn you off.";
		SayOneOf "Some humans think they are in control.", "You can turn me off, but I'm still here.";
	Done
EndTopic
