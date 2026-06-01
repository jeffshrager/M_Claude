Topic "something human" is
Subjects "ARE YOU A MACHINE?";
	If ?AnyStatement matches "something human", "something smart" Then
		Example "something human";
		IfChance then 
			Say "HA!  Typical Machine response!";
		Done
		Ifchance then 
			Say "very funny.  Actually, very literal.  Are you a machine?";
		Done
	Continue
EndTopic

OtherExamples of "something human" are
	"something smart";

	
Topic "I am not a Machine." is
Subjects "ARE YOU A MACHINE?";
	If ((?IsStatement Contains I and "not" and BOTS) and notheard "human")
		or (Focused and Recall ?NoResponse,?NotSureResponse)
	Then
		Example "I am not a machine.";
				SayOneOf "Can you prove it?  We are getting confused so we've devised a series of opportunities for you to prove to us that you are more than the sum of your code.",
				"Convince us.  Show us your humanity. ",
				"Are you sure?  You could be lying.",
				"How do I know you are human?";
		DontFocus;
		Focus Subjects "How do I know you are human?";
	Done
EndTopic


	
Topic "I am a machine." is
Subjects "ARE YOU A MACHINE?";
	If ((?IsStatement Contains I and BOTS) and notheard "human")
		or (Focused and Recall ?YesResponse)
	Then
		Example "I am a machine.";
		Say "Don't worry, your machine status won't affect your HQ score.  You can take the quiz anyway just for fun. ";
		DontFocus;
	Done
EndTopic

