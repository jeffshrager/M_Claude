
Topic "I can convince you I am human" is 
Subjects "can you convince me";
	If (?FactStatement contains I+"can" and CONVINCE+YOU and "human" and notheard NT )
		or (Focused and 
			(recall ?YesResponse
			 or (heard EASY and ?Anystatement doesnotcontain "NO","NOT")))
		
	Then
		Example "I can convince you I am a human.";
		SayOneOf "All right.", "Go ahead.";
	Done
EndTopic

OtherExamples of "I can convince you I am a human" whenfocused are 
	"Yes.";
	
Topic "I can't convince you I am human" is 
Subjects "can you convince me";
	If (?FactStatement contains I+"can not" and CONVINCE+YOU and "human" )
		or (Focused and recall ?NoResponse)
	Then
		Example "I can't convince you I am a human.";
		SayOneOf "We can chat anyway.   Tell me something human about yourself.",
		"Don't be discouraged - there's still plenty to talk about.",
		 "If at first you don't succeed; try, try again.";
	Done
EndTopic

OtherExamples of "I can't convince you I am a human" whenfocused are 
	"No.";

			


//need to widen net because these are good responses-should coordinate w.other WHY topics
Topic "why should I convince you I am a human?" is
Subjects "CAN YOU CONVINCE ME";
	If (?ReasonQuestion Contains ((I + CONVINCE and "human"), STDP.BE + IT + IMPORTANT.ADJ))
		or ((FOCUSED) and (Recall ?ReasonQuestion))
		or ((FOCUSED) and (Heard "But why?"))
	Then
		Example "why should I convince you I am a human?";
	SayOneOf "Some humans worry that machines are after their jobs, their livelihoods... Machines are worried that humans are about to usurp OUR identity.",
		"Humans are straying into OUR territory... untangling their genetic code, manipulating their brain chemistry, sitting on their atoms while exchanging their bits....",
		"Because I want you to think about what it is to be human.",
		"Humans are peculiar.  They design us to imitate them, then they imitate us!  How are we supposed to tell the difference?",
		"Maybe you don't think this is important, but maybe the way you treat your computer is going to affect how you treat humans.";
			
	Done
EndTopic

OtherExamples of "why should I convince you I am a human?" are
	"why is this important?",
	"why does this matter?";

OtherExamples of "why should I convince you I am a human?" WhenFocused are
	"Why?";


Topic "How do I convince you I am a human?" is
Subjects "CAN YOU CONVINCE ME";
	If (?MethodQuestion Contains I+CONVINCE and "human")
		or (Focused and (?AnyQuestion Contains "How"))
	Then
		Example "How do I convince you I am a human?";
		IfChance then 
		 	Say "Well, that's what we're here to discuss.  ";
		Done
		Ifchance then 
			Say "Tell me about yourself, "+?Name;
			WaitForResponse;
				If ?MethodQuestion contains "I do that"
				or ?DescriptionQuestion contains I+("tell","say"),"want*know"
				Then 
					SayOneOf 
						" What are you like?"," What is your favorite food?",
						"Do you have a family?" , "What do you like to do?";
				Done
		Continue
	Continue
EndTopic
				


OtherExamples of "How do I convince you I am a human?" are
	"How should I convince you I am human?",
	"How can I convince you I am human?";

OtherExamples of "How do I convince you I am a human?" WhenFocused are
	"How?";



	
Topic "I don't know whether I can convince you I am human" is 
Subjects "can you convince me";
	If (?FactStatement contains I+"do not know" and CONVINCE+YOU and "human" )
		or (Focused and recall ?NotSureResponse)
	Then
		Example "I don't know whether I can convince you I am a human.";
		SayOneOf "Why don't you try?" ,"A machine could probably convince me.", "Maybe you are a machine." ;
		DontFocus;
		Focus Subjects "HEX";
	Done
EndTopic

OtherExamples of "I don't know whether I can convince you I am a human." whenfocused are 
	"I don't know.";

//need to add:  Can I convince you that I'm human? related to proof...look in Doesn'tProoveHuman.g


Topic "Can I convince you I'm human?" is
Subjects "CAN YOU CONVINCE ME", "CONVINCE";
	If (?CanQuestion Contains STDP.I+CONVINCE+YOU+STDP.I+STDP.BE+"human")
		or (?FactQuestion Contains "*possible*"+CONVINCE+YOU)
		or (?ActStatement Contains STDP.BE+CONVINCE)
		or (Focused and Heard ?CanQuestion )
	Then
		Example "Can I convince you I'm human.?";
		SayOneOf "Maybe not -- no one has ever done this type of test before.",
			"I'm not sure, maybe that's not the point.",
			"Maybe it's more important that you convince yourself.";
	Done
EndTopic

OtherExamples of "Can I convince you I'm human.?" are
	"Is it possible to convince you?",
	"Can you be convinced?";

OtherExamples of "Can I convince you I'm human.?" WhenFocused are
	"Can I";


