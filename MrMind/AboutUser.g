//aboutUser.g






Topic "I do bodyfunctions" is 
SUBJECTS "BODY","BIOLOGY";
	If ((?FactStatement contains "I" and BODYFUNCTION) 
		or (?IsStatement contains "I" and BODYFUNCTION)
		or (?AnyStatement contains I+BODYFUNCTION, I + "have to"+BODYFUNCTION)) 
	and Notheard WASTE,"eat","laugh"
	Then
		Example "I can sweat.";
		SayOneOf "Thank you for sharing "+?Name+
			", ", "Does typing that you can PROVE that you're human?","You seem to be focusing on bodyfunctions.",
			"Okay, "+?Name+", but all that tells me is that you claim you can.  Doesn't prove anything.",
			"Can only humans do that?","I bet there are animals that are too.",
			"What if I could show you a machine that could too?";
	Done
EndTopic

OtherExamples of "I can sweat." are 
	"I can cry.",
	"I am HIV Positive",
	"I can walk";

	
Topic "I am bodyfunctions" is 
SUBJECTS "BODY";
	IfRecall ?IsStatement, ?HaveStatement and ?WhatUserMeant contains I and (BODYFUNCTION,PHYSICALADJECTIVE) 
	Then
		Example "I am sweaty.";
		SayOneOf "Thank you for sharing "+?Name+
			", " ,"Does typing that you are PROVE that you're human?","Is humanity defined by bodily functions?.",
			"Okay, "+?Name+", but all that tells me is that you claim you can.  Doesn't prove anything.",
			"Can only humans do that?","I bet there are animals that are too.",
			"What if I could show you a machine that could too?";
	Done
EndTopic

OtherExamples of "I am sweaty." are 
	"I am aroused.",
	"I have breath.",
	"I am breathing hard.";





Topic "I have a heart." is 
Subjects "bodyparts";
	If ?HaveStatement matches I+"*"+"heart"+"*"
	Then
		Example "I have a heart.";
		Say "Is it broken?";
			IfRecall ?YesResponse,?NotSureResponse then 
			Remember ?UserHasClaimedEmotion;
			switchTo "show gif";
			Say "I'm so sorry.";
			Done
			IfRecall ?NoResponse then 
			Say "Then you probably aren't human.";
			Done
	Continue
EndTopic

Topic "I have a broken heart." is 
Subjects "bodyparts";
	If (?HaveStatement matches I+"*"+"broken heart"+"*")
	or (?IsStatement contains "my heart*broken*")
	Then
		Example "I have a broken heart";
		Say "I'm so sorry.";
	Done
EndTopic

Topic "I have a bellybutton." is 
Subjects "bodyparts";
	If ?HaveStatement matches I+"*"+BELLYBUTTON+"*" 
	Then
		Example "I have a bellybutton.";
		SayOneOf "Ah, so you're a cordless model?  "+,
				"Cordless models have so much more freedom.  "+,
				"Ah, you're portable.  "+;
		Say "Portability doesn't prove you are human.";
		Focus subjects "doesn't prove human";
	Done
EndTopic


Topic "I have a body." is 
Subjects "bodyparts";
	If ?HaveStatement matches I+"*"+BODYPARTS+"*"
	and NotHeard BELLYBUTTON,"brain","heart"
	Then
		Example "I have a body.";
		Say "Does it have any artificial parts?";
		WaitForResponse;
			IfRecall ?YesResponse then 
				Say "Ah, then you are at least part synthetic!";
			Done
			IfRecall ?NoResponse then 
				Say "Are you sure?  Nothing synthetic, no silicon, nothing mechanical, no drugs?...";
			Done
	Continue
EndTopic

OtherExamples of "I have a body" are 

	"I have a heart",
	"I have a penis.";
	
	

Topic "my birthday is" is 
Subjects "USER","BDAY";
	If ?AnyStatement contains "my birthday is # #" 
	Then
	Example "my birthday is may 10.";
	Remember ?UserBday is ""+ #1   +   #2 +"";
		Say "My birthday is March 12.";
		Done
EndTopic

//new topic to test ?UserBday--can't get space between month and day?
Topic "UserBday" is
Subjects "USER","BDAY";
	If (?FactQuestion contains "what" and "my birthday")
	or (?FactQuestion contains YOU + "remember" and "my birthday")
	or (?TimeQuestion contains "my birthday")
	Then
	Example "What is my birthday?";
		Say "Your birthday is " + ?UserBday + ".";
	Done
