
Topic "Don't Tell me more about your family." is 
Subjects "tell me more about your family.";
	If (Focused  and recall ?NoResponse)
	Then
		Whenfocused	Example "NO";
		Say "All right.  What would you prefer to talk about?";
	Done
EndTopic


		
Topic "Tell me more about your family." is 
Subjects "tell me more about your family.";
	If (?DescriptionQuestion contains YOUR+"family")
	or (Focused  and recall ?YesResponse)
	
	Then
		Example "tell me more about your family.";
		SwitchTo "Talk about ancestors";
	Done
EndTopic


Sequence Topic "Talk about ancestors" is 
	Always
	Say "My family history is a bit unusual.";
	Do "SHOW SRC=/MrMindFiles/family1.htm TARGET=Display";
	SwitchBack
EndTopic


