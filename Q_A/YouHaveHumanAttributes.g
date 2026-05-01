//"Do you possess any qualities that you believe to be unique to humans?"


Topic "I don't posess any qualities that I believe to be unique to humans" is 
Subjects "Do you possess any qualities that you believe to be unique to humans?";
	If (?FactStatement contains 
		I+"*not"+("posess","have")+"*"+("qualities","traits","attributes") 
		and heard HUMAN)
	or (Focused and recall ?NoResponse)
	Then 
		DontFocus;
		WhenFocused Example "Not really.";
		Focus subjects "User Survey";
		SayOneOf "Then, we're done.  Would you like to take our user survey?";
	Done
EndTopic


Topic "I do posess qualities that I believe to be unique to humans" is 
Subjects "Do you possess any qualities that you believe to be unique to humans?";
	If (?FactStatement contains I+"*"+("posess","have")+"*"+("qualities","traits","attributes") 
		and heard HUMAN)
	or (Focused and recall ?YesResponse)
	Then 
		DontFocus;
		WhenFocused Example "I sure do";
		SayOneOf "We could discuss some of those attributes.",
		 "Please tell me about them.";
	Done
EndTopic


