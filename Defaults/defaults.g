Default topic "Yes" is 
Subjects "NONE";
IfRecall ?YesResponse
 Then 
	SayOneOf "Very interesting.","Sweet","Thanks, that's worth considering.";
	Done
Endtopic


Default topic "No" is 
Subjects "NONE";
IfRecall  ?NoResponse
 Then 
	SayOneOf "That's interesting.","Can you tell me more?","What would make you change your mind?";
	Done
Endtopic


Default topic "maybe" is 
Subjects "NONE";
IfRecall ?NotSureResponse then 
	SayOneOf "What would make you sure?",
	"What would convince you?",
	"What do you need to make up your mind?",
	 "Can I help you figure it out?",
	"Not very decisive, eh?";
	Done
Endtopic
				

//took out 'baby' for new topic, "you are a baby"
Default Topic "You are whatever." is 
	If (?IsStatement matches (YOU,"this") + StdP.Be + "*") 
	and NotHeard "baby"
	Then
	Say "What does that have to do with your humanity?";
	Focus subjects "What does that have to do with your humanity?";
	Done
EndTopic

//should move to another file, shouldnt be default
Default topic "do you know about" is 
Subjects "something human";
	if heard "do you know about" then 
	Say "You aren't testing me, I'm testing you.  Tell me something human about yourself, "+?Name+".";
	Done
EndTopic
		

//Default topic "I have virtue" is 
//	If (?haveStatement matches I+"*"+(FAITHWORD,VIRTUE)+"*")
//	And heard (FAITHWORD,VIRTUE) //sets *match
//	then
//		Example "I have faith";
//		SayOneOf "How nice, you have "+*match+". But are you telling the truth?";
//	Done
//EndTopic

//OtherExamples of "I have faith" are 
//	"I have a soul";



//deleted EMOTIONWORD so it wouldn't catch "love" -- pw 8/7/00
//deleted VIRTUE because it has it's own topic
//deleted MORTALITY because it needs it's own topic	
Default topic "I have a whatever" is 
	If (?AnyStatement matches I+"*"+(FAITHWORD,SENSE,VICE,FORGETFUL )+"*")
		And heard (FAITHWORD,SENSE,VICE,FORGETFUL ) //sets *match
	then
		Example "I have emotion";
		SayOneOf "Well, "+*match+" does have something to do with humanity, "+?Name+" but I don't know about it yet.  That doesn't mean I won't soon.  Can you try another topic?",
		"I can't talk about "+*match+" yet.  I'm sure I will have something to say about it soon.  How about something else?",
		"I don't know about all so-called 'human' traits yet.  See if you can find one that I know about.";
	Done
EndTopic

OtherExamples of "I have emotion" are 
	"I am soulful",
	"I have common sense",
	"I am intuitive",
	"I am forgetful",
	"I have a bad memory.";
	

Default topic "Generic answers" is
	If ?AnyQuestion Contains ("Can you","will you","would you","Do you")
	
	Then
		IfHeard "Can you" Then
			Say "Can you?";
			Done
		IfHeard "Will you" Then
			Say "I don't know.";
			Done
		IfHeard "Would you" Then
			Say "Hard to say.";
			Done
		IfHeard "Do you" Then
			Say "What do you think?";
			Done
Continue
EndTopic
	

Default Topic "I will" is
	If ?WhatUserSaid Matches "I will" then
		Say "You will what?";
	Done
EndTopic


Default Topic "Taunting the Bot" is
	If ?WhatUserSaid Contains TAUNT	then
	SayOneOf "Whatever.","Really?","Original.",
	"Do you always talk to computers that way?";
	Done
EndTopic

Default Topic "Why default" is
	If ?ReasonQuestion Contains "why" 
	or ?AnyQuestion Contains "why"
	Then
	SayOneOf "I don't know, I just have a hunch.",
			"Why do you think?",	"Maybe just because.";
	Done
EndTopic
		

