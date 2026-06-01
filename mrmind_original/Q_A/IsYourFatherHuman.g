

Topic "my father is human" is 
Subjects "is your father human?";
If (?IsStatement contains (I,"my") and FATHER and "human" and notheard NT)
	or (Focused and recall ?YesResponse) 
	Then
		Example "My father is human";
		Say "Well...  I suppose if you have a human father, you might qualify as human.  What is human about your father?";
		DontFocus;
		Say "Would you like to know more about my family?";
		Focus subjects "tell me more about your family.";
	Done
Endtopic

OtherExamples of "My father is human" whenfocused are 
	"Yes.";
	
	

Topic "my father is not human" is 
Subjects "is your father human?";
	If (?IsStatement contains (I,"my") and FATHER and "human" and NT )
	Or (Focused and Recall ?NoResponse )
	then 
		Example "my father is not human";
		Say "Then You Cannot be human.";
		DontFocus;
		Say "Would you like to know more about my family?";
		Focus subjects "tell me more about your family.";
	Done
EndTopic

OtherExamples of "My father is not human" whenfocused are 
	"No.";
	
