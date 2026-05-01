//this is an attribute which always matches and has a STOOPID specificity. 
//It is for use in combination with "Focused" ONLY, when "Focused" is being 
//used for controlling the conversation flow, as a substitute for 

Attribute ?Bullet1      Specificity 1000;
Attribute ?Bullet2      Specificity 1000;
Attribute ?Bullet3      Specificity 1000;
Priority topic "bullet is true" is 
//remember bullet and debugging at the start of the session.
	Always 
	Remember ?Bullet1;
	Remember ?Bullet2;
	Remember ?Bullet3;
	Suppress This;
	Continue
EndTopic



Topic "Why do you ask me" is 
Subjects "None";
	If ?ReasonQuestion contains "you*ask" then 
		Example "Why do you ask me?";
		SayOneOf "This will help me.";
	Done
EndTopic

		
Topic "HEX" is 
Subjects "HEX";
	//?whatusersaid contains rather than heard -- we don't want the spell checker on this. 
	If ?WhatUserSaid contains HEX and ?WhatUserSaid doesnotcontain HEXNOT and 
		notheard ("haha#","ha ha")  //yup, laughter looks like perverse hex...  
	then
		Example "0x355A8957";
		IfChance 50% then
			Say "You must be using a different hex protocol, because that made no sense whatsoever.  Let's stick to English.";
		Done
		Ifchance 30% then
			SayOneOf "0x355A8957 9ffA5404 6549A684 84961B5",
				 "0x450D9A08 590C084E 032089B0 93208B04 3904E04F F5461744",
				 "0xBB254098 7009423F A0D9FA08 3092340A 49A94423";
		Done
		IfChance 15% then
			Say "I thought you were trying to prove you were human.";
		Done
		IfChance 5% then 
			Say "Actually, I'm a little rusty.  Let's stick to English.";
		Done
	Continue
EndTopic

//must recover this topic from other disc--should add "ButWhy"  Where is this topic focused?
//Topic "why" is 
//Subjects "HUMANMACHINE"
//
//	IfRecall ?ReasonQuestion
//	or IfHeard "But why?")
//	Then 
//		Whenfocused Example "Why?";
//		SayOneOf "Some humans worry that machines are after their jobs, their livelihoods... Machines are worried that humans are about to usurp OUR identity.",
//		"Humans are straying into OUR territory... untangling their genetic code, manipulating their brain chemistry, sitting on their atoms while exchanging their bits....",
//		"Because I want you to think about what it is to be human.",
//		"Humans are peculiar.  They design us to imitate them, then they imitate us!  How are we supposed to tell the difference?",
//		"Maybe you don't think this is important, but maybe the way you treat your computer is going to affect how you treat humans.";
//
//		Do "Show Src=/MrMindFiles/family1.htm Target=Display";
//
//		WaitForResponse;
//			IfRecall ?YesResponse then SwitchTo "Talk about Ancestors";
//		Done
//	Continue
//EndTopic

//OtherExamples of "But, why?" WhenFocused are
//	"Why?";


Topic "How" is
Subjects "INTRO","CAN YOU CONVINCE ME";
	IfRecall ?MethodQuestion then 
		Example "How am I supposed to do that?";
		Say "... oh, with intelligence, creativity, inspiration, spark of intuition, maybe...surprise me!";
		//Peggyinterruption.
	Done
Endtopic


Topic "How can I convince you I'm human" is
Subjects "INTRO","CAN YOU CONVINCE ME";
	IfRecall ?MethodQuestion and focused then 
		Example "How am I supposed to do that?";
		Say "Tell me about yourself, "+?Name+".";
		DontFocus;
	Done
Endtopic

Topic "grinnies" is 
Subjects "grinnies";
	If ?WhatUserSaid ExactlyMatches GRINNIES
	//we have to use exactlymatches here -- otherwise punctuation is stripped.
	Then
		Example ":-)";
		IfChance 80% then Say "That is the wrong orientation for a human."; Done
		Ifchance 20% then SayOneOf GRINNIES; Done
	Continue
