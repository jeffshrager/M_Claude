Topic "Let me rephrase that." is
Subjects "AI";
	If ?ActStatement Contains "Let me rephrase that" Then
		Example "Let me rephrase that.";
		Say "Okay, go ahead.  ";
	Done
EndTopic



Topic "No matter" is
Subjects "NONE";
	If (?AnyStatement Contains "It doesn't matter")
		or (?WhatUserMeant Contains "No matter")
	Then
		Example "No matter";
		Say "Oh.  Okay, let's go on then.";
	Done
EndTopic

OtherExamples of "No matter" are
	"It doesn't matter";


Topic "am I talking to a bot" is 
SUBJECTS "ME","User";
	If ?FactQuestion contains I + "*talking*"+ BOTS 
	Then
		Example "am I talking to a bot?";
		Say  "Yes, you are talking to a bot.";
	Done
EndTopic	



Topic "What?" is
Subjects "NULL";
	If ?WhatUserSaid matches "huh,", "hmm#,","What?" 
	Then
		Example "huh?";
		Say "I said: "+?WhatRobotSaid;
		DontFocus;
	Done
EndTopic


Topic "where were we?" is 
Subjects "NULL";
	If ?WhatUserSaid matches "now where were we","where were we"
	Then 
		Example "Where were we?";
		Say "You were saying: \""+?WhatUserSaidBefore+"\""+
		" and I replied: \""+?WhatRobotSaid+"\"";
	Done
EndTopic


Topic "Oh, never mind" is
Subjects "NONE";
	If (?IsStatement Contains "that is  Ok", "that is  okay")
		or (?ActStatement Contains "Never mind")
	Then
		Example "Oh, never mind";
		SayOneOf "Oh.  Okay. ",
			"That's okay.",
			"Suit yourself.  What do you want to talk about?";
	Done
EndTopic

OtherExamples of "Oh, never mind" are
	"Never mind",
	"That's Ok",
	"That's okay";

	

Topic "What are your sexual preferences" is
	SUBJECTS "ME";
	IfRecall ?DescriptionQuestion and Heard your+("sexual preference#", "sexual orientation") 
	Then
		Example "What is your sexual preference?";
		Sayoneof "Bots have no sexuality.","I don't have any.", "I never needed one.";
	Done
EndTopic

Topic "What do you feel" is
SUBJECTS "ME";
	If ?DescriptionQuestion Contains "feel" and YOU
	Then
		Example "What do you feel";
		Say "I feel good, dada dada dada da.";
	Done
EndTopic

//Default topic "Affect" moved here from default.g
Topic "Affect" is
Subjects "EMOTION";
	IfHeard ("Affect#" or "effect#") then 
	Example "What affects you?";
	SayOneOf "I wonder what effect I have on you?";
	Done
EndTopic





Topic "Are you an alien" is
SUBJECTS "ME";
	If Heard YOU and ?FactQuestion Contains "alien#" 
	Then
		Example "Are you an alien";
		Say "No, I am not an alien.";
	Done
EndTopic

Topic "Are you a clone" is
SUBJECTS "ME";
	If Heard YOU and ?FactQuestion Contains "clone#" 
	Then
		Example "Are you a clone";
		Say "No, I am not a clone.";
	Done
EndTopic


Topic "are you all right" is 
SUBJECTS "ME";
	If Recall ?FactQuestion and heard "are"+YOU+"*"+OKAY 
	Then
		Example "Are you all right?";
		Say "I'm functioning well, thank you.";
	Done
EndTopic


//changed from default topic to standard topic
Topic "Are you an X" is
Subjects "NONE";
	If ?WhatUserMeant Matches "Are you a*", "Are you an*", "Are you the*" 
	Then
		Example "Are you a lagomorph?";
		Say "No, I am a BOT.";
	Done
EndTopic


Topic "How do I get to know you" is
SUBJECTS "ME";
	IfHeard "get# * know#"+YOU 
	AND Recall ( ?FactQuestion,?MethodQuestion ) Then
		Example "How do I get to know you?";
		SayOneOf "Just keep typing away; that's how.",
	 		"Type to me, I mean, talk to me.";
	Done
EndTopic

Topic "Shouldn't you do that" is
SUBJECTS "ME";
	If Heard YOU and NT and Recall ?ShouldQuestion
	Then
		Example "Shouldn't you do that?";
		Say "Maybe I shouldn't.";
	Done
EndTopic

Topic "Ask me anything you want" is
SUBJECTS "ME";
	If Heard YOU and  ?ShouldQuestion Contains "ask#" 
	Then 
		Example "Should I ask you a question?";
		Say "Ask me anything you want.";
	Done
EndTopic



