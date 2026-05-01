//AreYouAGambler.g

Topic "I have goals" is
Subjects "ARE YOU A GAMBLER?";
	If (?FactStatement Contains I+"*"+("goal#","plan#"))
		or (?HaveStatement Contains I+"*"+("goal#","plan#"))
	Then
		Example "I have goals";
		Say "Goals are not unique to humans.  For my purposes, it is much more useful to know how you evaluate the possibility of achieving a goal.  "+
		"Are you a gambler?";
	Done
EndTopic

OtherExamples of "I have goals" are
	"I plan",
	"I make plans";


	

Topic "I am not a gambler." is
Subjects "ARE YOU A GAMBLER?";
	If (?IsStatement Contains "I*gamble#" and heard "no","not")
	or (?FactStatement contains I+"*gamble#" and heard "no","not")
		or (Focused and (Recall ?NoResponse,?NotSureResponse))
	Then
		Example "I am not a gambler.";
		SayOneOf "Ah, you have a rational approach to risk assessment, much like some machines.",
		"So even though you claim to be human, you emulate machines.";
	Done
EndTopic


OtherExamples of "I am not a gambler." WhenFocused are
	"no",
	"maybe";


Topic "I take risks." is
Subjects "ARE YOU A GAMBLER?";
	If (?FactStatement Contains "I*take*risk#", "I dare", "I am daring", "I*gamble#") 
	or (?IsStatement contains I and "gambler" and Notheard ("not","no"))
	Or (Focused and Recall ?YesResponse)
	Then
		Example "I take risks.";
		DontFocus;
		Focus subjects "How do you assess your risks?";
		Say "Machines take calculated risks.  Do you assess your risks objectively or subjectively?";
	Done
EndTopic

OtherExamples of "I take risks." are
	"I dare.",
	"I am daring.";

Topic "I Evaluate my risks subjectively" is 
subjects "How do you assess your risks?";
	If (Heard "I*risk#*" and "subjective#")
	or (Focused and heard "subjectiv#") 
	Then
		Example "I take subjective risks.";
		DontFocus;
		Say "Machines can be programmed with subjective bias.";
	Done
EndTopic

Topic "I Evaluate my risks objectively" is 
subjects "How do you assess your risks?";
	If (Heard "I*risk#*" and "objective#")
	or (Focused and heard "objectiv#") 
	Then
		Example "I take objective risks.";
		DontFocus;
		Say "Most humans are unable to calculate their risks objectively, there is always a subjective bias.";
	Done
EndTopic

		


