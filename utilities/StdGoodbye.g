////////////////////////////////////////////////////////////////
//StdGoodbye.g 
//(Based on StdGreeting.g for Shallow Red)
//
// A Gerbil(tm) Standard Robot Module
// For use only with the Voodoo(tm) Robot Server and
// Authoring System
//
// Author: Ray, Scott, James, Wordz, Neuromedia, Inc.
// ALL RIGHTS RESERVED (c) 1996-1997 Neuromedia, Inc.  
// Proprietary and Confidential Property of Neuromedia, Inc.
// No part of this publication may be reproduced, stored in 
// a retrieval system, or transmitted in any form or by any 
// means, electronic, mechanical, photocopying, recording 
// or otherwise without the prior written permission of the 
// publisher and the author(s).
////////////////////////////////////////////////////////////////


//SEE StdGreeting Notes





PatternList STD_GoodbyePhrases is

//THESE ARE THE PHRASES THE BOT WILL SAY. PLEASE MODIFY TO SUIT THE CHARACTER OF YOUR BOT

"Bye, please come back again soon.",
"Bye, hope to see you again.",
"Bye, come back soon -- if you want to be notified of updates to MRMIND, please send email to MRMIND@weblab.org.";

// Like StdGreeting, this is a pretty mundane list to come up with yourself
// every time you write a robot, so we provide some inane
// defaults.  To use the following pattern you 


//these are strict patterns
PatternList STD_Goodbye_Match is
	 
	"See you","Later", "Hasta","Nice talking","Nice chatting","Nice talking to you",
	"Nice meeting you", "so long", "signing off";


//these are more complex patterns
PatternList STD_Goodbye_Contains is
	"good bye #","goodbye #","good,night","good,night #", "logout", "I'm leaving",
	"gotta run","*nice*talk#*you","bye bye","Seeya later", "See ya later","see you",
	"See you later","Hasta la vista","Catch you later", "Goodbye","Goodby",
	"Good bye","Good by","Good-by","Bye now","Bye","Seeya", "See ya", "Catch ya later",
	"Thanks for everything","was nice talking","was nice chatting", "I must go", 
	"was nice meeting you","sign off","exit","adios","ciao", "fare,well","fare # well",
	("was","been")+"*pleasure "+("talk#","#ing")+"*you","gotta go","seeyalater",
	"see ya","was*very*#ing with","was*very*#ing you","have to be going",
	"got to be going","I've got to go","I have to go","I am going now",
	"I'm going to go","I'm signing off","it's time to go","time for me to go",
	"hasta la","I'm going away now","I am going away now","tootaloo"; 


Priority Topic "STD_Goodbye Detect" is 
	If ?WhatUserMeant Matches STD_Goodbye_Match 
		or (Heard STD_Goodbye_Contains and DontRecall ?Anyquestion) 
	Then
		If DontRecall ?NoSurvey then SwitchTo "asksurvey"; Continue
		SayOneOf STD_GoodbyePhrases;
	Done
EndTopic


Sequence topic "AskSurvey" is 
	Always 
	Say "Before you leave, can you take a moment to take the user survey?";
		WaitForResponse;
		IfRecall ?YesResponse then 
			SwitchTo "Exit Survey";
		Done

		IfRecall ?NoResponse then 
			Remember ?NoSurvey;
		SwitchBack
	Continue
Endtopic


