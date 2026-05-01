////////////////////////////////////////////////////////////////
// Greeting. Red.g
//
// Authors:  Walter Alden Tackett, Ray Dillinger, Neuromedia Inc.
// A Gerbil(tm) Standard Robot Module
// For use only with the NeuroStudio (tm) Robot Server and
// Authoring System
//
/////////////////////////////////////////////////////////////

// ALL RIGHTS RESERVED (c) 1996-1998 Neuromedia, Inc.  
// Proprietary and Confidential Property of Neuromedia, Inc.
// No part of this publication may be reproduced, stored in 
// a retrieval system, or transmitted in any form or by any 
// means, electronic, mechanical, photocopying, recording 
// or otherwise without the prior written permission of the 
// publisher and the author(s).
////////////////////////////////////////////////////////////////

//Misc. Control functions

Priority Topic "Dump Robot Name" is 
	If ?WhatUserSaid Matches "xname" 
	Then
		Say "I think my name is " + ?RobotName;
	Done
EndTopic


Priority Topic "Empty Template Cache" is 
	If ?WhatUserSaid Matches "clrt" 
	Then
		DO "EmptyTemplateCache";
		Say "Template cache has been flushed.";
	Done
EndTopic

Priority Topic "enable html" is 
	If ?WhatUserSaid matches "enable html" 
	Then 
		SwitchTo "enable html codes";
		Say "HTML codes have been enabled.";
	Done
EndTopic

Priority Topic "disable html" is 
	If ?WhatUserSaid matches "disable html" 
	Then 
		SwitchTo "disable html codes";
		Say "HTML codes have been disabled.";
	Done
EndTopic

Priority Topic "enable pronunciation tags" is 
	If ?WhatUserSaid matches "enable pronunciation" 
	Then 
		SwitchTo "enable pronunciation";
		Say "Pronunciation tags have been enabled.";
	Done
EndTopic

Priority Topic "disable pronunciation tags" is 
	If ?WhatUserSaid matches "disable Pronunciation" 
	Then 
		SwitchTo "disable pronunciation";
		Say "Pronunciation tags have been disabled.";
	Done
EndTopic



PatternList MSAGENTPATTERNS is "use msagent #", "microsoft agent #", "ms agent #", "msagent #","get a body";


Priority topic "MSAgent is disabled" is 
	If ?WhatUserSaid Contains MSAGENTPATTERNS Then
		Say "Sorry, but the MSAgent features are not enabled on this server.  ";
	Done
Endtopic


//Priority Topic "Use Microsoft Agent" is
//	If ?WhatUserSaid Contains MSAGENTPATTERNS Then 
//		Remember ?MSAgentCharacter is "Robby";
//		If (#1 Matches "genie") OR (#1 Matches "robby") OR (#1 Matches "merlin") Then
//			Remember ?MSAgentCharacter is #1;
//		Continue

//		If (#1 Matches "interview") Then 
//			Remember ?MSAgentCharacter is "Robby";
//			Remember ?MSAgentInterviewer is "Genie";
//			Remember ?SayPageTemplate is "HTML/ShallowRedSayMSAgentInterview.htm";
	
//			Remember ?WaitingForMSAgentLine is "OK, "+?Name+", please wait a minute while I change into my "+?MSAgentCharacter+" costume!";
//			Do "SHOWTEMPLATE SRC=HTML/ShallowRedSayWaitForMSAgent.htm TARGET=Conversation";
//			Do "SHOWTEMPLATE SRC=HTML/LoadingMSAgentAnnounce.htm TARGET=Display";
//			Do "SHOWTEMPLATE SRC=HTML/BotControlInterview.htm TARGET=Logo";

//		Done
		
//		Remember ?SayPageTemplate is "HTML/ShallowRedSayMSAgent.htm";

//		Remember ?WaitingForMSAgentLine is "OK, "+?Name+", please wait a minute while I change into my "+?MSAgentCharacter+" costume!";
//		Do "SHOWTEMPLATE SRC=HTML/ShallowRedSayWaitForMSAgent.htm TARGET=Conversation";
//		Do "SHOWTEMPLATE SRC=HTML/LoadingMSAgentAnnounce.htm TARGET=Display";
//		Do "SHOWTEMPLATE SRC=HTML/BotControl.htm TARGET=Logo";

//	Done
//EndTopic

//Priority Scenario "Launch Microsoft Agent" is
//	If ?WhatUserDid Matches "LaunchMSAgent" Then
//		SwitchTo "disable html codes";
//		SwitchTo "Enable pronunciation";
//		Say "Greetings.  As you can see.  Bots created with NeuroStudio can easily use animated characters for their interface.";
//	Done
//EndScenario

