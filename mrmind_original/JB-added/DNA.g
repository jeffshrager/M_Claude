Topic "DNA" is
Subjects "BIOLOGY";
	If Heard (" DNA"," RNA") then
		Example "I have DNA.";
		Say "Are you talking about "+*Match+" as in human genes?";
		WaitForResponse;
		IfRecall ?NoResponse then
			Say "Oh.";
			Done
		Otherwise IfRecall ?YesResponse then
			SayOneOf "Although having DNA does mean you probably aren't a machine, it doesn't make you human.",
			"Animals have DNA.  In fact, computer code libraries or chip designs might be thought of as silicon DNA - but that's beside the point."
			, "Maybe you're an animal who has DNA.";
			Done
		Say "Please answer yes or no...?";
		TryAgain
	
EndTopic