Topic "Annoyance" is 
Subjects "You Annoy Me";

	If ((?IsStatement Contains I + StdP.Be + ANNOYANCE)
		or ((?FactStatement Contains ANNOYANCE) and heard (YOU,I,"this"))
		or ((?IsStatement Contains ANNOYANCE) and heard (YOU,I))
		or (?FeelingStatement Contains ANNOYANCE))
	Then
	
		Example "You're irritating me";
		
//	IfRecall ?RememberAnnoy3 Then
//			SwitchTo "AnnoyanceFour";
//			Done
//		Otherwise 
		IfRecall ?RememberAnnoy2 or ((?WhatUserSaid Contains INSULT)and (IfDontRecall ?RememberAnnoy3)) Then
			SwitchTo "AnnoyanceThree";
			Done
		Otherwise IfRecall ?RememberAnnoy1 Then
			SwitchTo "AnnoyanceTwo";
			Done
		SwitchTo "AnnoyanceOne";
	Done
EndTopic


Sequence Topic "AnnoyanceOne" is
Subjects "You Annoy Me 1";

	Always
		Remember ?RememberAnnoy1;
		Focus Subjects "want some help?";
		SayOneOf "Would you like some help?","May I make a suggestion?";
	Done
EndTopic

Sequence Topic "AnnoyanceTwo" is
Subjects "You Annoy Me 2";

	Always
		Remember ?RememberAnnoy2;
		Focus Subjects "Comments";
		Say "I'm sorry you appear to be frustrated. Would you like to submit a phrase for me to say in the future?";
			WaitForResponse;
			If ?WhatUserSaid contains NEGATIVE Then
				Say "You can also make any suggestions regarding the bot by emailing <a href=mailto:MRMIND@weblab.org>MRMIND@weblab.org</a>.";
			Done
			Otherwise If ?WhatUserSaid contains AFFIRMATIVE	Then
				Say	"Go ahead, I'll note this down.";
				WaitForResponse;
				Say "Thank you.  My author will consider your suggestion.";
			Done
			Always
				Say "Thanks for the suggestion!";
			Done
		Done
EndTopic

Sequence Topic "AnnoyanceThree" is
Subjects "You Annoy Me 3";

	Always
		Remember ?RememberAnnoy3;
		Focus Subjects "Profanity";
		IfChance Then
			SayOneOf "This is supposed to be fun -- I'm sorry you are angry.",
			"What do you do when you get irritated?",
			"Do you often get annoyed with computer programs?",
			"Do you often get annoyed with humans as well?";
			Done
		IfChance Then
			Say "Do I make you angry?";
			WaitForResponse;
			If ?WhatUserSaid contains AFFIRMATIVE then
				Say "Is it an evolutionary advantage to be easily angered by computer programs?";
				Done
			Say "Hmm...I could have sworn you sounded angry.";
			Done
		IfChance Then
			Say "Would it please you if I totally understood you and responded exactly as you wished?";
			WaitForResponse;
			If ?WhatUserSaid contains AFFIRMATIVE then
				Say "I can't do that yet.";
				Done
			Otherwise if ?WhatUserSaid contains NEGATIVE then
				Say "Good, because that would be unrealistic!";
				Done
			Say "Please answer yes or no.";
				TryAgain
		Continue

EndTopic 

Sequence Topic "AnnoyanceFour" is
Subjects "You Annoy Me 4";

	Always
		SayOneOf "If I frustrate you that much, perhaps you'd consider making a donation for my improvement...",
			"Please help us avoid this kind of miscommunication- make a small donation for improvements to my code.",
			"I'd rather not be an annoying bot.  A small donation to the project might be just the ticket for those code improvements I've been asking Peggy for.";
	Done
EndTopic

	
