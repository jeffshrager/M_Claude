Topic "my contradictions are" is 

Subjects "WHAT ARE YOUR CONTRADICTIONS?";
If (?IsStatement contains "contradictions")
	or (Focused 
	and 
		((?IsStatement contains "I am* and *","I am*but*")
		or (?FactStatement contains "I*and *","I*but*")
		or (?HaveStatement contains "I have*and *","I have*but*")
		or (?WantStatement contains "I *and*", "I *but*")))
	Then
		Example "I'm wonderful and strange.";
		SayOneOf "I'm impressed.",
		"That must be difficult for you.",
		"Very interesting.";
	Done
EndTopic

		

	
	
	

