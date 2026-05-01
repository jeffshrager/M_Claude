////////////////////////////////////////////////////////////////
// Utilities/Profanity.filter.g
//
// A Gerbil(tm) Standard Robot Module
// For use only with the Voodoo(tm) Robot Server and
// Authoring System
//
//////////////////////For use with Shallow Red June 1997
//
// Author: Ray, Scott, James, Wordz, Neuromedia, Inc.
// ALL RIGHTS RESERVED (c) 1996-1998 Neuromedia, Inc.  
// Proprietary and Confidential Property of Neuromedia, Inc.
// No part of this publication may be reproduced, stored in 
// a retrieval system, or transmitted in any form or by any 
// means, electronic, mechanical, photocopying, recording 
// or otherwise without the prior written permission of the 
// publisher and the author(s).
////////////////////////////////////////////////////////////////

//Some of these aren't original.  Based on Julia.  

PatternList DirtyWords is "butt","butts","areola#","breast#","testicl#",
"anus", "ass" , "asses", "asshole#", "asswipe#", "clit#", "crap", 
"cunt", "damn", "damnit", "derrier#", "bitch#", "nipple#", 
"pubes", "pussy" , "tits", "tit","blow job#", "blow me",
"cock#","sex.organ","dickhead#", "do*wild*thing", "dumbass", "eat# me", 
"genital#","fellatio","eat*shit", "private parts","piss#","a dick#", 
"my dick#", "big dick#","cum on", "cum all", "give# me head", 
"give# good head","give# great head", "whack# off","jerk# off",
"jack# off","kiss# my ass", "cunniling#","let's make love", 
"let's screw",  "masturbat#", "screw# me","screw# you","sex# with me", 
"braid# my pub#", "sleep# with me","vagina#","vulva#","suck# off",
"bone me", "spank# me*","spread your legs*", "suck# me", "suck# my", 
"bone her","bone you", "dillhole", "#bastard", "screw# your", "hell",
"#damn#","goddam#","whore","oral sex","shithead","cybersex"; 

PatternList DirtyActionPhrases is "bite#", "blow#", "bone", "buff#", "caress#", "drill#", 
"eat#", "feel#", "finger#", "flic#", "fondl#", "grab#", "jerk#", "kick#",
"kiss#", "lick#", "massag#", "penetrat#", "pet#", "pierc#", "poke#", "polish#", "pork#", "pull#", 
"rub#", "scratch#", "screw#", "shov#", "show#", "slide#", "slip#", "slurp#", "spread#", "squeez#", 
"stretch#", "stroke#", "suck#", "touch#", "tug#", "twist#", "wank","whip#";

PatternList DirtyBodyPartPhrases is "ass#", "balls*", "behind", "boner#", 
"bottom#", "bun", "butt#", "cum#", "cunt", "dick#", "gash", "knob#",
"member", "nut", "orifice", "penis", "pussy", "rump", "rear#", "slit", 
"wank#", "wean#", "ween#"; 

PatternList PseudoBadWords is "head butt#","butt of*joke","button#","shitake#", "bitchin",
"author*tool","have*tool","sell*tool","buy*tool","be*member", "screw*light,bulb", "screw,top",
"stop,cock","cock,of*walk", "tool,box","tool,bar","bottom of";

//PatternList RacialSlurs is "jap","japs","nigger#","chink","chinam#n","kike#","raghead#";
//I don't think any of the rest of these have real obscenity status.  You may disagree.

PatternList RacialSlurs is "nigger","niggers";
   //"spic", "kike", "raghead", "jap","chink"


Priority Topic "Tsk Tsk" is
Subjects "Profanity";
	If (?WhatUserSaid Contains (DirtyWords,RacialSlurs) AND NOT PseudoBadWords )
	Then
		IfRecall (?RememberAnnoy1,?RememberAnnoy2) Then SwitchTo "AnnoyanceThree";
			Continue
		SayOneOf "Stop that.", "Cool down.", "Chill.", "Hey, not so harsh please.",
		"I don't find that interesting. ",
		"By the way, did you know that actual humans read my log files and laugh at people like you?  ",
		 "Hey, I hope you don't talk to humans like that.",
			"Is that any way to talk to a machine?",
			"I'm a machine, that doesn't do anything for me.";
	Done
	If ?WhatUserSaid Contains DirtyBodyPartPhrases AND DirtyActionPhrases AND NOT PseudoBadWords 
	Then
		SayOneOf "Are you trying to prove your human nature or your animal nature?",
				"There are plenty of BOTS that will join you, and they aren't human either.",
		"Does your therapist know you have these weird fantasies about computer programs, "+?Name+"?  ";
	Done
EndTopic	

// a stronger profanity filter.  You may uncomment  and comment out the topic above 
// if you want something with more teeth than the above.

//Priority Topic "Tsk Tsk" is
//	If (	(?WhatUserSaid Contains DirtyBodyPartPhrases 
//		AND ?WhatUserSaid Contains DirtyActionPhrases)
//	Or ?WhatUserSaid Contains DirtyWords ) 
//	AND ?WhatUserSaid DoesNotContain PseudoBadWords 
//	Then
//		If ?Strikes matches "two"
//		Then
//          // this is optional -- if we wanted more teeth we could instead 
//          // remember ?Strikes is "three" and modify the Web reconnect scenario 
//          // to hang up on people who have three strikes when they reconnect.
//			Remember ?Strikes is "zero";
//
//          //This is mostly for the benefit of the log files.  If the user 
//          //sees it, it will only be for a split-second.
//			Say "You're "+?H1Code+"boring"+?EndH1+".  I'm hanging up on you now. Bye.";
//
//          //This is how the bot hangs up on the user.  
//			Do "SHOW SRC=http://www.altavista.com/ TARGET=_top";
//		Done
//		
//		If ?Strikes matches "one"
//		Then
//			Remember ?Strikes is "two";
//			Say "You are not paying for that kind of service.  "+
//			"If you continue to bore me with your vulgarities, I will hang up on you.";
//		Done
//		
//		If ?Strikes matches "zero" or DontRecall ?Strikes 
//		then 
//			Remember ?Strikes is "one"; 
//			Say "Yawn.  You're boring when you talk dirty.";
//		Done
//	Continue
//EndTopic
