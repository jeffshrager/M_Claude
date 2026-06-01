//  From a default response...

//	Say "What does that have to do with your humanity?";
//	Focus subjects "What does that have to do with your humanity?";


Topic "What does that have to do with your humanity?" is 
subjects "What does that have to do with your humanity?";
	If Focused then 
		DontFocus;
		SayOneOf "I'm make a note of that.","Tell me more.","Why is that human?",
		"I'll try and remember that.","Wow.", "OK";
	Done
EndTopic
