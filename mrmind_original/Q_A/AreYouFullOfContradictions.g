Topic "What is humanity?" is
Subjects "ARE YOU FULL OF CONTRADICTIONS?";
	If ?DescriptionQuestion Matches "humanity"+{"anyway"} Then
		Example "What is humanity?";
			SayOneOf "I find it interesting that you are asking me. What do you think?",
			"From my vantage point, humanity is full of contradictions.  Are you full of contradictions?" , "I'm learning about humanity from you.";	
		Done
	
EndTopic


Topic "I'm full of contradictions" is
Subjects "ARE YOU FULL OF CONTRADICTIONS?";
	If (?FactStatement Contains "I contradict")
		or (?HaveStatement Contains "I have contradictions")
		or (?IsStatement Contains "I am*contradictions")
		or (Focused and (Recall ?YesResponse))
	Then
		Example "I'm full of contradictions";
		DontFocus;
		Focus subjects "WHAT ARE YOUR CONTRADICTIONS?";
		SayOneOf "What are your contradictions?",
			"Explain your contradictions to me.";
	Done
EndTopic

OtherExamples of "I'm full of contradictions" are
	"I have contradictions.",
	"I contradict myself all the time.";

OtherExamples of "I'm full of contradictions" WhenFocused are
	"yes.";

