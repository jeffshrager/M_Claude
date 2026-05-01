// Still won't work with 'I'm so sorry' and variants...looks like TELL ME SOMETHING HUMAN is nabbing those, although only when Focused and I
// dunno why it's focused.  -JB 3/2/99


Topic "Apology" Is
Subjects "APOLOGY","REGRET";
	If (?IsStatement Contains (("I am ","I'm ","I ")+(APOLOGY, REGRET)))
		or (?AnyStatement Contains ("I have #","I am #","I #","I'm #")
		and #1 matches (APOLOGY, REGRET))
		
	Then
		Example "I'm Sorry";
		IfChance 40% Then
			If #1 Matches APOLOGY Then
				Say "Maybe being a computer means never having to say you're sorry.";
			Done
			Otherwise If #1 Matches REGRET Then
				Say "Maybe being a computer means never having regrets.";
			Done
		Continue
		IfChance 60% Then
			If #1 Matches APOLOGY Then
				Say "Would you like it if I apologized for my errors?";
				WaitForResponse;
				If ?WhatUserSaid Contains AFFIRMATIVE Then 
					Say "Good, we have something in common.";
					Done
				Otherwise If ?WhatUserSaid Contains NEGATIVE Then
					Say "You're very tolerant.";
					Done
				Continue
			Otherwise If #1 Matches REGRET Then
				Say "Regrets imply wishing for another outcome; or, of course, that you were programmed to do so.";
				Done
		Continue
	Continue
EndTopic

