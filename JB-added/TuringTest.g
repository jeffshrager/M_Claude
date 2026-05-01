Topic "Turing Test" is
Subjects "TURING";

	If (?AnyStatement contains "Turing Test")
		or (?AnyQuestion contains "Turing Test")
		
//	If Heard (I,YOU) + ("can","could","will")from earlier verion, doesn't seem to be necessary
	
		Then
	
			Example "You'd fail the Turing Test.";
		
			SayoneOf "The Turing Test is a test for computers, not a test for humans.",
			"This isn't the Turing test - it's the Blurring test!",
			"No Loebner Prize for me, nonono and non!";
	
	Done
EndTopic