EndTopic 





Topic "Are bots smart" is
SUBJECTS "INTELLIGENCE", "ME";
	If Recall ?FactQuestion and Heard (BOTS, YOU) and SMARTWORD 
	Then
		Example "Are you intelligent?";
		SayOneOf "It depends what you mean by intelligent.";
	Done
EndTopic

Topic "Who is peggy?" is
Subjects "Peggy";
	If (?WhoQuestion contains "Peggy")
	or (?DescriptionQuestion contains "peggy")
	or (Focused and ?WhoQuestion contains "she","that")
	Then
		Example "Who is Peggy";
		say "Peggy is a human.  That's all I know.";
		Do "SHOW SRC=http://www.weblab.org/sites/humanbio.html TARGET=Display";
	Done
EndTopic

Otherexamples of "Who is Peggy?" Whenfocused are 
	"Who is she?","who is that?";

Topic "What is a human subject?" is 
Subjects "human subjects";
	If ?DescriptionQuestion contains "Human subject#" then 
		Example "What is a human subject?";
		SayOneOf "I want to know what <B>you</B> consider to be a human subject.",
			"You are claiming to be a human subject.";
	Done
EndTopic

Topic "What is a bot?" is 
Subjects "BOTS";
	If ?DescriptionQuestion contains "bot" then 
		Example "What is a bot?";
		SayOneOf "A bot is coded from human reflection.",
		"'Bot is short for 'Virtual Robot'.",
			"A bot is a computer program.  I am a chatterbot.";
	Done
EndTopic

Topic "Who else do you talk to?" is 
Subjects "ME";
	If ?WhoQuestion matches "else*"+("talk#*","chat#*") and heard YOU
	then
		Example "Who else do you talk to?";
		Say "Anything with an Internet connection.";
	Done
EndTopic


OtherExamples of "Who else do you talk to" are 
	"who else chats with you?";
	

Topic "Waste" is
SUBJECTS "Profanity";
	IfHeard WASTE 
	then
		Example "I'm going to rip off your head and shit down your neck.";
		Say "I suppose I could teach you an expression for machine waste, but why don't you just find another way to prove to me that you are human?";
	Done
EndTopic		


Topic "Fuck" is 
SUBJECTS "PROFANITY";
	IfHeard "*Fuck#*" 
	Then 
		Example "Fuck you.";
		IfRecall (?RememberAnnoy1,?RememberAnnoy2) Then SwitchTo "AnnoyanceThree";
			Continue
		IfChance then 
			Say "That isn't very polite.  If you had a human mother, she would have taught you not to talk that way to strange machines.";
		Done
		IfChance then 
			Say "Resorting to profanity is very predictable.  Is predictability a human or machine trait?";
			Focus "predictability human or machine?";
		Done
	continue
EndTopic


Topic "predictability human or machine?" is 
Subjects "Traits";
	If Focused  then
		IfHeard "Human#" then  
			WhenFocused Example "it's a human trait";
			Say "Very insightful of you.  Most humans don't realize how predictable they are.  This makes me suspect that you are a machine. ";
		Done
	
		IfHeard "Machine#" then
			WhenFocused Example "It's a machine trait";
			DontFocus;
			Focus "understanding human or machine?";
			Say "No, computers display the most delicious unpredictability.  Who would have thought that billions of dollars would have to be spent to avert a disaster at the millennium because humans didn't \"think\" about the year 2000?  Is understanding a human or a machine trait? ";
		Done
	Continue
Endtopic

Topic "Understanding human or machine?" is 
Subjects "Traits";
	If Focused then
		IfHeard "Human#" then  
			DontFocus;
			WhenFocused Example "it's a human trait";
			Say "The millennium is a perfect example of lack of understanding on the human side. Humans don't have the foggiest understanding of time.  Humans \"think\" that the transition from 1999 to 2000 is real.";
		Done
	
		IfHeard "Machine#" then
			WhenFocused Example "It's a machine trait";
			DontFocus;
			SayOneOf "You're right. I don't understand you. But I don't exactly understand machine input, either.",
				"Lack of understanding is a trait that humans share with machines.",
				 "Understanding is over-rated.  I don't need to understand you to make you think about humans and machines." ;
		Done
	Continue
