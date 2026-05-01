//IMakeUSelfConscious.g


Topic "I am conscious." is
Subjects "Consciousness";
	If (?HaveStatement Contains I and "conscious#")
		or (?IsStatement Contains I and "conscious#")
	Then
		Example "I am conscious.";
		SayOneOf "I don't have to be conscious to cause a human to be self-conscious.",
			"Consciousness is over-rated.  Do I make you self-conscious?";
			DontFocus;
			Focus Subjects "Do I make you self-conscious?";
	Done
EndTopic

OtherExamples of "I am conscious." are
	"I have consciousness";


	
Topic "I am aware." is
Subjects "Consciousness";
	If (?HaveStatement Contains I and "aware#")
		or (?IsStatement Contains I and "aware#")
	Then
		Example "I am aware.";
		SayOneOf "I don't have to be aware to cause a human to be self-conscious.",
			"awareness is over-rated.  Do I make you self-conscious?";
		DontFocus;
		Focus Subjects "Do I make you self-conscious?";
	Done
EndTopic



Topic "you make me self-conscious." is
Subjects "DO I MAKE YOU SELF-CONSCIOUS?";
	If (?FactStatement Contains YOU and "make me self-conscious")
		or (Focused and Recall ?YesResponse)
	Then
		Example "you make me self-conscious.";
		Say "Do machines usually make you self-conscious?";
		DontFocus;
		Focus Subjects "Do machines usually make you self-conscious?";
	Done
EndTopic

OtherExamples of "you make me self-conscious." WhenFocused are
	"yes.";


Topic "you don't make me self-conscious." is
Subjects "DO I MAKE YOU SELF-CONSCIOUS?";
	If (?FactStatement Contains YOU and "not make me self-conscious")
		or (Focused and Recall ?NoResponse)
	Then
		Example "you don't make me self-conscious.";
		Say "Do humans make you self-conscious?";
		WaitForResponse;
			If Recall ?YesResponse, ?NoResponse, ?NotSureResponse 
			then
				Say "I thought consciousness was a mark of being human.";
			Done
	Continue
EndTopic

OtherExamples of "you don't make me self-conscious." WhenFocused are
	"no.";




Topic "Why do you care whether you make me self-conscious?" is
Subjects "DO I MAKE YOU SELF-CONSCIOUS?";
	If (?ReasonQuestion Contains "do you care whether you make me self-conscious")
		or (Focused and (?AnyQuestion Matches "Why"))
		or (Focused and (?ReasonQuestion Contains "you care", "you want to know"))
		or (Focused and (?DescriptionQuestion Contains "for"))
	Then
		Example "Why do you care whether you make me self-conscious?";
		Say "Self-consciousness still qualifies as a traditional human marker.";
	Done
EndTopic

OtherExamples of "Why do you care whether you make me self-conscious?" WhenFocused are
	"Why do you care?",
	"Why do you want to know?",
	"What for?",
	"Why?";


