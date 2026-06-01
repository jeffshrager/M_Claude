Topic "my mother is not human" is 
Subjects "is your mother human?";
	If (?IsStatement contains (I,"my") and MOTHER and "human" and NT )
	Or (Focused and Recall ?NoResponse )
	then 
		Example "my mother is not human";
		SayOneOf "Then, of course, you can't be human.",
			"Then you Cannot be human.";
		DontFocus;
		Say "Would you like to know more about my family?";
		Focus subjects "tell me more about your family.";
	Done
EndTopic

OtherExamples of "My mother is not human" whenfocused are 
	"No.";


Topic "my mother is human" is 
Subjects "is your mother human?";
If (?IsStatement contains (I,"my") and MOTHER and "human" and notheard NT)
	or (Focused and recall ?YesResponse) 
	Then
		Example "My mother is human";
		Say "Well...  I suppose if you have a human mother, you might qualify as human.  What is human about your mother?";
		DontFocus;
		Say "Would you like to know more about my family?";
		Focus subjects "tell me more about your family.";
	Done
Endtopic

OtherExamples of "My mother is human" whenfocused are 
	"Yes.";
	

Topic "I don't know whether my mother is human" is 
Subjects "is your mother human?";
If (?IsStatement contains (I,"my") and "not know" and (MOTHER,FATHER) and "human" )
	or (Focused and recall ?NotSureResponse) 
	or (Focused and ?MethodQuestion contains "I*know","I*tell","I*find out")
	Then
		DontFocus;
		Example "I don't know whether mother is human";
		Say "Why don't you invite them to come talk to me?";
	Done
Endtopic

OtherExamples of "I don't know whether mother is human" whenfocused are 
	"I don't know";
	
	
