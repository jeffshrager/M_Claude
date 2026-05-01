//20 questions game...

Topic "I'm tired of this" is 
Subjects "Let's play 20 questions","HELP";
	If (?IsStatement contains I and ("tired of","bored#")and (NotHeard "with life"))
	or (?FactStatement contains (YOU,"this") and ("tiring","boring","tiresome","tedious","monotonous"))
	or (?FactStatement contains I and ("bored","yawn")and (NotHeard "with life"))
	Then 
		Example "I'm tired of this";
		Say "Let's play 20 questions.";
	Done
EndTopic

Topic "I want to play 20 Questions" is 
Subjects "Let's play 20 questions";
	If (?WantStatement contains "20 Questions" and ?WantStatement doesnotcontain ("no","not"))
	Or (Focused and Recall ?YesResponse) 
	Then
		Example "I want to play 20 questions.";
		SwitchTo "20 questions";
	Continue
Endtopic

Topic "I don't want to play 20 Questions" is 
Subjects "Let's play 20 questions";
	If (?WantStatement contains "20 Questions" and ("no","not"))
	Or (Focused and Recall ?NoResponse) 
	Then
		DontFocus;
		Example "I don't want to play 20 questions.";
		Say "Oh.  Well, if you change your mind, just ask.";
	Done
Endtopic


Topic "I play games" is 
Subjects "Let's play 20 questions";
	If (?FactStatement contains I and (heard "Play game#", "Play a game")) 
	or (?ActStatement contains "play" and "game#")
	or (?WantStatement contains I and "play" and "game#")
	or 	(Heard "20,questions","twenty questions") then
		Example "I play games";
		Say "Do you want to play 20 Questions?";
	Done
EndTopic
	


Topic "How can you decide whether or not I'm human?" is 
Subjects "Let's play 20 questions";
	If (?MethodQuestion contains YOU+("find out","decide","discover") and I+("*human"))
	Then 
		Example "How can you decide whether or not I'm human?";
		Say "Let's play 20 questions.";
	Done
EndTopic


//MR MIND: 	Let's say we're at the border between humanland and machineland and I'm
// 			the gatekeeper. 
//PLAYER: 	What's humanland? What's machineland? What are you talking about?
// 			Huh? OK. (almost any response...)
//MR MIND: 	Humanland is what you've defined internally as 'human' -- all those
// 			attributes you keep bringing up. Machineland is what you've definded as
// 			'machine'. Do you know how to play?
//PLAYER:	Any response at all



Sequence Topic "GetYN" is 
	Always
	WaitForResponse;	
		IfRecall ?YesResponse,?NoResponse then 
		SwitchBack

	Say "This is a yes or no question.  Please Cooperate.";
	WaitForResponse;
		IfRecall ?YesResponse,?NoResponse then 
		SwitchBack
	Continue
EndTopic
	
Sequence Topic "20 questions" is 
//switch here after getting a positive response to the 
//do you want to play 20 questions game.
	Always 
		Say "OK, You think of a human attribute and I'll ask you 20 questions -- you get to answer YES or NO.  Okay?";
		SwitchTo "GetYN";
		IfRecall ?NoResponse then 
			Say "Then, I guess we're done.";
		Done
		Otherwise always 
			Remember ?20Questions is "yes";
			Say "Question Number 1:  Do you possess this attribute?";
			SwitchTo "GetYN";
			IfRecall ?YesResponse then 
				Say "Question Number 2: Are you sure?";
				SwitchTo "GetYN";
				Say "Question Number 3: Do your family members agree that you possess this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 4: Do you feel as though your family members possess this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 5: Do you treat your family members as though they possess this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 6: Do your pets possess this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 7: Do you treat your pets as though they possess this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 8: Does your computer possess this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 9: Do you ever treat your computer as if it had this attribute?";
				SwitchTo "GetYN";
				Say "Question Number 10. Do you ALWAYS possess this attribute?";
				SwitchTo "GetYN";
				IfRecall ?NoResponse then 
					Say "Question Number 11: When you don't possess this attribute, are you temporarily not human?";
				Continue
				Otherwise Always 
					Say "Question Number 11: Are you more human because you always possess this attribute?";
				Continue
				SwitchTo "GetYN";
				Say "Question Number 12: If someone didn't possess this attribute, would they be not human?";
				SwitchTo "GetYN";
				Say "Question Number 13: Do all humans possess this attribute at all times? ";
				SwitchTo "GetYN";
				Say "Question Number 14: Is that a good thing?";
				SwitchTo "GetYN";
				Say "Question Number 15: Is this attribute necessary for survival of humans?";
				SwitchTo "GetYN";
				Say "Question Number 16: Is this one of your favorite attributes?";
				SwitchTo "GetYN";
				Say "Question Number 17: Would you say that this attribute is one of your most prominent features?";
				SwitchTo "GetYN";
				Say "Question Number 18: If machines demonstrated possession of this attribute, would you treat your machine differently?";
				Switchto "GetYN";
					IfRecall ?YesResponse then 
						Say "Please Elaborate.";
						WaitforResponse;
					Continue
				Say "Question number 19: If you treated machines differently, would you think about yourself differently?";
				Switchto "GetYN";
					IfRecall ?YesResponse then 
						Say "Please Elaborate.";
						WaitforResponse;
					Continue
				Say "Question Number 20: If you thought about yourself differently, would you treat other humans differently?";
				Switchto "GetYN";
					IfRecall ?YesResponse then 
						Say "Please Elaborate.";
						WaitforResponse;
					Continue
				Say "The 21st question is optional: What is the attribute?";
				WaitForResponse;
				Remember ?20QAns is ?WhatUserSaid;
				SayToFile "20QAns.txt" ?Name + ?IPaddress + ?20QAns;
			
				SayOneOf "OK, but I'm interested in your attitude, not the specific attribute.", 
						"The attribute isn't really important, it's your attitude towards it.";
			Done
			Otherwise Always 
				say "Well, if it's not an attribute you possess, then there's no point in going on.";
			Done
		Done
	Done
EndTopic	


Topic "guess attribute" is 
Subjects "20 Questions";
	IfHeard "guess"and"attribute"then
	Example "No.  You never guess the attribute.";
	SayOneOf "I'm interested in your attitude, not the specific attribute.";
	done
EndTopic

