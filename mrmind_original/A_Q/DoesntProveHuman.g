//focused by   <> topics?
Topic "Responses to Doesn't prove human" is
Subjects "doesn't prove human","PROOF";
	If ((Heard ("what does", "what will", "what would", "what proves")) and ((FOCUSED) or (Heard "prove*" + I + "*human")))
		or (?DescriptionQuestion Contains ("would" + STDP.YOU + RECEIVE.V + "*" + PROOF.N, "would" + STDP.YOU + RECEIVE.V + "*proof"))
		or ((FOCUSED) and (?DescriptionQuestion Contains "could" + PROVE.V + "*"))
	Then
		Example "what would prove that I'm a human?";
		SayOneOf "Whatever you think is a fair test of humanity.",
		"If I knew the answer to that question, I wouldn't need to exist.",
			"That is the challenge -- maybe it can't be proved in this manner.",
			"Maybe it's not important to prove to me that you're human.";
	Done
EndTopic

OtherExamples of "what would prove that I'm a human?" are
	"what would you accept as proof?",
	"what would you accept for proof?";

OtherExamples of "what would prove that I'm a human?" WhenFocused are
	"What could prove it?";

OtherExamples of "Responses to Doesn't prove human" are
	"What proves that I'm human?",
	"What does it take to prove that I'm human?";
		