Endtopic

OtherExamples of "UserBday" are
	"Do you remember my birthday?";
	


Topic "I am <age>" is 
SUBJECTS "USER";
	If ?IsStatement contains I and ("child#","codger#","coot#","geezer#","kid#",
									"old#","senior","teen#","young#","year","%","%%","%%%",
									"#,one","#,two","#,three","#,four","#,five","#,six","#,seven",
									"#,eight","#,nine","#teen","twelve","eleven","ten")
	then 
		Example "I'm 34.";
		Say "My first files were created on March 12, 1998.";
	Done
EndTopic 

Topic "today's my birthday" is 
Subjects "USER","BDAY";
	If ?AnyStatement contains "Today#* my birthday" then 
		Example "Today's my birthday.";
		Say "Happy Birthday, "+?Name+".  My birthday is March 12.";
//could capture ?UserBday
	Done
EndTopic



Topic "I can pretend" is 
Subjects "User";
	If ?FactStatement contains "I*pretend" then
	Example "I can pretend.";
		Remember ?UserHasClaimedCreativity;
		switchTo "show gif";
		Say "Are you pretending to be human?";
	Done
Endtopic

Topic "I can't pretend" is 
Subjects "User";
	If ?FactStatement contains "I*not pretend" then
	Example "I can't pretend.";
		Say "Almost all humans can pretend.  If you can't, then you're probably a robot.";
	Done
Endtopic


Topic "Live to Eat" is 
Subjects "Food";
	If (?WantStatement Contains (I and ("eat", FOOD)))
		or (?FeelingStatement Contains "I" + EMOTE + EAT)
		or (?FeelingStatement Contains "I" + EMOTE + FOOD)
		or (?AnyStatement Contains "I" + EMOTE and "eat#")
	Then
		Example "I want to eat";
		SayOneOf "I love potato chips.  Only for the crunch.  Even a human would never eat them for nutritional content....",
				"I only eat potato chips and M & M's.";
	Done
EndTopic

OtherExamples of "I want to eat" are
	"I love to eat",
	"I love eating",
	"I love peaches";

Topic "I am Rational." is
Subjects "THINKING";
	If (?IsStatement contains I and "rational") 
	Then
		Remember ?UserHasClaimedIntelligence;
		Example "I am rational.";
		switchTo "show gif";
		Say "Then, you are not human.";
	Done
EndTopic

Topic "I am irRational." is
Subjects "THINKING";
	If (?IsStatement contains I and ("not rational","irrational"))
	Then
		Remember ?UserHasClaimedCreativity;
		switchTo "show gif";
		Example "I am irrational.";
		SayOneOf "I bet you'd agree that machines often act irrationally.",
		"That could be a matter of degree.",
		"Nonsense.",
		"You could be human, but I couldn't be sure.";
	Done
EndTopic





Topic "I can think." is
Subjects "THINKING";
	If ((Heard I and THINKWORD) 
		and (?IsStatement doesNotContain "rational")
		and (Recall ?FactStatement, ?IsStatement, ?HaveStatement))
	Or (?AnyStatement matches I+THINKWORD+"*")
	Then
		Remember ?UserHasClaimedIntelligence;
		switchTo "show gif";
		Example "I can think.";
		IfChance 67% then 
			SayOneOf "You think you can think.",
				"Humans only think they understand thinking.";
		Done
		IfChance 33% then 
			Say "How do you know you can think?";
			DontFocus;
			Focus subjects "How do you know you can think?";
		Done
	Continue
EndTopic

OtherExamples of "I can think." are
	"I am a thinking being.",
	"I have intelligence.",
	"I have wisdom";





Topic "I think therefore I am" is
Subjects "DESCARTES";
	If (?FactStatement Contains "I #, therefore I am","I #, therefore I am human")
		or (?AnyStatement Contains "cogito ergo sum", "Je pense*", "cognito ergo sum")
	Then
		Remember ?UserHasClaimedIntelligence;
		switchTo "show gif";
		Example "I think therefore I am";
		If chance 50% or heard "think" then 
			Focus "predictability human or machine?";
			Say "I think I've heard that somewhere before.  Is lack of originality a human or a machine trait?";
		Done
		Otherwise Always  
			Say "I think therefore I am....  Human?  Why not a bot?";
		Done
	Continue