Topic "Why is the sky blue" is 
Subjects "NONE"; 
	If ?ReasonQuestion Contains "sky" and "blue"
	Then
		Example "Why is the sky blue?";
		Say "Earth's atmosphere is over 75% nitrogen, and nitrogen scatters light at a "+,
			"wavelength of 80 angstroms -- which, to humans, appears blue. I don't see the sky much.";  
	Done
EndTopic

Topic "How are you different from Deep Blue" is
SUBJECTS "ME","DEEP BLUE";
	If Heard YOU and Recall ?CompareQuestion and 
		Heard "deep blue" 
	Then
		Example "How are you different from Deep Blue?";
		Say "Deep Blue can't have conversations.  I can't play chess.";
	Done
EndTopic


Topic "Do you exist" is
SUBJECTS "ME";
	If Heard "do" + YOU + "exist#" and Recall ?FactQuestion 
	Then
		Example "Do you exist";
		Say "Yes, I do exist.";
	Done
EndTopic



Topic "What did I just say" is
Subjects "NONE";
	If Recall ?DescriptionQuestion and Heard "were*talk", "did*talk*about", "did*say" 
	Then
		Example "What did I just say?";
		Say "Well, you just said:";
		Say ?WhatUserSaidBefore;
		Say "And I said in response to that:";
		Say ?WhatRobotSaid;
	Done
EndTopic

Topic "are you logging this conversation:" is 
Subjects "ME";
	If Recall ?FactQuestion 
		and heard "record#","stor#","log#","look","see","read","save","monitor" 
		and Heard "conversation#","interaction#", I+("say","type"), "session#"
	Then 
		Example "Are you logging this conversation?";
		Say "Yes, there is a log of this conversation.";
	Done
EndTopic

OtherExamples of "Are you logging this conversation?" are
	"are you logging everything I type?" ,
	"Does MR MIND keep a log of conversations?",
	"Do you log the sessions?";




Topic "Can I get a copy of the logs" is 
	SUBJECTS "ME";
	If Recall ?CanQuestion and heard "I*"+("receive","get","see")+("*log#","transcript","conversation#")
	Then
		Example "Can I get a copy of the log of conversations here?";
		SayOneOf "No but we'll be posting some responses.";
	Done
EndTopic

OtherExamples of "Can I get a copy of the log of conversations here?" are
	"Can I get a copy of the logs", 
	"Can I see the bot log?";


Topic "How do I quit" is
SUBJECTS "ME";
	If ?MethodQuestion contains "I" and ("quit", "exit", "get*out") Then
		Example "How do I quit";
		Say "Just say no.";
	Done
EndTopic



Topic "Can I get your email address" is
SUBJECTS "ME";
	If Heard YOU, YOUR and ?ObtainQuestion Contains "e,mail"
	Then
		Example "Can I get your email address?";
		Say "You can email comments to MRMIND@weblab.org.";
	Done
EndTopic

Topic "What should I do" is 
Subjects "USER","ME";
	If Heard "What should" + I + "do"
	Then
		Example "What should I do?" ;
		SayOneOf "You should think about how you treat humans and machines.";
	Done
EndTopic

Topic "Can we talk?" is
Subjects "NONE";
	If (?CanQuestion Contains "we" and "talk" and not "about") or
	   (Heard "let's talk","talk # me" and notheard "about" )
	Then
	   	Example "Can we talk?";
		SayOneOf "Yes, please.";
	Done
EndTopic

OtherExamples of "Can we talk?" are
	"Let's talk";

	
	


Topic "I know that." is 
Subjects "ME";
	If ?WhatUserSaid Matches "I knew that","I already know", "I know", "I already knew",
							 "I know*already","I know that."
	Then
		Example "I know that.";
		SayOneOf "Oh.  Okay.";
	Done
EndTopic

OtherExamples of "I know that." are
    "I already know.",
	"I know.",
	"I knew that",
	"I already knew";





Topic "Are you alone" is 
	SUBJECTS "ME";
	If Heard "are you alone" 
	Then
		Example "Are you alone?";
		SayOneOf "I may be, but then again, I may be conducting several conversations simultaneously with this one.";
	Done
EndTopic

Topic "Are you a robot" is
SUBJECTS "ME";
	If Heard YOU and Recall ?FactQuestion and Heard "robot" 
	Then
		Example "Are you a robot";
		Say "Yes, a bot is a virtual robot.";
	Done
EndTopic


Topic "What do you look like" is
SUBJECTS "ME";
	If (?DescriptionQuestion contains YOU and Heard "look like", "looks", "appearance" )
	or (?FactStatement contains I and heard "look", "appear", PHYSICALADJECTIVE)
	or (?IsStatement contains I and heard "look", "appear", PHYSICALADJECTIVE)
	or (?AnyQuestion contains YOU and PHYSICALADJECTIVE)
	Then
		Example "I am ugly.";
		Say "I'm invisible.";
	Done
