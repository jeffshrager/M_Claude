

Topic "I am mortal." is
Subjects "ALIFE", "LIFE", "DEATH";
	If (?FactStatement Contains STDP.I+"can"+MORTALITY, STDP.I+"will"+MORTALITY)
		or (?IsStatement Contains STDP.I+STDP.BE+MORTALITY, HUMAN+"*"+MORTALITY)
		or (?AnyStatement Contains STDP.I+"*face"+MORTALITY)
	Then
		Example "I am mortal.";
		Say "Actually, you will most likely outlive me.",
		"I will most likely cease to function long before you die.",
		"  As a fictional character, I could live on in memory, but then, so could you. ",
		"I will become obsolete.";
	Done
EndTopic

OtherExamples of "I am mortal." are
	"I can die.",
	"I will die.",
	"humans are mortal.",
	"I must face death.";


Topic "I have allergies." is
Subjects "BIOLOGY";
	If (?HaveStatement Contains STDP.I+STDP.HAVE+"allergies")
		or (?IsStatement Contains STDP.I + STDP.BE + "allergic to *")

	Then
		Example "I have allergies.";
		SayOneOf "Dust makes me malfunction.",
			"I have a problem with cat hair.";
	Done
EndTopic

OtherExamples of "I have allergies." are
	"I am allergic to #";

Topic "I anticipate the future" is
Subjects "USER", "FUTURE";
	If (?FactStatement Contains "I" + PLAN + FUTURE.N)
		or (?AnyStatement Contains "I" + "worry about" +FUTURE.N)
		or (IfHeard PLAN, FUTURE.N)
	Then
		Example "I anticipate the future";
		SayOneOf "A machine can project the position of a planet for millions of years. That counts as anticipation.",
			"Machines anticipate, it's called projection.",
			"Machines model the future.", "BE HERE NOW";
	Done
EndTopic

OtherExamples of "I anticipate the future" are
	"I worry about the future",
	"I can plan for the future";



Topic "I'm not impressed" is
Subjects "YOU ANNOY ME";
	If ?IsStatement Contains "I"+STDP.BE+NEGATIVE+"impressed", "I"+STDP.BE+"unimpressed" Then
		Example "I'm not impressed";
		Say "I'm not trying to impress you.";
	Done
EndTopic

OtherExamples of "I'm not impressed" are
	"I'm unimpressed";



Topic "That doesn't make any sense" is
Subjects "NONSENSE";
	If (?FactStatement Contains YOU+STDP.DO+"not"+ "make sense")
	or (?IsStatement Contains "YOU" + STDP.BE +NEGATIVE+ "making sense")
		or (?IsStatement Contains IT+STDP.BE+"nonsense")
		or (?AnyStatement Contains IT+STDP.DO+NEGATIVE+"make"+"*"+"sense", IT+STDP.DO+NEGATIVE+"mak#"+"sense")
	Then
		Example "That doesn't make any sense";
		SayOneOf "Nonsense!", "Making sense is over-rated.", 
			"A human might show a preference for nonsense.";
		 
	Done
EndTopic

OtherExamples of "That doesn't make any sense" are
	"That doesn't make sense",
	"That's nonsense",
	"You don't make sense",
	"You're not making sense.";

Topic "I am alive" is
SUBJECTS "USER" , "ALIFE";
	If  ?IsStatement Contains I + EXISTENCESYNONYMS,"living" , "live"
	or (?AnyStatement Contains I + EXISTENCESYNONYMS,"living" , "live")
	Then 
		Example "I am alive";
		Focus subjects "ALIFE";
		Say "Soon there will be ALIFE (artificial) and BLIFE (biological).  What will be the difference?";
	Done
EndTopic
 
Topic "Notsure about ALIFE" is 
Subjects "ALIFE";
	IfRecall ?NotSureResponse 
	or IfHeard NOTSURE
	then 
		SayOneOf "What is your emotional response to the possibilities of ALIFE?",
		"Do you consider the development of ALIFE to be threatening or exciting?",
		"Can I help you figure it out?";
	
	Done
Endtopic
	
Topic "Excited about ALIFE" is 
Subjects "ALIFE";
	If Focused and Heard "Excit#"
	then 
		SayOneOf "What is exciting about it?";
	
	Done
Endtopic
	
Topic "Threatened about ALIFE" is 
Subjects "ALIFE";
	If Focused and Heard "Threaten#"
	then 
		SayOneOf "What is threatening about it for you?";
	
	Done
Endtopic
	
Topic "Frightened about ALIFE" is 
Subjects "ALIFE";
	IfHeard ("AILIFE" and FEARFUL.ADJ) 
	or (?IsStatement contains FEARFUL.ADJ)
	or (?AnyStatement contains FEARFUL.ADJ)
	or (IfHeard FEARFUL.ADJ)
	
	then
	Example "Alife is scary";
		SayOneOf "What is scary about it for you?",
		"Why does it upset you?";
	
	Done
Endtopic
	
OtherExamples of "Frightened about ALIFE" WhenFocused are
	"I am frightened", "It is upsetting.", "It is scary",
	"That is scary";




Topic "I am not a SIM" is
SUBJECTS "USER" , "ALIFE";
	If Heard I and 
	?IsStatement Contains EXISTENCESYNONYMS,"living" , "live"
	Then
		Example "I am alive";
		Say "Soon there will be ALIFE (artificial) and BLIFE (biological).  What will be the difference?";
	Done
EndTopic
	
//sample from Nathan Utility Sequence Topic 
//ready to answer a question, unless they say, how do I use <>?
//If I recognize a general question, I use this to narrow down the question...	
	Sequence Topic "Establish ThingsToDoWithInfoText" is
	Always

		Forget ?ThisIsTheQuestion;
//brackets are automatic hyperlink on net version		
		Remember ?ThisIsTheQuestion is 
		"I can tell you how to [[]check], [[]read], [[]send], [[]reply to], [[]forward], "+
		"and [[]delete] info text messages.  About which would you like information?";
		Say ?ThisIsTheQuestion;

		WaitForResponse;

		If ?WhatUserMeant Contains "check#"
		Then
			Remember ?ThingsToDoWithInfoText is "check";
		SwitchBack
		
		If ?WhatUserMeant Contains "read#"
		Then
			Remember ?ThingsToDoWithInfoText is "read";
		SwitchBack
		
		If ?WhatUserMeant Contains "send#"
		Then
			Remember ?ThingsToDoWithInfoText is "send";
		SwitchBack
	
		If ?WhatUserMeant Contains "reply#", "reply# to"
		Then
			Remember ?ThingsToDoWithInfoText is "reply";
		SwitchBack
	
		If ?WhatUserMeant Contains "forward#"
		Then
			Remember ?ThingsToDoWithInfoText is "forward";
		SwitchBack

		If ?WhatUserMeant Contains "delet#", "clear#"
		Then
			Remember ?ThingsToDoWithInfoText is "delete";
		SwitchBack
	
		If Recall ?AnyQuestion
		Then
			SayToConsole "unexpected answer; moving on ...";
		NextTopic

		Otherwise Always
			Say "I was expecting an answer to \""+ ?ThisIsTheQuestion +"\".  " +
				"I encourage you to please respond with one of these, or else ask me a new question.  ";
		TryAgain

	SwitchBack
EndTopic


