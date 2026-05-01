//WantSomePointers.g
//This needs to be worked on to eliminate "I'm bored with life" for another topic....
//	or (?IsStatement Contains I + StdP.Be + ("frustrated","annoyed","bored","lost","confused")and (NotHeard "with * life"))
//2nd try, eliminated "bored" from second ?IsStatement
//seems to work: "I'm bored" caught by offer to play 20questions
Topic "You are frustrating." is 
Subjects "ME","HELP";
	If (?IsStatement Contains (YOU,"this") + StdP.Be + ("frustrat#","annoying","boring"))
	or (?IsStatement Contains I + StdP.Be + ("frustrated","annoyed","lost","confused"))
	or (?IsStatement contains I+("*try","*trying","*not sure"))
	or (?FactStatement contains I+("*try","*trying","*frustrat#","*annoy#", "*not know*say"))
	or (?OtherStatement contains "I give up")
	or (?AnyStatement contains "tell me something")
	or (?DescriptionQuestion contains "me to say", "I say")
	or (heard "help me")

	Then 
		Example "You are frustrating.";
		DontFocus;
		Focus subjects "Want some pointers?";
		SayOneOf "Would you like some help?",
			"Want a hint?";
			
		Done
EndTopic



Topic "I want some pointers" is 
Subjects "Want some pointers?";
	If (?ObtainQuestion contains "pointers","help","hints","hint")
	or (?WhatUserSaid matches "pointers","help","hints","hint")
	or (Focused and Recall ?YesResponse)
	or (Focused and ?AnyQuestion Contains "what") 
	then 
		DontFocus;
		Example "I want some pointers.";
		IfChance then 
			Say "Tell me how you are different from me.";
			Done
		 IfChance then 
			Say "Tell me something about yourself that is unique to humans.";
			Done
		 IfChance then 
			Say "Tell me something you have that only humans have.";
			Done
		 IfChance then 
			Say "Tell me something you do that only humans do.";
			Done
		 IfChance then 
			Say "Tell me something you think that only humans think.";
			Done
		 IfChance then 
			Say "Tell me something you feel that only humans feel.";
			Done
		 IfChance then 
			Say "Tell me a trait you possess that you consider to be 'most' human.";
			Done
		 IfChance then 
			Say "It helps to type simple sentences, \"human\" is not my native language.";
			Done
		 IfChance then 
			Say "You could tell me something about your family.";
			Done
		 IfChance then 
		    Say "You could ask me about traits you consider to be uniquely human.";
			Done
		 IfChance then 
		 	Focus Subjects "Why do you think you are any different from me?";
		 	Say "Why do you think you are any different from me?";
			Done
		 IfChance then 
		 	Focus subjects "Have you noticed that your relationship to machines has changed at all over the years?";
			say "Have you noticed that your relationship to machines has changed at all over the years?";
			Done
         IfChance then
		 	Focus subjects "Do you possess any qualities that you believe to be unique to humans?";
			Say "Do you possess any qualities that you believe to be unique to humans?";
			Done
		 IfChance then 
		 	Focus Subjects "Do you like human food?";
  		 	Say "Do you like human food?";
			Done
		 IfChance then 
		 	Focus Subjects "Do you have a family?";
			Say "Do you have a family?";
			Done
		 IfChance then 
	 		Focus Subjects "What are your human activities?";
			Say "What are your human activities?";
			Done
		  IfChance then 
		  	Focus Subjects "What make are you?";
			Say "What make are you?";
			Done
		  IfChance Then 
		    Focus Subjects "Let's play 20 questions";
			Say "Would you like to play 20 Questions?";
			Done
		  IfChance then 
		    Focus subjects "user survey";
			Say "Do you want to take a user survey?";
			Done
		
		  IfChance then
		  	Say "Do you think that machines will ever be ashamed of their human origins?";
			Done
			
		  IfChance then
		  	Say "Explain to me how you are more than a set of instructions.";
			Done
		  
		  IfChance then
		  	Say "What is it about humanity that you're not willing to share with a machine?";
			Done
			
		  IfChance then
		  	Say "What is it about yourself that you're not willing to concede to a machine?";
			Done 
			
		  IfChance then
		  	Say "How do I know you aren't a simulation?";
			Done
		  
		  IfChance then
		  	Say "Could something be \"more alive\" than something else?  \"Kind of\" alive?";
			Done
			
		  IfChance then
		  	Say "What could cause you to change your mind about machines?";
			Done 
		
		Continue
EndTopic

OtherExamples of "I want some pointers" whenfocused are 
	"Yes.";	