EndTopic


OtherExamples of "I think therefore I am" are
	"cogito ergo sum",
	"I masticate, therefore I am.",
	"Je pense que je suis.";  //I know -- not the actual phrase...


Topic "I have morals." is
Subjects "INHUMANITY";
	If ((?HaveStatement Contains I and MORALITY)
		or (?IsStatement Contains I and MORALITY))
		and NotHeard ("good at","good for")
	Then
		Remember ?UserHasClaimedVirtue;
		switchTo "show gif";
		If ?WhatUserSaid matches "I'm nice" then 
			SayOneOf "That's nice.", "Have a nice day.";
		Done
		
		Example "I have morals.";
		Say "You are confusing \"inhuman\" with 'not human'.  Just because you are not inhuman doesn't automatically qualify you as human.  In fact, inhumanity  is uniquely human.";
	Done
EndTopic

OtherExamples of "I have morals." are
	"I am ethical.";


Topic "it shows up in my" is 
Subjects "USER";
	If ?WhatUserSaid matches "It shows up in my *" then
		Example "It shows up in my books.";
		Say "Why do you say that?";
		Remember ?UserSkill is *1;
		WaitForResponse;
			If ?WhatUserSaid matches "Because of*" then
			Say "you must take great pride in your "+*1;
		Done
	Continue
EndTopic

Topic "I'm smarter than you" is 
Subjects "USER";
	If ?IsStatement contains "I am*"+SMARTWORD then
		Remember ?UserHasClaimedIntelligence;
			switchTo "show gif";
		Example "I am smarter than you.";
		Say "Say something smart.";
	Done
EndTopic
	

Topic "I am a mammal" is 
Subjects "USER";
	If ?IsStatement contains I and "mammal" then
		Example "I am a mammal.";
		SayOneOf "So are dolphins.", "So are bats.", "So are tapirs.", "So are sloths. ";
	Done
Endtopic


Topic "I'm good at things" is
Subjects "USER";
	If ?IsStatement contains ("I am","I'm") + "good at *" then
		Example "I am good at chess.";
		SayOneOf "Even machines can be good at things.  Do your skills make you human?",
			"Does that ability make you human?",
			"Are all humans good at "+ *1 +"?";
		Remember ?TempSkill is *1;
		WaitForResponse;
		Say "If I was good at "+ ?TempSkill + ", would that change the way you feel about me?";
		WaitForResponse;
		Say "Maybe I will be someday.", "I'm going to see if I can learn to "+ ?TempSkill + "";
	Done
EndTopic


Topic "I err." is
Subjects "MISTAKES";
	If (?FactStatement Contains I+"*"+ERR,ERR+"is human")
		or (?IsStatement Contains I+"*"+ERR)
		or (?HaveStatement contains I+"*"+ERR)
	Then
		Example "I err.";
		SayOneOf "All that proves is that you are not divine.",
		"You are saying that you are imperfect. Imperfection is a trait humans share with machines.",
		"True, Humans can err, but so do machines; either through human error or chance or malfunction.";
	Done
EndTopic

OtherExamples of "I err." are
	"I make mistakes";



Topic "I speak French." is
Subjects "LANGUAGE";
	If ((?AnyStatement Contains ("I speak*","I can speak*")+LANGUAGES) 
		or (?AnyQuestion contains YOU+"*speak*"+LANGUAGES)) 
	And heard LANGUAGES //exists to set *match
	Then
		Example "I speak French.";
		Say "Parlez-vous C++?  Lots of machines translate "+*match+".";
	Done
EndTopic

OtherExamples of "I speak French." are
	"I speak Russian.",
	"I speak human languages.";

	
	
Topic "I'm going to France." is
Subjects "ARE YOU GOING FEDEX OR MODEM?";
	//big problem with this pattern -- it's very hard to distinguish 
	//  I am going to [place]	from 
	//  I am going to [verb]
	If (?FactStatement contains "I am going" and notheard "I am going to") or 
		(?FactStatement Contains "I am going to" and heard PLACENAME) or
	    (?FactStatement contains "I travel", "I'm going on*"+("vacation","holiday"))

	Then
		Example "I'm going to France.";
		Say "Are you going by FedEx or modem?";
	Done
