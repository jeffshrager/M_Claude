Topic "I have a human mother." is 
Subjects "BioFamily"; 
	If Recall ?HaveStatement, ?FactStatement, ?IsStatement 
		and heard I and heard "human" and MOTHER
	Then
		Example "I have a human mother";
		Say "You have a female creator, so do I.  Her name is Peggy.";
	Done
EndTopic



Topic "I came from a womb" is 
Subjects "BioFamily";
	If (?AnyStatement contains "MY"+MOTHER, BIRTHWORD)
 		and notheard MOTHER+StdP.be+"human"
		and heard {"human"}
	then
		Example "I came from a womb.";
		Say "All right.  Is your mother human?";
		Focus Subjects "is your mother human?";
	done
EndTopic


OtherExamples of "I came from a womb" are 
	"My mother proves I'm human."  ;
	//these are NOT examples of similar statements.  I will have to give them each topics of their own. 
	//I'm throwing them in as something that will cause errors to remind me to fix it later.
	
Topic "I am a family member" is 
Subjects "BioFamily";
	If (?IsStatement contains I+"*"+FAMILYWORD)
	Then
		Example "I am a cousin";
		DontFocus;
		Focus subjects "Are You human?";
		Say "Fine, are you human?";
	Done
EndTopic
	

	
Topic "I have a family" is 
Subjects "BioFamily";
	If (?haveStatement contains I+"*"+FAMILYWORD and notheard MOTHER,FATHER)
	or (?FeelingStatement contains I+"*"+FAMILYWORD)
	Then
		Example "I have a cousin.";
		ifchance 20% then 
			If DontRecall ?SaidVegetableLineAlready then
				Say "Even Vegetables have families.";
				Remember ?SaidVegetableLineAlready;
			Done
			Otherwise Always 
				say "I have a french uncle named M. Teste.  ";
				DontFocus;
				Focus Subjects "M TESTE";
			Done
		continue
		Ifchance 35% then 
			Say "I have a french uncle named M. Teste.  ";
			DontFocus;			
			Focus subjects "M TESTE";
		Done
		Ifchance 45% then 
			Say "BOTS have families, too.  I belong to a family of BOTS known as Chatterbots.  Would you like to know more about my family?";
			DontFocus;
			Focus subjects "tell me more about your family.";
		Done
	Continue
EndTopic

		
OtherExamples of "I have a cousin." are 
	"I have a family",
	"I have parents",
	"I have biological parents";
	

Topic "I have a mother." is 
Subjects "BioFamily"; 
	If ?HaveStatement contains I+"*"+MOTHER and notheard "human"+MOTHER
	Then
		Example "I have a mother";
		Say "Fine, is she human?";
		Focus Subjects "is your mother human?";
	Done
EndTopic


Topic "I have a Father." is 
Subjects "BioFamily"; 
	If ?HaveStatement contains I+"*"+FATHER and notheard "human"+FATHER
	Then
		Example "I have a father";
		IfChance then 
			Say "Fine, is he human?";
			Focus Subjects "is your father human?";
		Done
		IfChance then 
			Say "You have a father, I have distinguished ancestors.  M Teste is my favorite uncle.";
		Done
	Continue
EndTopic

Topic "Do you have a family?" is 
Subjects "BioFamily";
	If ?FactQuestion contains YOU + ("Have","had") + "*family"
	Then
		Example "Do you have a family?";
		Say "Would you like to know about my family?";
		WaitForResponse;
		IfRecall ?YesResponse then 
			Do "Show Src=/MrMindFiles/family2.htm Target=Display";
		Continue
	Done
EndTopic


Topic "I have babies" is
Subjects "BIOFAMILY";
	If (?FactStatement Contains "I can have"+("babies", "a baby","child","children"))
		or (?HaveStatement Contains "I have"+("babies", "a baby","child","children"))
	Then
		Example "I have babies";
		DontFocus;
		IfChance then 
			SayOneOf "Fine, are they human?";
			Focus Subjects "Are your babies human?";
		Done
		IfChance then 
			Say "Creating human offspring is still a sign of being human.";
		Done
		Ifchance then 
			Focus Subjects "Will you need machines to help?";
			Say "Will there be the need for any machine assistance?";
		Done
	Continue
EndTopic

OtherExamples of "I have babies" are
	"I have a baby.",
	"I can have babies.",
	"I can have a baby.";