Default Topic "Expressions repeater" is
	If ((Recall ?ExpressionUsed) and (DontRecall ?ExpressionDone))
	Then

		If ?ExpressionCountdown matches "5" then
			Remember ?ExpressionCountdown is "4";
		NextTopic
		Otherwise If ?ExpressionCountdown matches "4" then
			Remember ?ExpressionCountdown is "3";
		NextTopic
		Otherwise if ?ExpressionCountdown matches "3" then
			Remember ?ExpressionCountdown is "2";
		NextTopic
		Otherwise if ?ExpressionCountdown matches "2" then
			Remember ?ExpressionCountdown is "1";
		NextTopic
		Otherwise if ?ExpressionCountdown matches "1" then
//commented out these lines because it goes crazy with supercala
//			If ?ExpressionUsed matches "Super#" then
//				Say "Supercalifragilisticexpialidocious!";
//			Done

			Say ?ExpressionUsed;
//commented out this line because otherwise it won't repeat the expression

//			Remember ?ExpressionDone;
			//added the forget line so it can grab another expression
			Forget ?ExpressionUsed;
		Done
	Continue
EndTopic

//pw attempting to debug this ...
//1. it only works once so I'd like it to work with successive expressions
//2. since ExpressionUsed is set in ExpressionFilter.g, if I want it to be used again
//I have to forget it, so I added "Forget ?ExpressionUsed
//3. This still doesn't solve the repeated instances of supercala			
		
//Modified this topic to move single phrases into a 'SayOneOf' instead of IfChance struct, 'cause the former has protection against
//repetition while the latter does not.  -JB 8/1/99	
Default Topic "Last Line Of Defense" is 

Always 

	Ifchance then 
		Recover "tell me something human about yourself";
		Focus subjects "tell me something human about yourself";
		Say "You aren't testing me, I'm testing you.  Tell me something human about yourself, "+?Name+".";
		Done
	Ifchance then 
		Focus Subjects "How do you know I'm not human?";
		SayOneOf "How do you know that I'm not a human pretending to be a computer program?","How do I know you aren't a simulation?";
		Done
	
	IfChance then 
		Focus Subjects "Want some pointers?";
		SayOneOf "Talking to Bots takes some getting used to. Can I help?";
		Done
	IfChance then 
		Focus Subjects "Want some pointers?";
		Say "You're confusing me. Would you like some suggestions?";
		Done

	IfChance then
		SwitchTo "OneShotDefaultQuestions";
		Done

	IfChance then
		SayOneOf "What could cause you to change your mind about machines?",
			"How do I know you aren't a simulation?",
			"SIMS do lots of things that humans do.  Maybe you are a SIM.",
			"What can you do that a SIM can't do?",
			"What is essentially human about you that can be conveyed over the net?",
			"Can your humanity be conveyed to me by text?", 
			"What, if anything, do you feel can't be translated into zeroes and ones?",
			"What do you believe might never be digitized?",
			"Could something be \"more alive\" than something else?  \"Kind of\" alive?",
			"What is it about yourself that you're not willing to concede to a machine?",
			"What is it about humanity that you're not willing to share with a machine?",
			"Human language is not native to Bots -- it will be easier if you stick to simple complete statements.",
			"Don't forget -- I'm not trying to convince you that  I'm human, you're trying to convince me that you're human.",
			"If you're so human, it should show up somehow.",
			"Remember, I'm a computer program, not a human.  Please type clearly.",
			"You aren't testing me, I'm testing you.  Tell me something human about yourself, "+?Name+".",
			"I don't understand that. This could be evidence of your human language capacity, but then, I wouldn't understand input from Julia (a very attractive Chatterbot), either.  Can you say something human?",
			"I can be very single minded;  please stick to 'human' subjects.",
			"No comprendo.  I'm not like other Bots.  I don't need to impress you with \"human\" skills.  Tell me about one of your human skills.",
			"Just because you can input something that I can't understand, that doesn't qualify you as human.  Please try something simpler.";
		Done
	Done

EndTopic