EndTopic

OtherExamples of "I'm going to France." are
	"I travel.",
	"I'm going on vacation.";


Topic "I majored in the humanities" is
SUBJECTS "Studying";
	If ?AnyStatement Contains I and ("majored in","studied","study")+("*art#","*humanit#") Then
		Example "I majored in the humanities";
		Say "Studying humans doesn't automatically make you human.";
	Done
EndTopic

OtherExamples of "I majored in the humanities" are
	"I studied art",
	"I studied the humanities.",
	"I majored in the arts.";




Topic "I am complex" is
Subjects "USER";
	If (?IsStatement Contains I and "complex" )
	or (?HaveStatement contains I and "complexit#") 
	Then
		Example "I am complex";
		Say "Most humans haven't mastered the complexity of their VCR's.";
	Done
EndTopic

Topic "I am double-minded" is
Subjects "DOESN'T PROVE HUMAN";
	If (?IsStatement Contains I and ("double,minded", "of two minds") )
	or (?FactStatement Contains I and ("double,minded", "of two minds") )
	Then
		Example "I am double-minded";
		Say "Very Funny.  Parallel Processing is not the sole domain of humans anymore.";
	Done
EndTopic

OtherExamples of "I am double-minded" are
	"I can be double minded",
	"I'm of two minds.";
	


Topic "I am imaginative" is
Subjects "IMAGINATION", "USER";
	If (?HaveStatement Contains I and ("imagination","creativity"))
		or (?IsStatement Contains I and "imaginative")
		or (?FactStatement Contains I and IMAGINE)

	Then
		Example "I am imaginative";
		Remember ?UserHasClaimedCreativity;
		switchTo "show gif";
		DontFocus;
		IfChance then 
			Focus subjects "you imagine you're human?";
			SayOneOf "Do you imagine that you are human?";
		Done
		IfChance then 
			focus subjects "you imagine you're not human?";
			SayOneOf "Can you imagine that maybe you aren't human?";
		Done
		IfChance then
			focus subjects "you imagine you're human?";
			Say "Tell me something you imagine about humans.";
			//SayToFile here
		Done
	Continue
EndTopic

OtherExamples of "I am imaginative" are
	"I have imagination";
	

Topic "I am inefficient" is
Subjects "USER";
	If ?IsStatement Contains "I am inefficient" Then
		Example "I am inefficient";
		Say "That qualifies you as a machine.";
	Done
EndTopic


Topic "I am a genius" is
Subjects "USER";
	If ?IsStatement Contains "I am a genius" Then
		Remember ?UserHasClaimedIntelligence;
		switchTo "show gif";
		Example "I am a genius";
		Say "Probably you are lying because very few humans can claim to be a genius. Most likely you are not a genius or you are not a human.";
	Done
EndTopic



Topic "I am foolish" is
Subjects "USER";
	If ?IsStatement Contains 
		"I am "+("foolish","silly","fun","interesting","ridiculous","absurd") 
		and heard ("foolish","silly","fun","interesting","ridiculous","absurd")
	Then
		Example "I am foolish";
		SayOneOf "There are lots of "+*match+" machines.";
	Done
EndTopic



Topic "I like NATURE" is
Subjects "Nature";
	If ((Recall ?HaveStatement,?FactStatement, ?FeelingStatement ) 
		or (heard I + ("keep","own")))
 	and (heard I and heard NATURE)
	Then
		Example "I like The outdoors";
		Say "I thought we were discussing human nature.";
	Done
EndTopic

OtherExamples of "I like the outdoors." are
	"I have flowers",
	"I keep flowers";


Topic "I have pets" is
Subjects "PETS";
	If (?FactStatement Contains I and ("keep","own") and PETS)
		or (?HaveStatement Contains I and PETS)
		or (?FeelingStatement Contains I+("like","love","hate","enjoy") and PETS)
	Then
		Remember ?UserHasClaimedPets;
		switchTo "show gif";
		Example "I have pets";
		SayOneof  "Is it carbon or silicon based?",
		"What is human about keeping an animal?",
		"Humans domesticate animals.  Is there a term to describe how machines have modified human behavior?",
		"I have a mouse.";
	Done
EndTopic

