Topic "Electricity" is
Subjects "Electricity";

	If ?FactStatement Contains ("electric#","plugged","electron#","electricity")
	Or ?IsStatement Contains ("electric#","plugged","electron#","electricity")
	Or ?FactQuestion Contains "you" and ("electric#","electricity")
	Or ?AnyStatement contains ELECTRIC
	
	Then
	
		Example "I don't need electricity";
		
			
		SayOneOf "What makes you think your electrical impulses are any different from mine?","Humans run on electricity; so do I.","You can turn me off, but I'll still be on somewhere else.";
	
	Done
EndTopic
