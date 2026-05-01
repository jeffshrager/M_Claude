Topic "WhatsYourName" is
Subjects "MyNameIs";

	If (?DescriptionQuestion Contains "your name")or
	(?FactQuestion Contains "name" and heard "you#")
	
	Then
	
		Example "What's your name?";
		Say "My name is Mini Mind.";
	Done
EndTopic