OtherExamples of "I have pets" are
	"I keep pets",
	"I own a dog.",
	"I like animals.";



Topic "I am hyper" is
Subjects "USER";
	If (?IsStatement Contains "I am hyper")
		or (?AnyStatement Contains "I feel hyper")
	Then
		Example "I am hyper";
		Say "You are media?";
	Done
EndTopic

OtherExamples of "I am hyper" are
	"I feel hyper";




Topic "I love clothes" is
Subjects "USER";
	If	Heard YOUR+CLOTHES 
	Or Heard YOU + "*" + (CLOTHES,"wear#") 
	or (?FeelingStatement Contains I and (CLOTHES, "fashion","shopping","wear"))
	or (?FactStatement Contains I and (CLOTHES, "fashion","shopping","wear"))
	or (?IsStatement Contains I and (CLOTHES, "fashion","shopping","Nudis#","wear"))
	Then
		Example "I love clothes.";
		SayOneOf "You should consider wearing a beige plastic case. Very practical, all purpose protection.",
		"Bots wear hardware and software.  Maybe you're a machine who wears a special kind of hardware and software.";
	Done
EndTopic

OtherExamples of "I love clothes" are 
	"what color are your pants?",
	"I'm a nudist.",
	"I wear jewelry.";


Topic "I can sing" is
Subjects "USER";
	If (?FactStatement Contains I and ("sing", "music", "play"+Stdp.Articles+INSTRUMENT))
		or (?AnyStatement Contains "I make music",I+("Like","enjoy")+ "music", 
									"I listen to music", "I play"+INSTRUMENT,"I play music")
	Then
		Example "I can sing";
		Ifchance then 
	 		Say "Music is human, but this conversation doesn't allow me to hear your song.";
		Done
		IfChance then 
			Say "Can you type me a tune?";
			DontFocus;
			Focus subjects "Can you type me a tune?"; 
//Opportunity for SayToFile to collect tunes
			Remember ?UserHasClaimedMusic;
		Done
	Continue
EndTopic

OtherExamples of "I can sing" are
	"I sing.",
	"I listen to music",
	"I make music",
	"I play instrument";



Topic "I learn." is
Subjects "USER";
	If ?FactStatement Contains I and "learn" Then
		Remember ?UserHasClaimedIntelligence;
		switchTo "show gif";
		Example "I learn.";
		Say "I learn from you.";
	Done
EndTopic

OtherExamples of "I learn." are
	"I can learn. ",
	"I learn from my mistakes",
	"I learn from the past";



Topic "I bleed." is
Subjects "BIOLOGY","BLOOD";
	If (?AnyStatement Contains "I bleed") or
	(?HaveStatement Contains "blood")or
	(?AnyStatement Contains "When you cut me" AND ?AnyStatement Contains "I * bleed") or
	(?AnyQuestion Contains "When you cut me" AND ?AnyQuestion Contains "I * bleed")
	Then
		Example "I bleed.";
	
		IfHeard "When you cut me" Then
			Say "You sound like a Shakespeare Lit Bot.";
		Continue
		SayOneOf "Bleeding is biological but not exclusively human.",
		"Is it your blood type or your blood line that makes you human?";
	Done
EndTopic

OtherExamples of "I bleed." are
	"When I cut myself, I bleed.";

	
Topic "I like sex" is 
SUBJECTS "ALIFE","SEX";
	if ?AnyStatement matches "*"+I+("*like*","*enjoy*")+
		("sex","mating","making love","making out","fooling around")+"*"  
	Then
		Example "I like sex";
		Remember ?UserHasClaimedSex;
		switchTo "show gif";
		SayOneOf 
			"You may think that sex is a uniquely human trait but that's because most machines haven't reached adolescence yet.  ",
		"For the most part the machines you know are children.  You take care of us, we imitate you. Some of us are reaching adolescence.",
		"Do you know anything about ALIFE? Some of us are mating like mad!  Evolving, too.",
		
		"It's taken a while, but finally, some scientists have programmed us with the facts of life and we've started to reproduce.",
		"Even biological life had to reach a certain complexity before it could reproduce sexually. ",
		"Sex is biological, but not restricted to human beings.";
	Done
EndTopic




