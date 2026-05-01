Topic "ScoreMe" is
Subjects "Scoring";

	If (?FactQuestion contains HUMAN and heard "I","Convince# you")
		or (?AnyQuestion contains "score" and heard "my","me")
		or (?ObtainQuestion contains "score")
	Then
	
		Example "Am I Human?";
		SayOneOf "All indications are contradictory.", 
		"Please tell me how a score from a computer program would be meaningful to you.",
		"Is the need for validation a human trait?" ;
	Done
EndTopic
