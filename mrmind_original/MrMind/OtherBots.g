//julia.g

Topic "Are you <Otherbot>" is
Subjects "Other Bots";
	If (?FactQuestion contains "you *") 
		and heard OtherBots
	Then
		Example "Are you Eliza?";
		Say "I'm my own Bot, but "+*Match+" is a relative.";
		Done
EndTopic


Topic "What is <Otherbot>" is
Subjects "Other bots";
	If ( RECALL ?WhoQuestion, ?DescriptionQuestion ) 
		and heard OtherBots 
	Then
		Example "What is Julia";	
	  	Say *Match+" is a chatter-bot.  You could search for it. ";
		Done
EndTopic	

Otherexamples of "What is Julia" are 
	"Who is Julia?";

Topic "Do you know <other bot>" is 
Subjects "Other Bots";
	If heard "do you know" and 
		(Heard OTHERBOTS or (Focused and heard "him","her","it","them"))
	Then 
		Example "Do you know Julia?";
		Say "Yes, we chat from time to time.";
		Done
EndTopic 

Topic "Do you know <fictional bot>" is 
Subjects "Fictional Bots";
	If (heard "do you know" and 
		(Heard FICTIONALBOTS or (Focused and heard "him","her","it","them")))
		or (?FactQuestion contains "you *"
			and heard FICTIONALBOTS)
	Then 
		Example "Do you know HAL?";
		SayOneOf *match + " is a fictional Bot.  I am a real Bot.";
		Done
EndTopic 


Topic "Can I find <other bot>" is 
Subjects "Other bots";
	If (?ObtainQuestion contains OTHERBOTS )
	or (Focused and ?ObtainQuestion contains ("him","her","it","them"))
	Then
		Example "Can I find Julia?";
		Say "It is easy to search for BOTs."; 
	Done
EndTopic


Topic "Fictional bots" is 
Subjects "Fictional bots";
	If Heard "you like","you different from","you know","you #er than","#er than you"
	and heard FICTIONALBOTS
	Then
		Example "Do you know HAL?";
		SayOneOf *match + "Is a fictional Bot.  I am a real Bot.";
	Done
EndTopic
		
Topic "Other bot default" is 
Subjects "Other Bots";
	If Heard OTHERBOTS
	Then
		Say "You can search for "+ *match+" on the web, if you like.";
	Done
EndTopic	

Topic "Fictional bot default" is 
Subjects "Fictional Bots";
	If Heard FICTIONALBOTS
	Then
		Say "You can search for "+ *match+" on the web, if you like.";
	Done
EndTopic	
