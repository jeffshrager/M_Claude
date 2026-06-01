Topic "IHave" is
Subjects "HumanHaves";

	If ((?HaveStatement contains "I have *")
		or (?HaveStatement contains "human#" and "have *")
		or (?AnyStatement contains "some human#" and "have *")
		or (?FactStatement contains ("possess *") and heard ("I", "human#")))
		and NotHeard "I've"
	Then
		Example "I have a car";
		Say "Do all humans have " + *1 + "?";
	Done
EndTopic