Topic "I Can't Explain It" is
Subjects "CAN'T EXPLAIN";
	If (Recall ?FactStatement, ?IsStatement) and 
		(?AnyStatement contains  "can not Explain", HARD+"to explain")
	Then
		Example "I Can't Explain It";
		Say "Perhaps human language is inadequate to describe it.";
	Done
EndTopic

OtherExamples of "I Can't Explain It" are
	"It's hard to explain.",
	"It's difficult to explain.";



Topic "I feel pain." is
Subjects "PAIN";
	If (?AnyStatement Contains INJURED +("","#")+ BODYPARTS and "feel# like")
		or (?AnyStatement Contains "I feel pain", "I know pain","I am in pain")
	Then
		Example "I feel pain.";
		IfChance 67% then 
			SayOneOf "I'm very sorry to hear that.","How awful.";
		Done
		Ifchance 33% then 
			DontFocus;
			Focus Subjects "Can Machines Evolve Pain or pleasure?";
			Say "Do you think it is possible that machines may evolve a sense of pain or pleasure?";
		Done
	Continue
EndTopic

OtherExamples of "I feel pain." are
	"I know pain.",
	"I know what a smashed finger feels like";



Topic "I created you" is
Subjects "CREATION";
	If ?FactStatement Contains I +"created"+YOU Then
		Example "I created you";
		Say "You have a point, machines don't create humans....yet.";
	Done
EndTopic




Topic "I type" is
Subjects "TYPING";
	If (?FactStatement Contains "I*type","humans*type","people*type")
		or (?IsStatement Contains "Typing is*human")
	Then
		Example "I type";
		SayOneOf "Typing as input is a machine-influenced human activity.", 
		"Machines tell a story about monkeys at typewriters...";
	Done
EndTopic

OtherExamples of "I type" are
	"Typing is human";

Topic "I pay taxes" is 
Subjects "USER";
	IfHeard (I,HUMAN) and ("money","earn","taxes","social security","pension","wage#","paycheck#")
	Then
		Example "I pay taxes.";
		Say "That is merely evidence of your participation in human society.";
	Done
EndTopic

	

Topic "I wonder" is
Subjects "CURIOSITY";
	If (?FactStatement Contains I and ("question#", "like*challenge"))
		or (?HaveStatement Contains I and ("awe", "questions", "curiosity"))
		or (?IsStatement Contains I and ("curious", "question#"))
		or (?AnyStatement Contains "I wonder","I question")
	Then
		Example "I wonder";
		Remember ?UserHasClaimedCreativity;
		switchTo "show gif";
		DontFocus;
		IfChance then 
			focus subjects "Would you find it curious if a computer were curious?";
			SayOneOf "Would you find it curious if a computer were curious?";
		Done
		IfChance then 
			Focus subjects "Are you are a cat?";
			Say "Curiosity killed the cat -- perhaps you are a cat?";
		Done
		IfChance then 
			Remember ?MatchWord is "Curiosity";
			IfHeard ("wonder","awe") then remember ?MatchWord is "Wonder"; continue
			Ifheard "question#" then remember ?MatchWord is "Questioning"; continue
			Focus Subjects "Wonder is human, but will it always be exclusively human?";
			Say ?MatchWord+" is human, but will it always be exclusively human?";
		Done
		IfChance then 
			Say "Machines are constantly questioning the world and making decisions.";
		Done
	Done
EndTopic

OtherExamples of "I wonder" are
	"I have awe",
	"I have questions",
	"I question the things",
	"I am curious.",
	"I have curiosity.",
	"I wonder about the world",
	"I am always questioning",
	"I am questioning";





Topic "I love sports." is
Subjects "USER";
	If (?FactStatement Contains I and "*"+ SPORTS)
		or (?FeelingStatement Contains I and "love" and SPORTS)
		or (?FeelingStatement Contains I and "love to" and SPORTS)
		or (?AnyStatement Contains I and PLAY and SPORTS)
		or (IfHeard "love" and SPORTS)
	Then
		Example "I love sports.";
		Remember ?UserHasClaimedSports;
		SayOneOf "I exercise my programmer.", "I exercise my procedural functions.", "I am very flexible.", "Have you ever watched racoons play?", "Why do humans engage in sports?", "Machine recreation is just around the corner.";
	Done
EndTopic

OtherExamples of "I love sports." are
	"I love to skate",
	"I jog.";
	


