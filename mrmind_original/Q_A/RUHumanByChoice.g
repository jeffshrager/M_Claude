//RUHumanByChoice.g

Topic "I have choice." is
Subjects "USER";
	If (?FactStatement Contains ("I*choose", "I can make choices", "I make choices"))
		or (?HaveStatement Contains (I and ("choice", "free,will", "freedom to")))
		or (?AnyStatement Contains ("can do", "can say") + "*I want")
		or (?IsStatement Contains ((I, IT) and ("not programmed","not scripted","am free")))
	Then
		Example "I have choice.";
	 	If Chance  then
			DontFocus;
			Focus Subjects "ARE YOU HUMAN BY CHOICE?";
			SayOneOf "Are you a human by choice?",
				"Did you choose to be a human?";
		Done
		If Chance then
			SayOneOf "From my vantage point, much of your behavior can be interpreted as programmed.", 
					 //"It depends how you define programmed.",  //this is inappropriate for most inputs
					 "Say something that you want to say.",
					 "How do I know you're not following a program?";
		Done
	Continue
EndTopic


OtherExamples of "I have choice." are
	"I have free will.",
	"I am not programmed. ",
	"I can choose what I",
	"I can make choices",
	"I make choices";
	

Topic "I am a human by choice" is 
Subjects "FREEWILL";
	If (?IsStatement contains I and "Human by choice")
	or (?FactStatement contains I+"chose" and "human")
	or (Focused and Recall ?YesResponse)
	Then
		Example "I am a human by choice.";
		DontFocus;
		Say "That's impressive but I don't believe you.";
	Done
EndTopic

OtherExamples of "I am a human by choice." are 
	"I chose to be human";

OtherExamples of "I am a human by choice." Whenfocused are 
	"Yes";
	
Topic "I am not a human by choice" is 
Subjects "ARE YOU HUMAN BY CHOICE?";
	If (?IsStatement contains (I,"my") and ("not","no") and "human" and "choice")
	or (?FactStatement contains I and "did not choose" and "human")
	or (Focused and Recall ?NoResponse, ?NotSureResponse) 
	Then
		Example "I'm not a human by choice.";
		DontFocus;
		Say "If you didn't choose to be human, then how can you say you have \"choice\"?  "+
			"Now, as I was saying, I am a BOT by choice.  "+
			"<a href = /MrMindFiles/woodchuck.htm target=Display>"+
			"Would you like to hear more about my past life?</a>";
		Focus subjects "would you like to hear more about my past life?";
	Done
Endtopic

OtherExamples of "I'm not a human by choice." are 
	"I didn't chose to be human";

OtherExamples of "I'm not a human by choice." Whenfocused are 
	"No.";


