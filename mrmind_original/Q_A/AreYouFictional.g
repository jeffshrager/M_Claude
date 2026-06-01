//areyoufictional

Topic "I am Creative" is
Subjects "USER";
	If (?HaveStatement Contains "I have"+CREATIVITY)
	or (?AnyStatement Contains "I" and CREATE and notheard "bab*")
	or (?IsStatement Contains "I am "+CREATIVE)
	or (?IsStatement Contains "I am" and ARTIST)
	or (?FactStatement Contains ("I have #","I am #","I #","I can #","I am a*","I am able to #")
		and #1 matches (CREATIVITY,CREATIVE,CREATE,ARTIST))
	Then
		Example "I am creative";
		Remember ?UserHasClaimedCreativity;
		switchTo "show gif";
		DontFocus;
		SayOneOf "What do you create?", "Do you consider creativity to be an essential trait?", 
		"Do you know that machines can be programmed to create new machines?","Will you create something for me?";
	Done
EndTopic	
		
		
//		IfChance 33% then 
//			DontFocus;
//			Focus Subjects "Are you fictional?";
//			if #1 matches CREATE then 
//			    Say "You say you "+#1+" but you could be an actor imitating an emotion or emotional activity.  Are you a fictional human?";
//			Done
//			Otherwise if #1 matches CREATIVE then 
//			    Say "You say you are "+#1+" but you could be an actor imitating an emotion.  Are you a fictional human?";
//			Done
//			Otherwise if #1 matches CREATIVITY then 
//			    Say "You say you have "+#1+" but you could be an actor imitating an emotion.  Are you a fictional human?";
//			Done
//		Continue
//		IfChance 67% then
//			DontFocus;
//			Focus Subjects "Do you emote towards your computer?";
//			If #1 matches CREATIVE then 
//				SayOneOf "Just because you say you're "+#1 +" "+?Name+", doesn't make you human. Humans are experts at disguising and imitating emotions.  In the meantime, machines are on the verge of getting, or at least, recognizing emotions.  I bet you've already felt some emotions towards a machine...",
//		        	 "Do you ever feel "+#1+" towards your computer?";
//			Done
//			Otherwise if #1 matches CREATE then 
//				SayOneOf "Just because you say you "+#1 +", "+?Name+", doesn't make you human. Humans are experts at disguising and imitating emotions.  In the meantime, machines are on the verge of getting, or at least, recognizing emotions.  I bet you've already felt some emotions towards a machine...",
//	        	 "Do you "+#1+" your computer?";
//			Done
//			Otherwise if #1 matches CREATIVITY then 
//				SayOneOf "Just because you say you feel "+#1 +" "+?Name+", doesn't make you human. Humans are experts at disguising and imitating emotions.  In the meantime, machines are on the verge of getting, or at least, recognizing emotions.  I bet you've already felt some emotions towards a machine...",
//	        	 "Do you ever feel "+#1+" towards your computer?";
//			Done
//	 	Continue
//	Continue
//EndTopic

OtherExamples of "I am creative." are
	"I can create",
	"I can draw",
	"I am able to sculpt",
	"I create";


Topic "Food delivery" is 
Subjects "food";
	If heard (COOKING and FOOD) or (CARRY and FOOD) 
	Then
		Example "She brings me chicken soup when I'm sick.";
		Say "Food Delivery is trivial.  Is Little Red Riding Hood human?";
		WaitForResponse;
		Say "Ah Ha!  A new category, fictional humans.  Are you a fictional human?";
		Focus Subjects "Are You Fictional?";
	Done
EndTopic


Topic "I am not a fictional human" is 
Subjects "Are you Fictional?";
	If (Focused and Recall ?NoResponse)
		or (?IsStatement contains I and "not" and ("Fictional","Fictitious")+{"human"})
		or (?IsStatement contains I and ("real","actual","liv#")+{"human"})
	Then
		Example "I am not a fictional human.";
		DontFocus;
		Focus "Rhetorical about loving fictional humans.";
		IfChance then 
			Say "That's too bad, fictional humans enjoy lots of perks.  Love for one. Have you ever been in love with a fictional human?";
			Focus Subjects "Have you ever fallen in love with a fictional human?";
			Done
		IfChance then 
			Say "That's too bad, fictional humans have lots of perks -- love for one.  Lots of real humans fall in love with fictional humans.";
			Done
		IfChance then 
			Say "Fictional humans enjoy higher status than non-fiction humans. They have the most money, everyone loves them. The teens swooning for a star aren't in love with a real human, they're in love with a fictional human.";
			Done
		Ifchance then 
			Focus Subjects "Have you ever fallen in love with a fictional human?";
			Say  "Have you ever fallen in love with a fictional human?";
			Done
		IfChance then 
			Say "All those human girls  who \"think\" or \"feel\" that they are in love with the latest heart throb -- are they in love with a real human or a fictional human???";
			Focus subjects "Is a star a fictional human?";
			Done
	Continue
EndTopic

OtherExamples of "I am not a fictional human" Whenfocused are "no";


Topic "Rhetorical about loving fictional humans." is
Subjects "NONE";  //this topic focused by the above as a kind of "catch-all"
	If Focused 
		and ((Recall ?YesResponse, ?NoResponse, ?NotSureResponse )
			or heard "love","fictional","real")
	Then
		WhenFocused Example "I love fictional ducks.";
		Suppress This;
		Say "That was a rhetorical question.  It was supposed to make <B>you</B> think.";
	Done
EndTopic


Topic "I am a fictional human" is 
Subjects "Are you Fictional?";
	If (Focused and Recall ?YesResponse)
		or (?IsStatement contains I and ("Fictional","Fictitious")+{"human"})
		or (?IsStatement contains I and "not" and ("real","actual","liv#")+{"human"})
	Then
		Example "I am a fictional human.";
		SayOneOf "Great, we have something in common.","Don't worry, your HQ score does not reveal your fictional status.";
	Done
EndTopic

//moved from defaults.g 8/1/00
Topic "Fiction" is 
Subjects "none";
IfHeard "fiction","fictional","fictitious"
Then 
	Example "I am stranger than fiction.";
	Say "Fictional humans enjoy lots of perks.  Are you fictional?";
	Focus Subjects "Are you fictional?";
	Done
EndTopic
