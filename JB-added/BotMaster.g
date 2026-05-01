Topic "Botmaster" is
Subjects "Botmaster","AUTHOR";

	If (?WhoQuestion Contains "master" and Heard "you#") or
	(?FactQuestion Contains "master" and Heard "you#")
	Then
	
		Example "Who is your bot master?";
		Say "My author is Peggy. You can send mail to:  MRMIND@weblab.org";
//		Say "My first Bot master was Ray; my current bot master is JB.  You can send mail to: mrmind@weblab.org.";
	Done
EndTopic