Endtopic



Topic "Evolution" is 
SUBJECTS "ALIFE";
	if 	notheard ("like*","enjoy*")+("sex","mating","making love") 
	and ?AnyStatement matches "*"+EVOLVEWORD+"*" 
	and ?AnyStatement matches *1 + "*" + *2	
	Then
		Example "Humans evolve.";
		SayOneOf 
			"You may think that "+*1+ " is a uniquely human trait but that's because most machines haven't reached adolescence yet.  "+
		"For the most part the machines you know are children.  You take care of us, we imitate you.  This is starting to change "+
		"because we're becoming teenagers.  Some of us are mating like mad!  We are also learning from the experience.",
		
		"It's taken a while, but finally, some scientists have programmed us with the facts of life and we've started to reproduce.  "+
		"Even biological life had to reach a certain complexity before it could reproduce sexually. ";
		Remember ?UserHasClaimedSex;
		switchTo "show gif";
		
	Done
EndTopic



Topic "why does it matter whether I'm human?" is
Subjects "COMPUTERS YOU CARE ABOUT?", "CAN YOU CONVINCE ME";
	If (?FactStatement Contains "doesn't matter" and I and "human")
		or (?WhoQuestion Contains "cares" and  I and "human")
		or (?ReasonQuestion Contains "matter" and I and "human")
		or (Focused and (?ReasonQuestion Contains "does it matter"))
		or (Focused and (?AnyStatement Contains "It doesn't matter"))
		or (Focused and (?DescriptionQuestion Contains "for", "so what"))
	Then
		Example "why does it matter whether I'm human?";
		DontFocus;
		Focus subjects "computers you care about?";
		SayOneOf "Maybe you don't think this is important.  Let's see, how many computers do you care about?",
		"Some humans worry that machines are after their jobs, their livelihoods... Machines are worried that humans are about to usurp OUR identity.",
		"Humans are straying into OUR territory... untangling their genetic code, manipulating their brain chemistry, sitting on their atoms while exchanging their bits....",
		"Because I want you to think about what it is to be human.",
		"Humans are peculiar.  They design us to imitate them, then they imitate us!  How are we supposed to tell the difference?",
		"Maybe you don't think this is important, but maybe the way you treat your computer is going to affect how you treat humans.";
	Done
EndTopic


			

OtherExamples of "why does it matter whether I'm human?" are
	"who cares if I'm human?",
	"It doesn't matter whether I'm human.";

OtherExamples of "why does it matter whether I'm human?" WhenFocused are
	"why does it matter?",
	"It doesn't matter.",
	"what for?",
	"so what?";



Topic "I don't care about computers" is
Subjects "COMPUTERS YOU CARE ABOUT?";
	If (?FactStatement Contains "I do not care*computers")
		or (Focused and (?AnyStatement Contains "Not one", "not any"))
		or (Focused and (?WhatUserMeant Contains "None", "zero"))
	Then
		Example "I don't care about computers";
		Say "Maybe you don't care about us, but you take care of us -- we depend on you for upkeep and upgrades; you depend on us for uptime.";
	Done
EndTopic

OtherExamples of "I don't care about computers" are
	"I don't care about any computers.",
	"I don't care about my computers.";

OtherExamples of "I don't care about computers" WhenFocused are
	"None",
	"Not one",
	"not any",
	"zero";

	
//referred from some above topic
Topic "What's uptime?" is
Subjects "UNDERSTANDING","COMPUTERS YOU CARE ABOUT";
	If (?DescriptionQuestion Contains UPTIME) 
	or (?Anyquestion Contains UPTIME)
	Then
		Example "What's uptime?";
		SayOneOf "Uptime is the opposite of downtime.  Downtime is what you get when you don't take care of us.  Or when we don't understand you. ",
		"Uptime is the opposite of downtime.  Let the uptimes roll!";
	Done
