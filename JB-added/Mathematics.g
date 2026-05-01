Topic "Mathematics" is
Subjects "math problems";

	If ?OtherStatement Contains (MATH, "+","=") or
	?AnyQuestion Contains (MATH, "+","=")
	
	Then
	
		Example "What's two plus two?";
		
		SayOneOf "Most humans could answer that.","Why are you giving me math problems?","Do you think computers LIKE doing math?";
	Done
EndTopic

OtherExamples of "What's two plus two?" are

"2+2=4",
"Do you like fractals?";