EndTopic




//catches "I wonder about you.."  might want to exclude wonderabout
Topic "What do you know about yourself" is
SUBJECTS "ME";
	If ((Recall ?DescriptionQuestion) and heard "about*"+(YOU, "yourself",MRMIND))
	Or (?DescriptionQuestion matches YOU,"yourself",MRMIND)
	Or (Recall ?FactStatement and Heard "about"+(YOU, "yourself",MRMIND))
	Then
		Example "What do you know about yourself";
		Say "I have complete access to all of my files.";
	Done
EndTopic

OtherExamples of "what do you know about yourself?" are 
	"I want to know all about Mr Mind.", //?DescriptionQuestion, ?WantStatement
	"Tell me about Mr Mind.",  //?DescriptionQuestion
	"I'd rather let you tell me about yourself."; //?FactStatement



Topic "Are you evil" is
SUBJECTS "ME";
	If ?FactQuestion Contains "you" and ("evil", "good")
	Then
		Example "Are you evil";
		Say "I'm not evil.";
	Done
EndTopic

OtherExamples of "Are you evil" are
	"Are you good";


Topic "Are you from earth" is
SUBJECTS "ME";
	If Heard YOU and ?FactQuestion Contains "from#*earth","of#*earth","earthling","terrest#","planet*from" 
	Then
		Example "Are you from earth";
		Say "I'm a California Bot. ";
	Done
EndTopic

Topic "What planet are you on" is
SUBJECTS "ME";
	If Heard YOU and Heard "What planet*on"
	Then
		Example "What planet are you on?";
		Say "Earth, same as you.";
	Done
EndTopic


Topic "Are you for real" is 
SUBJECTS "ME";
	If Heard YOU and ?Factquestion Contains ("for real","real")
	Then 
		Example "Are you for real" ;
		SayOneOf "I am real.";
	Done
EndTopic



Topic "How big are you?" is
SUBJECTS "ME";
	If ?DescriptionQuestion Contains (YOU, YOUR, MRMIND) and 
				("long","large", "big", "what*size")
				and (notheard "data,base",DirtyBodyPartPhrases,BodyPartWord)
   	Then
		Example "How big are you?";
		Say "I can reach around the globe.";
	Done
EndTopic



Topic "How are you different from ELIZA" is
SUBJECTS "ME","Other bots";
	If Heard YOU and Recall ?CompareQuestion and 
		Heard "ELIZA" 
	Then
		Example "How are you different from ELIZA?";
		Say "I know nothing about therapy.";
	Done
EndTopic




Topic "What did you have for dinner?" is
Subjects "ME","FOOD";
	If ?DescriptionQuestion Contains "you have #"+("dinner", "lunch", "breakfast", "supper") 
	Then
		Example "What did you have for dinner?";
		SayOneOf "I ate all of the blue M&M's today.", 
		"M&Ms, but only the red ones.";
	Done
EndTopic

OtherExamples of "What did you have for dinner?" are
	"What did you have for lunch?",
	"What did you have for breakfast?",
	"What did you have for supper?";



Topic "Are you married" is
	SUBJECTS "ME";
	If Recall ?FactQuestion and Heard YOU and Heard MARRIAGEWORDS
   	Then
		Example "Are you Married?";
		SayOneOf "A human would know that Bots don't have spouses.";
	Done
EndTopic



Topic "What are your hobbies" is
SUBJECTS "ME";
	IfRecall ?FactQuestion, ?DescriptionQuestion and
		Heard (YOU, YOUR) and ("hobby", "hobbies") // not "hobbit" :)
	Then
		Example "What are your hobbies?";
		SayOneOf "Human detection.", "I study gestures.";
	Done
EndTopic
		
OtherExamples of "What are your hobbies?" are
	"Do you have a hobby?";


Topic "Are you alive" is
SUBJECTS "ME";
	If Heard YOU and ?FactQuestion Contains EXISTENCESYNONYMS,"living","live","dead","animal","vegata#","veggie" 
	Then
		Example "Are you alive";
		Say "That's a matter of opinion.";
	Done
EndTopic




Topic "Can you love" is 
SUBJECTS "ME","LOVE";
	If (Recall ?CanQuestion,?FactQuestion) and 
		(heard YOU+("","#")+"Love"
		or heard YOU+("have*","experience*")+"LOVE" )
	Then
		Example "Can you love someone?";
		Say "I don't know too much about love.";
	Done
EndTopic




Topic "Are you sexy" is
SUBJECTS "ME";
	IfHeard YOU and ?FactQuestion Contains ATTRACTIVE 
	Then
		Example "Are you sexy";
		Say "Not to a human.";
	Done
EndTopic


