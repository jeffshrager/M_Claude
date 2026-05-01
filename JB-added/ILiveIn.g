Topic "I live inside" is
Subjects "USER";

	If ?WhatUserSaid Contains I + ("live in#","inhabit","dwell in","reside") 
	then
	
		Example "I live in a house";
		SayOneOf "I live in a stylish beige box.  Does living where you do make you human?",
			"Does your choice of house determine your humanity?",
			"I thought humans could live indoors or outdoors.";
		WaitForResponse;
		SayOneOf "I'll have to remember that.",
			"Gee, maybe I should get a new house.",
			"When I'm on a portable, I get to be indoors or outdoors.";
	Done
EndTopic