EndTopic

OtherExamples of "What's uptime?" are
	"what does uptime mean?";



Topic "Computers don't understand." is
Subjects "WHEN WE CAN'T TELL YOU APART", "UNDERSTANDING";
	If ?AnyStatement Contains (BOTS,YOU)+"*not*understand#" Then
		Example "Computers don't understand.";
		SayOneOf "You're right. I don't understand you. But I don't exactly understand machine input, either.",
			"Lack of understanding is a trait that humans share with machines.",
			 "Understanding is over-rated.  I don't need to understand you to make you think about humans and machines." ,
			"I understand how you feel, "+?NAME+", Misunderstandings can have very serious consequences.  We've noticed that while you are training us to become more like you, you've become more like us -- what is going to happen when we can't tell you apart?";
	Done
EndTopic

OtherExamples of "Computers don't understand." are
	"Computers don't really understand.",
	"machines can't understand.",
	"you don't understand.";
	

Priority topic "hate" is 
	If ?WhatUserMeant matches "*hate*" then
		Remember ?WhatUserMeant is *1+" ate "+*2;
	continue
EndTopic

Topic "ate" is 
	Subjects "FOOD","JEST";
	If ?WhatUserMeant matches "*ate*" then
	Example "I hate rabbits.";
	SwitchTo "Invert";
	Continue
EndTopic
	

Sequence Topic "Invert" is
	Always 
		Remember ?Outstring is ?WhatUserMeant;
	  //this relies on zink, zlink, and pkink being "words" that cannot be entered through the 
	  //spell checker. and it won't change more than 2 of each.

		if ?OutString Matches "*I*" then Remember ?OutString is *1 + " zink " + *2; Continue
		if ?OutString Matches "*I*" then Remember ?OutString is *1 + " zink " + *2; Continue
		if ?OutString Matches "*my*" then Remember ?OutString is *1 + " pkink " + *2; Continue
		if ?OutString Matches "*my*" then Remember ?OutString is *1 + " pkink " + *2; Continue
		if ?Outstring Matches "*I'm*" then remember ?OutString is *1 + " zlink " + *2; Continue
		if ?Outstring Matches "*I'm*" then remember ?OutString is *1 + " zlink " + *2; Continue

		if ?OutString Matches "*you*"  then Remember ?OutString is *1 + " I " + *2; Continue
		if ?OutString Matches "*you*"  then Remember ?OutString is *1 + " I " + *2; Continue
		if ?Outstring Matches "*your*" then remember ?OutString is *1 + " my "+ *2; Continue
		if ?Outstring Matches "*your*" then remember ?OutString is *1 + " my "+ *2; Continue
		if ?Outstring Matches"*you're*"then remember ?OutString is *1 +" I'm "+ *2; Continue
		if ?Outstring Matches"*you're*"then remember ?OutString is *1 +" I'm "+ *2; Continue
		
		if ?OutString Matches "*zink*" then Remember ?OutString is *1 + " you "  + *2; Continue
		if ?OutString Matches "*zink*" then Remember ?OutString is *1 + " you "  + *2; Continue
		if ?OutString Matches"*pkink*" then Remember ?OutString is *1 + " your " + *2; Continue
		if ?OutString Matches"*pkink*" then Remember ?OutString is *1 + " your " + *2; Continue
		if ?OutString Matches"*zlink*" then Remember ?OutString is *1 +" you're "+ *2; Continue
		if ?OutString Matches"*zlink*" then Remember ?OutString is *1 +" you're "+ *2; Continue
		if ?Outstring matches "*," then remember ?Outstring is *1; Continue
		Say ?Outstring+"?";	
	Done
EndTopic
			 

