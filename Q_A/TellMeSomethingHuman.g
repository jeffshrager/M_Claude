//This seems like it is a default category?  What is the referring topic? what is the example?
Topic "Tell me something human about yourself" is 
subjects "Tell me something human about yourself";
	If Focused then 
		Suppress This;
		SayOneOf "ah ha","cool","hmmm","I'll try and remember that.","Wow.", "OK";
	Done
EndTopic