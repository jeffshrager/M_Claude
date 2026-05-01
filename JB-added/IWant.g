//unused ?UserWant
Topic "IWant" is
Subjects "HumanWants";

	If (?WantStatement contains "I want *")
		or (?AnyStatement contains ("obsession","obsessed") and heard "with *")
	Then
		Example "I want to be king";
		Say "Do all humans want " + *1 + "?";
		Remember ?UserWant is *1;
	Done
EndTopic