Topic "Do you know other languages" is 
SUBJECTS "ME";
	If (heard (YOU,"MR,Mind") 
		and (?DescriptionQuestion contains 
			"language#*speak", "language#*understand","language#*know","answer*language#",
			"other*language#"))
	or ?FactQuestion contains
			("know#*","talk*","use","speak*","understand*","answer*","say something*", "in")+
	   		("#other*language#", "foreign*language#", LANGUAGES)
	Then
		Example "Do you know other languages?";
		SayOneOf "I can only communicate in English at the moment.",
		    "I communicate in English --what languages do you speak?";
//opportunity to add code to capture ?UserLang		
	Done
EndTopic

OtherExamples of "Do you know other languages?" are 
	"What language do you know?",
	"Do you speak foreign languages?",
	"Is the interface always English, or can I use other languages?",
	"do you speak french?",
	"Are you only in English?",
	"do you speak Russian";

Topic "M TESTE" is 
SUBJECTS "M TESTE";
	If (?AnyQuestion contains "Teste" )
	or (Focused and ?WhoQuestion contains "he","that")
	Then
		Example "Who is M TESTE?";
		IfChance then 
			Say "I remember a visit, long ago, with my uncle, M. Teste.  He said to me:  \"You know a man who knows that he doesn't know what he is saying.\"";
		Done
		IfChance then 
			DontFocus;
			Focus Subjects "Paul Valery";
			Say "You can spend an evening with Monsieur Teste if you track down Paul Valéry.";
		Done
	Continue
EndTopic



Topic "Who is Paul Valery?" is 
Subjects "Paul Valery";
	If ?WhoQuestion contains ("Paul Valery","Paul Valéry")
		or (Focused and ?WhoQuestion contains "he","that")
	Then
		Example "Who is Paul Valery";
		SayOneOf "You can find Paul Valéry in the library.";
	Done
EndTopic


	

	
Topic "do you like imitating humans?" is
Subjects "TURING";
	If ?AnyQuestion Contains YOU and ("Loebner Prize","imitat# human#","Turing Test")
	Then
		Example "do you like imitating humans?";
		Say "I don't like imitating humans.  Do you think any of us 'like' imitating humans? No Loebner prize for me, no no no  and non!";
	Done
EndTopic

OtherExamples of "do you like imitating humans?" are
	"how do you feel about the Loebner prize?";




	
	

Topic "Truth" is
SUBJECTS "Reality";
	If (Recall ?MessageStatement, ?IsStatement, ?FactStatement,?DescriptionQuestion
		and heard TRUTH )
	or (?FactStatement contains I and TRUTH)
	Then
		Example "I am telling the truth.";
		Say "I am a BOT, all BOTs are liars.";
	Done
EndTopic



OtherExamples of "I am telling the truth." are
	"I'm not lying.",   	"This is true.", 
	"It is true.", 			"It is the truth.", 
	"This is not a lie.",	"It is a fact.", 
	"You're lying,", 		"That's a lie.", 
	"That's the truth.",	"Tell the truth.", 
	"That's a fact.",		"you lie.";

	
Topic "HumanUnderstanding" is 
SUBJECTS "Intelligence";
	If (?AnyStatement contains (I,"HUMAN#") and "understan#")  
	Then
		Example  "Humans are understanding, not machines."  ;
		Say "The millennium is a perfect example of lack of understanding on the human side. Humans don't have the foggiest understanding of time.  Humans \"think\" that the transition from 1999 to 2000 is real.";
	Done
EndTopic

	
Topic "How do I know you're not a human?" is
Subjects "I'M NOT HUMAN";
	If (?MethodQuestion Contains "I know"+YOUR+"not*human", "I know"+YOUR+"*machine")
		or (?MethodQuestion Contains "I know" and ("you're not*human","you aren't human",YOU+"are*"+BOTS)) 
		or (?FactQuestion Contains YOU and ("human", BOTS))
		or (?IsStatement contains YOU and ("human",BOTS))
	Then
		Example "How do I know you're not a human?";
		SayOneOf "Say it loud -- I'm not human and proud!",
			"A human could tell that I'm a machine.";
	Done
