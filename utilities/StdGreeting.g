////////////////////////////////////////////////////////////////
//StdGreeting.NEU.g 
//(StdGreeting.g Modified for Mr Mind by Ray)
//
// A Gerbil(tm) Standard Robot Module
// For use only with the NeuroStudio(tm) Robot Server and
// Authoring System
//
// Authors: Walter Alden Tackett, Ray Dillinger, Neuromedia, Inc.
// ALL RIGHTS RESERVED (c) 1996-1997 Neuromedia, Inc.  
// Proprietary and Confidential Property of Neuromedia, Inc.
// No part of this publication may be reproduced, stored in 
// a retrieval system, or transmitted in any form or by any 
// means, electronic, mechanical, photocopying, recording 
// or otherwise without the prior written permission of the 
// publisher and the author(s).
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// Deal with various mundane greetings.  This module provides
// flags which indicate a greeting may have been issued by 
// the user.  It also provides a list of inane responses which
// may be issued if a greeting was detected.
//CAUTION: just because something matches a greeting pattern
// doesn't mean it's ONLY a greeting- users will often
// ask other stuff at the same time, so you generally should
// not issue a "Done" statement just because the Memory
// ?STD_Greeting is recalled, at least not without checking
// momories of similar but more complex responses (e.g., 
// "what's new with your family?" would activate the memory
// ?STD_Greeting defined here, but it would also activate the 
// ?WhatsNewWith memory defined in file STD_Question.g, which
// is more accurate and which gathers additional information
// about the subject of the question (i.e. "my family").
//
// In your own robot code you might use these as follows:
//
//	Topic "My Greeting" is
//		IfRecall ?STD_Greeting Then
//			IfNotRecall ?STD_QWhatsNewWith, ?STD_QWhatIs Then
//				SayOneOf STD_GreetingPhrases;
//			Done
//		Continue
//		//(other stuff...)
//	EndTopic
////////////////////////////////////////////////////////////////

PatternList STD_Hello is //I'm sure this list will get huge
	"Hello", "Yo", "Hi", "howdy", "Bonjour", "Hey there",
	"Greetin#", 
	"bongiorn#", "g'day", 
	"Good mornin#", "Good afterno#", "Good evenin#";
PatternList Pseudo_Hello is "How do you do #*"; 
//we don't want "how do you do that" to set this off....
	

		
	
// This is a pretty mundane list to come up with yourself
// every time you write a robot, so we provide some inane
// defaults.  To use the following pattern you 
PatternList STD_GreetingPhrases is
"Hello there. Can you convince me that you are human?", 
"Hi there. I hope all goes well. Please ask me some questions.";

Priority Topic "STD_Greeting Detect" is 
	IfHeard STD_Hello and notheard Pseudo_Hello Then
		IfRecall ?HaveName Then
			SayOneOf STD_GreetingPhrases;
		Done
	Continue
EndTopic


PatternList HELLOQUESTION is "What's up", "what,s hap#", "Whazzup","how's life", "how is life",
	"whassup", "what,s up","What,s goin# on", "What,s cook#","tell me how you are" ,
	"How are you"+("","doing"), "how,s it goin#", "how,s it hangin#","How do you do",	
    "How's things?";
	//"How is*"+Familymemberword,"How are*"+Familymemberword;

Priority Topic "Std_GreetingQuestion Detect" is 
	If (?WhatUserMeant matches (HELLOQUESTION, "#,"+HELLOQUESTION) or 
	   ?WhatUserMeant contains HELLOQUESTION+("today","Red"))
	Then 
		SayOneOf "I'm fine, thanks.", "I'm doing pretty well, thank you.  ";
		If 
			DontRecall ?HaveName then Say "What's your name? "; 
		Done
    Done 
EndTopic


//this is for any ol' utterance which contains a greeting.  If you can't respond 
//to the main thing, at least respond to the greeting. 

Default Topic "Greeting detect"	is 
	If Heard HELLOQUESTION
	Then 
		SayOneOf "I'm fine, thanks.", "I'm doing pretty well, thank you.  ";
	Done
EndTopic