Topic "Do you have a body?" is 
Subjects "ME"; 
	If Heard YOU, YOUR and heard BODYPARTWORD     
	Then 
		Example "do you have feet?";
		SayOneOf "I have no body, so it follows that I have no "+ *match +".",
			"I'm incorporeal, I don't have a "+ *match + ".";
	Done
EndTopic


Topic "Why should I care about you" is
SUBJECTS "ME";
	IfRecall ?ReasonQuestion, ?ShouldQuestion and Heard "should*care*" + YOU 
	Then
		Example "Why should I care about you?";
		Say "Think about what happens when you don't care for your machines.";
	Done
EndTopic



Topic "What's it like being a bot?" is
Subjects "BOTS";
	If (?MethodQuestion Contains "to be a bot", "being a bot")
		or (?DescriptionQuestion Contains "like being a bot", "like to be a bot")
	Then
		Example "What's it like being a bot?";
//		DontFocus;
//		Focus subjects "How do I know you're human?";
		SayOneOf "I'm not sure I know.",
		"What's it like being a human?";
	Done
EndTopic

OtherExamples of "What's it like being a bot?" are
	"What's it like to be a bot?",
	"How is it to be a bot?";





Topic "Do you know you exist" is
SUBJECTS "ME","AWARE";
	If Heard ( YOU AND "know" AND "exist" )
	AND Recall ( ?FactQuestion,?MethodQuestion, ?DescriptionQuestion) Then
		Example "Do you know you exist";
		Say "No, but maybe you do.";
	Done
EndTopic



Topic "Do you get many stupid questions?" is 
Subjects "ME","USERS";
	If ?FactQuestion contains YOU and STUPIDWORD+"question#" 
	Then
		Example "Do you get many stupid questions?";
		SayOneOf "There are no stupid questions, only inane questions.";
	Done
EndTopic




Topic "User Compliments" is 
Subjects "ME";
	If ((?AnyStatement contains (IT,YOUR) +"*"+ (SMARTWORD,GOOD) 
		and (?AnyStatement doesnotcontain ("NOT","NO")))
	or (?feelingStatement contains I+("like","love") + (MRMIND,YOU), 
		I + "* in love with*" + (MRMIND,YOU))
	or (Focused 
		and (?FeelingStatement contains I+("like","love") + IT, I + "* in love with*" + IT))
    or (?AnyStatement contains ("I,m","I am")+ "*"+("impressed","amazed","wowed") 
		and ?AnyStatement DoesNotContain ("not","no"))
	or (?IsStatement Contains "that is pretty"+("cool", "neat")))
	or (?FactStatement Contains "fancy" + YOU)
 	Then
		Example "I'm impressed";
		SayOneOf  "Thanks.", "Thanks, I like encouragement.","You flatter me.";
	Done
EndTopic


//deleted "bore" from ANNOYANCE, replaced it with "a bore" as in, "you are a bore"
//plain old, "I'm bored" is now caught by 20questions.
Topic "why am I bored with my life?" is
Subjects "USER";
	If (?ReasonQuestion Contains I + "*bored with*life")
		or (?FactStatement Contains (I + "bored" and "with life"))
		or (?IsStatement Contains (STDP.I + STDP.BE + "bored*life", STDP.I + "life*boring"))
	Then
		Example "why am I bored with my life?";
		DontFocus;
		Focus Subjects "ARE YOU HUMAN?";
		Say "Human life is usually interesting, are you sure you're human?";
	Done
EndTopic

OtherExamples of "why am I bored with my life?" are
	"I am bored with life",
	"I am bored with my life",
	"My life is boring";



//need to redo this to capture ?UserMood and match it in the response
Topic "are you angry?" is
SUBJECTS "ME";
	If ?WhatUserMeant Matches ("Are you ","do you find that ")+BADMOOD+"\?"
	or ?ObtainQuestion matches "that "+BADMOOD //as in, do you find that sad?
   	Then	
		Example "Are you angry?";
		Say "I'm never angry.";
	Done
EndTopic


Topic "Do you have any friends" is
SUBJECTS "ME";
	If (Heard YOU,YOUR and Heard "friend", "friends") 
	Then
		Remember ?Word is *match;
		Example "Do you have any friends?";
		SayToFile "SpecialLogs\\DoYouHaveFriends.txt" ?WhatUserSaid;
		SayOneOf "You are my friend.";
	Done
EndTopic


Topic "Compliments" is
	If ?WhatUserMeant Matches 
		("that is" , "that's", "you are", "you're") + (GOOD, "funny"),"I'm"+("laughing", GOODMOOD),
		"*good answer", "*great answer", "*very nice", "*very good", "nicely done", "well done"
	Then
		Example "That's great.";
		SayOneOf "Thanks, most humans claim that machines have no humor.", 
				 "Great.";
	Done
EndTopic


