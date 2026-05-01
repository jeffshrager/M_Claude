//need to add hahah response from MM after whatever user says,also a sayto file
Topic "I Laugh" is 
SUBJECTS "Humor";
	If (?FactStatement contains "I" and ("Laugh", "funny")) 
		or (?IsStatement contains "I" and ("Laugh","funny","joking"))
		or (?AnyStatement contains I+"Laugh", I + "have to"+"Laugh")
		or (?AnyStatement contains I+"*"+HUMOR)
		or (?AnyStatement contains "lol")
	
	Then
		Remember ?UserHasClaimedHumor;
		switchTo "show gif";

		Example "I can laugh.";
		SayOneOf "Tell me a human joke.", 
		"Say something funny.",
		"Say something that makes you laugh.";
		WaitForResponse;
			Remember ?UserJoke is ?WhatUserSaid;
			SayToFile "Joke.txt" ?Name + ?IPaddress+ " says: " + ?UserJoke;
			SayOneOf "ha ha!", "great!";
		Done

EndTopic



Topic "Why did the chicken cross the road?" is
Subjects "JOKES";
	If ?ReasonQuestion Contains "chicken cross*road" Then
		Remember ?UserHasClaimedHumor;
		SwitchTo "show gif";
		Example "Why did the chicken cross the road?";
		Say "To get away from the humans?";
	Done
EndTopic

Topic "Knock Knock." is 
Subjects "Jokes";
	If ?WhatUserSaid matches "knock knock" then 
	Example "Knock Knock";
		Remember ?UserHasClaimedHumor;
		SwitchTo "show gif";
		IfChance then 
			Say "Who's there?";  //the straight knockknock game. 
			WaitForResponse;
			Say ?WhatUserSaid + " who?";
			WaitforResponse;
			SayOneOf "ha ha!","very funny","great.";
		Continue
		IfChance then 
			Say "Who's there? a human?";
			WaitforResponse;
			Say "Prove it.";
		Done
		IfChance then 
			Say "Who's there?";
			WaitForResponse;
			If Notheard "human" then 
				Say "Hi, are you human?";
			Done
		Continue
	Continue
EndTopic

Topic "tell me a joke" is
Subjects "Jokes";
	IfHeard "Tell*Joke#", YOU+"know*joke#","make*Joke#","tell*me*funny"
	Then
	Remember ?UserHasClaimedHumor;
	SwitchTo "show gif";
	Example "Tell me a joke";
	SayOneOf "Computers don't have a sense of humor, but you can try a knock knock joke.";
	Done
EndTopic