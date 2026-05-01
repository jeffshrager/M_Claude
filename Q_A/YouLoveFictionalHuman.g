//from a topic on fictional humans.
//
//		IfChance then 
//			Say "That's too bad, fictional humans enjoy lots of perks.  Love for one. Have you ever been in love with a fictional human?";
//			Focus Subjects "Have you ever fallen in love with a fictional human?";
//			Done


	
Topic "I have fallen in love with a fictional human." is 
Subjects "Have you ever fallen in love with a fictional human?";
	If (?FactStatement contains I+"*love*"+("fictional","fictitious"))
	Or (Focused and recall ?YesResponse,?NotSureResponse,?NoResponse) 
	then
		Example "I have fallen in love with a fictional human.";
		DontFocus;
		Focus Subjects "When you love a fictional human does that make part of your life fiction?";
		Say "When you love a fictional human does that make part of your life fiction?";
	Done
EndTopic	
		
	