priority topic "Choose Next Refresh" is
	Always
		Remember ?MrMindRefreshFile is "mind1a1.htm";
	Continue
endtopic

//THESE TOPICS GREET THE USER AND SWITCHTO NAMECAPTURE

Priority Scenario "Login over Web" is      
 	If ?WhatUserDid Contains "Web ACCEPT CONNECTION" Then
		IfRecall ?HostName Then
			SayToConsole "User logged in from " + ?HostName + ", IP address " + ?IPAddress;
		Continue
		Otherwise Always
			SayToConsole "User logged in from IP address " + ?IPAddress + " (no hostname found)";
		Continue
 
		Remember ?SayPageTemplate is "HTML/MrMindSay.htm";
		SwitchTo "enable html codes"; 
		SwitchTo "disable pronunciation";

		
        SayToConsole "HTTP_FROM = " + ?HTTP_FROM;
        SayToConsole "HTTP_HOST = " + ?HTTP_HOST;
		SayToConsole "HTTP_REFERRER = " + ?HTTP_REFERRER;
		SayToConsole "HTTP_REFERER = " + ?HTTP_REFERER;
		SayToConsole "REMOTE_HOST = " + ?REMOTE_HOST;
		SayToConsole "REMOTE_ADDR = " + ?REMOTE_ADDR;
 		SayToConsole "SCRIPT_NAME = " + ?SCRIPT_NAME;
 		SayToConsole "SERVER_NAME = " + ?SERVER_NAME;
 		SayToConsole "DOCUMENT_ROOT = " + ?DOCUMENT_ROOT;
		Suppress "Login from Console";	
		SwitchTo "Robot Greeting";
	Done
EndScenario

Priority Scenario "ReConnect" is
	If ?WhatUserDid Contains "Web RECONNECT" Then
		IfRecall ?Name Then
			SayOneOf "Don't you Trust me?";
			Focus subjects "Don't you trust me?";
		Done
		SayOneOf "I'd still like to get your name.", "So, what was your name?", 
			"What do you want me to call you?";
	Done
EndScenario

Priority Topic "Login from Console" is
	Always
		Suppress This;
		SwitchTo "Enable HTML codes";
		SwitchTo "Disable Pronunciation";
		SwitchTo "Robot Greeting";
	Done
EndTopic




Sequence Topic "Robot Greeting" is
	Always
	//InitialExample 1 "Hi";
	 InitialExample 1 "Debugging Info ON";
	        // use the second instead of the first if you want the log file to 
			// include question types.		
		Remember ?RobotName is "MR MIND";
//	  	Do "SETNAME MR MIND";
        Say ?Boldcode + "Hello. I'm MR MIND. "+?EndBold +;

		Focus Subjects "ME";
		Forget ?HaveName;	
		SwitchTo "Name Capture";
	Done
EndTopic

Sequence topic "enable html codes" is 
	Always 
	Remember ?Breakcode is "<BR>";
	Remember ?Boldcode is "<B>";
	Remember ?EndBold is "</B>";
	Remember ?ItalicCode is "<i>";
	Remember ?EndItalic is "</i>";
	Remember ?Trademark is "<sup>TM</sup>";
	Remember ?Preformatted is "<PRE>";
	Remember ?EndPreFormat is "</PRE>";
	Remember ?H1Code is "<H1>";
	Remember ?EndH1 is "</H1>";
	Remember ?FontSize7 is "<font size=7>";
	Remember ?FontSize6 is "<font size=6>";
	Remember ?FontSize5 is "<font size=5>";
	Remember ?FontSize4 is "<font size=4>";
	Remember ?FontSize3 is "<font size=3>";
	Remember ?FontSize2 is "<font size=2>";
	Remember ?FontSize1 is "<font size=1>";
	Remember ?EndFont is "</font>";
//	Remember ?MailtoSalesAnchor is "<a href=\"mailto:sales@neurostudios.com\">";
//	Remember ?MailtoSPAAnchor is "<a href=\"mailto:piracy@spa.org\">";
//	Remember ?MailtoInvestAnchor is "<a href=\"mailto:invest@neurostudios.com\">";
//	Remember ?MailtoSupportAnchor is "<a href=\"mailto:support@neurostudios.com\">";
//	Remember ?MailtoWebFeedAnchor is "<a href=\"mailto:webfeed@neurostudios.com\">";
//	Remember ?MailtoWalterAnchor is "<a href=\"mailto:walter@neurostudios.com\">";
//	Remember ?MailtoJobsAnchor is "<a href=\"mailto:jobs@neurostudios.com\">";
//	Remember ?MailtoScottAnchor is "<a href=\"mailto:scott@neurostudios.com\">";
//	Remember ?MailtoJPAnchor is "<a href=\"mailto:jp@neurostudios.com\">";
//	Remember ?MailtoRayAnchor is "<a href=\"mailto:ray@neurostudios.com\">";
	Remember ?EndAnchor is "</a>";
	SwitchBack
