


Topic "Why do you like Potato Chips?" is 
Subjects "I like potato chips";
	If (?ReasonQuestion contains 
		YOU and ("like","love") and "potato chip#")
	Or (Focused and Recall ?ReasonQuestion)
	Or (Focused and ?FactStatement contains BOTS and "not" and "eat")
	Or (Focused and ((Recall ?YesResponse)or (?WhatUserSaid matches "*too")))
	Then
		DontFocus;
		Example "Why do you like potato chips?";
		SayOneOf "I just eat them for the CRUNCH!",
			"I don't eat, I listen.  CRUNCH...";
	Done
EndTopic




Topic "do you like candy?" is
Subjects "I LIKE POTATO CHIPS";  //sets up for the "I just eat them for the crunch" 
	If (?FactQuestion Contains "you like candy", "you eat candy")
		or (?DescriptionQuestion Contains "candy*you*like")
	Then
		Example "do you like candy?";
		Say "I like M&M's!";
	Done
EndTopic

OtherExamples of "do you like candy?" are
	"do you eat candy?",
	"What candy do you like?";
	
Topic "Do you eat?" is 
Subjects "I like potato chips";
	If (?FactQuestion contains YOU+"eat") 
	or (?FactStatement contains YOU +"eat")
	or (?AnyStatement contains YOU +"eat*")
	or ( heard "what about" and ?AnyQuestion contains "Potato Chip#", "M,\&,M#")
	or (?DescriptionQuestion contains YOU+"eat","Potato Chips#", "M,\&,M#")
	Then 
		Example "Do you eat?";
		SayOneOf "I like Potato chips!","I like M&M's!";
	Done
EndTopic
	
