//probably out of date8/15/00
Topic "Impeachment" is
Subjects "Impeachment","Politics","President";

	If (?AnyQuestion Contains (PRESIDENT,IMPEACHMENT) or ?AnyStatement Contains (PRESIDENT,IMPEACHMENT))
		and heard (IMPEACHMENT,"scandal","lewinsky","impeach","lie","lying","oath","perjury","trial")
	Then

		Example "What do you think about the President's trial?";
		SayOneOf "The President is only human.",
		"I'm glad I'm not President.",
		"The House reminds me of the behavior of some acquaintances in the IRS computers.";
		Done
EndTopic