EndTopic

Sequence topic "disable html codes" is 
	Always 
	Remember ?BreakCode is "";
	Remember ?Boldcode is "";
	Remember ?EndBold is "";
	Remember ?ItalicCode is "";
	Remember ?EndItalic is "";
	Remember ?Trademark is "";
	Remember ?Preformatted is "";
	Remember ?EndPreFormat is "";
	Remember ?H1Code is "";
	Remember ?EndH1 is "";
	Remember ?FontSize7 is "";
	Remember ?FontSize6 is "";
	Remember ?FontSize5 is "";
	Remember ?FontSize4 is "";
	Remember ?FontSize3 is "";
	Remember ?FontSize2 is "";
	Remember ?FontSize1 is "";
	Remember ?EndFont is "";
//	Remember ?MailtoSalesAnchor is "";
//	Remember ?MailtoInvestAnchor is "";
//	Remember ?MailToSupportAnchor is "";
///	Remember ?MailtoShallowRedAnchor is "";
//	Remember ?MailtoWebFeedAnchor is "";
//	Remember ?MailtoWalterAnchor is "";
//	Remember ?MailtoJobsAnchor is "";
//	Remember ?MailtoRayAnchor is "";
//	Remember ?MailtoScottAnchor is "";
//	Remember ?MailtoJPAnchor is "";
	Remember ?EndAnchor is "";
	SwitchBack
EndTopic


Sequence topic "enable pronunciation" is 
	Always
//	Remember ?Pronounce.Dillinger is "\\Map=\"dillenjer\"=\"Dillinger\"\\";
	Remember ?Pronounce.Content is "\\Map=\"con-tent\"=\"content\"\\";
	Remember ?Pronounce.hmm is "\\Map=\"hummm\"=\"Hmm\"\\";
	Remember ?Pronounce.dotcom is "\\Map=\" dot com\"=\".com\"\\";
	Remember ?Pronounce.dot is "\\Map=\" dot \"=\".\"\\";
//	Remember ?Pronounce.usc is "\\Map=\"you ess see\"=\"USC\"\\";
	SwitchBack
EndTopic

Sequence topic "Disable pronunciation" is 
	Always
//	Remember ?Pronounce.Dillinger is "Dillinger";
	Remember ?Pronounce.Content is "content";
	Remember ?Pronounce.hmm is "Hmm";
	Remember ?Pronounce.dotcom is ".com";
	Remember ?Pronounce.dot is ".";
//	Remember ?Pronounce.USC is "USC";
	SwitchBack
EndTopic


Priority topic "find initial gif" is 
	Always 
	Suppress this;
	SwitchTo "Show gif";
	Continue
EndTopic


Sequence topic "show gif" is 
	If recall ?UserHasClaimedEmotion then 
		Remember ?HumanIconSelection is "Y.GIF";
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "N.GIF";
	Continue
	
	If Recall ?UserHasClaimedIntelligence then 
		Remember ?HumanIconSelection is "Y"+?HumanIconSelection;
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "N"+?HumanIconSelection;
	Continue

	If Recall ?UserHasClaimedVirtue then 
		Remember ?HumanIconSelection is "Y"+?HumanIconSelection;
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "N"+?HumanIconSelection;
	Continue

	If Recall ?UserHasClaimedCreativity then 
		Remember ?HumanIconSelection is "Y"+?HumanIconSelection;
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "N"+?HumanIconSelection;
	Continue

	If Recall ?UserHasClaimedHumor then 
		Remember ?HumanIconSelection is "Y"+?HumanIconSelection;
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "N"+?HumanIconSelection;
	Continue

	If Recall ?UserHasClaimedSex then 
		Remember ?HumanIconSelection is "Y"+?HumanIconSelection;
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "N"+?HumanIconSelection;
	Continue

	If Recall ?UserHasClaimedPets then 
		Remember ?HumanIconSelection is "HUMANICO/Y"+?HumanIconSelection;
	Continue
	Otherwise always 
		Remember ?HumanIconSelection is "HUMANICO/N"+?HumanIconSelection;
	Continue
	Always
		Do "SHOW SRC=/MrMindFiles/"+?HumanIconSelection+" TARGET=HumanGif";
	SwitchBack
EndTopic



