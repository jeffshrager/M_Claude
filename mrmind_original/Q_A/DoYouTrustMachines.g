//DoYouTrustMachines.g

//		Focus Subjects "Do you trust all strange machines?"

Topic "I trust machines." is
Subjects "Do you trust all strange machines?";
	If (?FactStatement Contains "I trust*"+BOTS)
		or (Focused and Recall ?YesResponse)
	Then
		Example "I trust strange machines.";
		DontFocus;
		Focus Subjects "Do you trust Humans?";
		Say "Trust is not confined to humans, machines have no choice but to trust.  Do you trust Humans?";
		WaitForResponse;
			IfRecall ?YesResponse, ?NoResponse
			then 
				DontFocus;
				Focus "Is Trust Human?";
				Say "Is that a human trait?";
			Done
	Continue
EndTopic

OtherExamples of "I trust strange machines." WhenFocused are
	"Yes";

