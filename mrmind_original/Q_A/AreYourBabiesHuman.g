//Are Your babies human 

//	IfChance then 
//		SayOneOf "Fine, are they human?";
//		Focus Subjects "Are your babies human?";
//	Done



Topic "My babies are human" is
Subjects "ARE YOUR BABIES HUMAN?";
	If (?IsStatement Contains "My babies are human")
		or (Focused and (Recall ?YesResponse))
	Then
		Example "My babies are human";
		Say "Creating human offspring is still a sign of being human, although sometimes machines are used to assist.";
	Done
EndTopic

OtherExamples of "My babies are human" WhenFocused are
	"Yes";


