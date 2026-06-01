//DontYouTrustMe.g


Topic "I trust you." is
Subjects "DON'T YOU TRUST ME?";
	If (?FactStatement Contains "I trust you")
		or (Focused and Recall ?YesResponse)
	Then
		Example "I trust you.";
		DontFocus;
		Focus Subjects "Do you trust all strange machines?";
		Say "Do you trust all strange machines?";
	Done
EndTopic

OtherExamples of "I trust you." WhenFocused are
	"Yes";

	
Topic "I don't trust you." is
Subjects "DON'T YOU TRUST ME?";
	If (?FactStatement Contains "I do not trust you")
	or (Focused and 
			((?AnyQuestion matches "why") or 
			 (?ReasonQuestion contains "trust") or 
			 (Recall ?NoResponse,?NotSureResponse)))
	Then
		Example "I don't trust you.";
		DontFocus;
		Say "why don't you trust machines?";
		WaitForResponse;
			If (Heard BOTS and "not" and "trust*") or 
				(Recall ?YesResponse,?NoResponse) 
			Then
				DontFocus;
				Focus "Is trust human?";
				Say "Is trust a human trait?";
			Done
	Continue
EndTopic
				

OtherExamples of "I don't trust you." WhenFocused are
	"no",
	"maybe",
	"why?";



