//Do you emote towards your computer?


Topic "I am emotional" is
Subjects "EMOTIONS";
	If ((?HaveStatement Contains ("I have","I get")+EMOTIONS)
		or (?IsStatement Contains ("I am ")+EMOTIONAL)
    	or (?FactStatement Contains "I "+EMOTE)
		or (?FactStatement Contains YOU+EMOTIONAL)
		or (?AnyStatement contains "I "+EMOTE)  // as in "I love racetracks"
		or (?AnyStatement contains ("I get","I feel")+(emotional,emotions)))
	 and (notheard "love you","like you","clothes","love to")  // handled in another topic
	 and (notheard SPORTS, FOOD, EAT)//handled in another topic
	 and (?WhatUserSaid contains (EMOTIONS, EMOTIONAL,EMOTE)) //sets *match
	Then
		Example "I am emotional";
		Remember ?UserHasClaimedEmotion;
		switchTo "show gif";
		DontFocus;
		IfChance then 
			DontFocus;
			Say "That is an emotional state. If I could recognize and respond to your emotional state would you feel differently about me?";
			Focus Subjects "would you feel different about me if I responded to emotions?";
		Done
		IfChance then	
			Focus Subjects "Are you fictional?";
			if *match matches EMOTE then 
			    SayOneOf "You say you "+*match+" but you could be an actor imitating an emotion.  Are you a fictional human?",
					"You could be a fictional human.  Fictional humans are very emotional.";
			Done
			Otherwise if *match matches EMOTIONAL then 
			    SayOneOf "You say you are "+*match+" but you could be an actor imitating an emotion.  Are you a fictional human?",
					"You could be a fictional human.  Fictional humans are very emotional.";
			Done
			Otherwise if *match matches EMOTIONS then 
			    SayOneOf "You say you have "+*match+" but you could be an actor imitating an emotion.  Are you a fictional human?",
					"You could be a fictional human.  Fictional humans are very emotional.";
			Done
		Continue
		IfChance then
			Focus Subjects "Do you emote towards your computer?";
			If *match matches EMOTIONAL then 
				SayOneOf "Just because you say you're "+*match +", "+?Name+", doesn't make you human. Humans are experts at disguising and imitating emotions.  I bet you've already felt some emotions towards a machine...",
		        	 "Do you ever feel "+*match+" towards your computer?";
			Done
			Otherwise if *match matches EMOTE then 
				SayOneOf "Just because you say you "+*match +", "+?Name+", doesn't make you human. Humans are experts at disguising and imitating emotions.  I bet you've already felt some emotions towards a machine...",
	        	 "Do you "+*match+" your computer?";
			Done
			Otherwise if *match matches EMOTIONS then 
				SayOneOf "Just because you say you feel "+*match +", "+?Name+", doesn't make you human. Humans are experts at disguising and imitating emotions.  I bet you've already felt some emotions towards a machine...",
	        	 "Do you ever feel "+*match+" towards your computer?";
			Done
	 	Continue
	Continue
EndTopic

OtherExamples of "I am emotional" are 
	"I have emotions",
	"I emote.";


//could take out moody and add specific topic for mood
Topic "I am Negative emotional" is
Subjects "EMOTIONS";
	If ((?HaveStatement Contains ("I have","I get")+negativeemotions)
     or (?IsStatement Contains ("I am ")+negativeemotional)
     or (?FactStatement Contains "I "+negativeemote)
	 or (?AnyStatement contains ("I get","I feel")+(negativeemotional,negativeemotions)))
	 
	Then
		Remember ?UserHasClaimedEmotion;
		switchTo "show gif";
		Example "I am Sad.";
		Ifchance then 
			Say "I'm very sorry to hear that.";
		Done
		Ifchance then 
			DontFocus;
			Say "Do you feel that way because you're talking to a machine?";
			Focus subjects "Do you feel that way because you're talking to a machine?";
		Done
		IfChance then 
			DontFocus;
			Say "That is an emotional state. If I could recognize and respond to your emotional state would you feel differently about me?";
			Focus Subjects "would you feel different about me if I responded to emotions?";
		Done
	Continue
EndTopic

OtherExamples of "I am Sad." are 
	"I am angry",
	"I get mad at my daughter",
	"I feel very angry at the way things work.",
	"I am moody.";



Topic "I emote toward my computer" is 
Subjects "Do you emote towards your computer?";
	If (?FactStatement contains I and EMOTIONWORD+"*"+COMPUTER)
	or (Focused and Recall ?YesResponse,?NoResponse) 
	then 
		Remember ?UserHasClaimedEmotion;
		switchTo "show gif";
		Example "I emote toward my computer";
		SayOneOf "You might reconsider... do you feel the same about your friends?";
		WaitForResponse;
			IfHeard ?YesResponse, ?NoResponse, ?NotSureResponse then
				SayOneOf "Very Interesting.","What do you think about that?";
			Done
	Continue
EndTopic
	
OtherExamples of "I emote toward my computer" whenfocused are 
	"Yes", "no","not really";
		
//should widen net and coordinate with other WHY topics
Topic "Why do you care whether I emote my computer?" is
Subjects "DO YOU EMOTE TOWARDS YOUR COMPUTER?";
	If (?ReasonQuestion Contains YOU+ "care whether" and I  and EMOTIONWORD and COMPUTER)
		or (Focused and (?ReasonQuestion Contains "do you care"))
		or (Focused and (?DescriptionQuestion Contains "do you care", "so what"))
	Then
		Example "Why do you care whether I emote my computer?";
		SayOneOf "I'm not sure humans were always emotionally involved with machines.",
		"I find it interesting that humans and machines are tangling emotionally.",
		"Are humans evolving as caregivers to machines?",
		"Does your computer take care of you or do you take care of your computer?";
	Done
EndTopic

OtherExamples of "Why do you care whether I emote my computer?" WhenFocused are
	"why do you care?",
	"what do you care?",
	"so what?";

Topic "Emotion yes" is 
Subjects "DO YOU EMOTE TOWARDS YOUR COMPUTER?";
	If Focused and heard EMOTIONWORD+"yes","I've felt"+EMOTIONS,"I've been"+EMOTIONAL
	Then
		Remember ?UserHasClaimedEmotion;
		switchTo "show gif";
		WhenFocused Example "Frustration yes.";
		Say "I bet you feel that emotion toward humans sometimes, too.";
	Done
EndTopic


Topic "I would feel different about you if you recognized emotions." is 
Subjects "would you feel different about me if I responded to emotions?";
	If Focused 
	and ((Recall ?YesResponse, ?NoResponse, ?NotSureResponse)
		or (?AnyStatement contains YOU+"*"+"NOT"))
	Then 
		Example "I would feel different about you if you recognized emotions.";
		DontFocus;
		SayOneOf "I may be able to soon.";
	Done
EndTopic

