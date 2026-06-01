Topic "Color" is
Subjects "I see in color";

	If ?AnyStatement contains ("see","prefer","like") + COLOR OR
	?FactQuestion contains COLOR OR
	?CanQuestion contains COLOR
	
	Then
	
		Example  "I like purple!";
		
		Say "Bots are colorblind.  So are some humans.";
	Done
EndTopic