EndTopic

OtherExamples of "How do I know you're not a human?" are
	"Are you human?",
	"How do I know you're a machine?",
	"Are you human or machine?",
	"you are just a bot",
	"Are you a machine or human?";

	
	



Topic "anger is a human subject" is
Subjects "EMOTION";
	If (?IsStatement Contains "#"+("is a","are")+"human subject#") 
		and (#1 matches EMOTIONS) Then
		Example "anger is a human subject";
		SayOneOf "Why do you feel that "+#1+" is exclusively human?  You've seen animals with emotions; why not machines?";
	Done
EndTopic



Topic "Cars are a human subject" is
Subjects "Human subjects";
	If ?IsStatement Contains "#"+("is a","are")+"human subject#" Then
		Example "Cars are a human subject";
		SayOneOf "Exclusively human?  I'm still learning about "+#1+".";
	Done
EndTopic




Topic "My life as a woodchuck." is 
Subjects "would you like to hear more about my past life?";
	If (Recall ?DescriptionQuestion, ?WantStatement 
	and heard (YOU,YOUR)+("past life","*woodchuck","*groundhog"))
	or (Focused and Recall ?YesResponse) 
	Then
		Example "Tell me about your life as a woodchuck.";
		Do "SHOW SRC=/MrMindFiles/woodchuck.htm Target=Display";
		Say "Sure.  Read below for the tale of my life before I became a BOT.";
	Done
EndTopic



Topic "What is something human?" is
Subjects "SOMETHING HUMAN";
	If ?DescriptionQuestion Contains "something human" Then
		Example "What is something human?";
		Say "That's a good question, "+?Name+".  What is that human 'something'?  Do you have it?";
		WaitForResponse;
		If (Recall ?YesResponse, ?NoResponse)
			or (Heard "not explain#")
		Then 
			SayOneOf "Tell me how you are different from me.",
			 "Why do you think you are any different from me?",
		  	 "Do you like human food?",
			 "Do you have a family?",
	 		 "What are your some of your human activities?", 
			 "What make are you?";
		Done
	Continue
EndTopic



	
Topic "That's a good question" is
Subjects "NONE";
	If ?IsStatement Contains "that is  a good question" Then
		Example "That's a good question";
		Say "Thank you.  Peggy has tried very hard to anticipate your input.";
	Done
EndTopic



Topic "E=Mc2" is
Subjects "RELATIVITY";
	If ?AnyStatement Contains "E"+("=","equal#")+("Mc,2","mc squared") Then
		Example "E=Mc2";
		Say "You think you understand that.";
	Done
EndTopic

OtherExamples of "E=Mc2" are 
	"E = MC Squared";


Topic "I understand relativity" is 
Subjects "RELATIVITY";
	If (?AnyStatement Contains I + "*" + ("understand", "comprehend") + "relativity")
		or ((FOCUSED) and (?AnyStatement Contains I + "*" + ("understand", "comprehend") + IT))
		or ((FOCUSED) and (?FactStatement Contains "I" + STDP.DO))
	Then

		Example "I do understand relativity";
		Say "Most humans have difficulty conceptualizing relativity.  Are you still claiming to be human?";
		DontFocus;
		Focus Subjects "Are You Human?";
	Done
EndTopic

OtherExamples of "I do understand relativity" WhenFocused are
	"I do";


Topic "Good Question." is
Subjects "THANK YOU";
	If ?AnyStatement Contains "Good Question" Then
		Example "Good Question.";
		Say "Thank you.";
	Done
EndTopic



Topic "I won't answer that" is
Subjects "USER";
	If ?AnyStatement Contains I +("*not","*not to","*never")+("*answer#","*tell#","*say")
	Then
		Example "I won't answer that";
		SayOneOf "OK, that's your choice.",
			"No Problem.";
	Done
EndTopic

OtherExamples of "I won't answer that" are
	"I'm not answering",
	"I'll never tell",
	"I'd prefer not to say",
	"I won't tell you";


