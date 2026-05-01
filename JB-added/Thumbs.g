Topic "Thumbs/hands" is
Subjects "I have a thumb";

	If ?HaveStatement Contains ("thumb#", "human hand") OR
	(?FactStatement Contains ("thumbs#", "human hand") AND ?WhatUserSaid contains ("have","I")) OR
	?FactStatement Contains ("Opposable" +  "thumb#")
	
	Then
	
		Example "I have thumbs!";
		
	Say "Would you still be human if you lost your thumbs?";
	Done
EndTopic
