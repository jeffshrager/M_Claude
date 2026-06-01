Topic "User Gender" is
Subjects "GENDER";
	
	If ((?IsStatement Contains (MALE,FEMALE) or ?AnyStatement Contains (MALE,FEMALE)) 
	and heard ("I'm a #", "I'm #","I am a #","I am #","talking to a #","dealing with a #"))
	
	Then
		Example "I'm a guy";
		IfRecall ?UserStatedGender  //if we already have a value, let's see if it contradicts...
	
		Then
			If #1 Contains MALE Then
				If ?UserStatedGender DoesNotMatch MALE //if the user has contradicted our stored gender...
				Then
					Say ("I thought you told me you were " + ?UserStatedGender + "!");
					Remember ?UserStatedGender is "male";
				Done
				// if user said male last time, then...
				Say "Right.  You told me that.";
				Done
			Otherwise If #1 Contains FEMALE Then
				If ?UserStatedGender DoesNotMatch FEMALE //if the user has contradicted our stored gender...
				Then
					Say ("I thought you told me you were " + ?UserStatedGender + "!");
					Remember ?UserStatedGender is "female";
				Done
				//If user said female last time, then...
				Say "Right.  You told me that.";
				Done
			//and, in case of odd other cases (no, I'm a type-Q Orthoguy from BetaZeen)
			Say "Hmmm.  I'm a bot.  But I'm trying to find out if you're human.";
		Done
		
		//If we don't already have a gender, then...
		If #1 Contains MALE
		Then
			Say "Thanks, fella. Of course, bots have gender too; look at my name.";
			Remember ?UserStatedGender is "Male";
			Done
		Otherwise if #1 Contains FEMALE
		Then
			Say "Thanks sis. Of course, bots have gender too; look at my name.";
			Remember ?UserStatedGender is "Female";
			Done
	Continue
EndTopic

