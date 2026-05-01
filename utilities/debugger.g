////////////////////////////////////////////////////////////////
//Debugger.us.g
//
// A Gerbil(tm) Standard Robot Module
// For use only with the NeuroStudio(tm) Robot Server and
// Authoring System
//
//////////////////////
//
// Author: Ray, Neuromedia, Inc.
// ALL RIGHTS RESERVED (c) 1998 Neuromedia, Inc.  
// Proprietary and Confidential Property of Neuromedia, Inc.
// No part of this publication may be reproduced, stored in 
// a retrieval system, or transmitted in any form or by any 
// means, electronic, mechanical, photocopying, recording 
// or otherwise without the prior written permission of the 
// publisher and the author(s).
////////////////////////////////////////////////////////////////




Priority topic "Debugging by default" is 
	If Recall ?UserIsConsole then 
		Remember ?Debugging is "QSR";  //show question and statement types.
		Suppress this;
	Continue
	Otherwise Always
		Remember ?Debugging is "";	//no debugging info for webusers.
		Suppress This;
	Continue
EndTopic


Priority topic "debugging info ON" is 
	If ?WhatUserSaid matches "debugging info ON" 
	Then
		Remember ?Debugging is "PQNSR"; //turns on all console info
	Continue
EndTopic

Priority topic "debugging info OFF" is 
	If ?WhatUserSaid matches "debugging info OFF" 
	Then
		Remember ?Debugging is "";
	Continue
EndTopic


Priority topic "Toggle PreProcessor Debugging" is 
	If ?WhatUserSaid matches "Toggle Preprocessor debugging" 
	Then
		If ?Debugging matches  "#P#" then 
			Remember ?Debugging is #1+#2; 
			SayToConsole "Turning PreProcessor Debugging OFF";
		Continue
		Otherwise Always 
			Remember ?Debugging is ?Debugging+"P";
			SayToConsole "Turning PreProcessor Debugging ON";
		Continue
	Continue
EndTopic


Priority topic "Toggle Question Debugging" is 
	If ?WhatUserSaid matches "Toggle Question debugging" 
	Then
		If ?Debugging matches  "#Q#" then 
			Remember ?Debugging is #1+#2; 
			SayToConsole "Turning Question Debugging OFF";
		Continue
		Otherwise Always 
			Remember ?Debugging is ?Debugging+"Q";
			SayToConsole "Turning Question Debugging ON";
		Continue
	Continue
EndTopic



Priority topic "Toggle Statement Debugging" is 
	If ?WhatUserSaid matches "Toggle Statement debugging" 
	Then
		If ?Debugging matches "#S#" then 
			Remember ?Debugging is #1+#2; 
			SayToConsole "Turning Statement Debugging OFF";
		Continue
		Otherwise Always 
			Remember ?Debugging is ?Debugging+"S";
			SayToConsole "Turning Statement Debugging ON";
		Continue
	Continue
EndTopic



Priority topic "Toggle Response Debugging" is 
	If ?WhatUserSaid matches "Toggle Response debugging" 
	Then
		If ?Debugging matches  "#R#" then 
			Remember ?Debugging is #1+#2; 
			SayToConsole "Turning Response Debugging OFF";
		Continue
		Otherwise Always 
			Remember ?Debugging is ?Debugging+"R";
			SayToConsole "Turning Response Debugging ON";
		Continue
	Continue
EndTopic



//Priority topic "debugging debugging" is 
//	Always 
//		SayToConsole "Debugging is "+?Debugging;
//	Continue
//EndTopic


Priority topic "Report PreProcessor debugging to console" is 
	If ?Debugging Matches "#P#" then 
		SayToConsole "WhatUserSaid:  "+?WhatUserSaid;
		SayToConsole "WhatUserMeant:  "+?WhatUserMeant;
		SayToConsole "ProcessedString: "+?ProcessedString;
	Continue
EndTopic
	



Priority topic "debugging stdquestion information" is 
	If ?Debugging Matches "#Q#" 
   	then
		IfRecall ?AnyQuestion then SaytoConsole         "AnyQuestion:         "+?AnyQuestion; Continue
		IfRecall ?OtherQuestion then SaytoConsole       "OtherQuestion:       "+?OtherQuestion; Continue
		
		IfRecall ?CanQuestion then SayToConsole         "CanQuestion:         "+?CanQuestion; Continue
		IfRecall ?DescriptionQuestion then SayToConsole "DescriptionQuestion: "+?DescriptionQuestion; Continue
		IfRecall ?FactQuestion then SayToConsole        "FactQuestion:        "+?FactQuestion; Continue
		IfRecall ?LocationQuestion then SayToConsole    "LocationQuestion:    "+?LocationQuestion; Continue
		IfRecall ?MethodQuestion then SayToConsole      "MethodQuestion:      "+?MethodQuestion; Continue
		IfRecall ?ReasonQuestion then SayToConsole      "ReasonQuestion:      "+?ReasonQuestion; Continue
		IfRecall ?ShouldQuestion then SayToConsole      "ShouldQuestion:      "+?ShouldQuestion; Continue
		IfRecall ?TimeQuestion then SayToConsole        "TimeQuestion:        "+?TimeQuestion; Continue
		IfRecall ?WhatIfQuestion then SayToConsole      "WhatIfQuestion:      "+?WhatIfQuestion; Continue
		IfRecall ?WhoQuestion then SayToConsole         "WhoQuestion:         "+?WhoQuestion; Continue

	  	IfRecall ?CostQuestion then SayToConsole       "CostQuestion:         "+?CostQuestion; Continue
		IfRecall ?DirectionsQuestion then SayToConsole "DirectionsQuestion:   "+?DirectionsQuestion; Continue
		IfRecall ?ObtainQuestion then SayToConsole     "ObtainQuestion:       "+?ObtainQuestion; Continue
		IfRecall ?CompareQuestion then SayToConsole    "CompareQuestion:      "+?CompareQuestion; Continue
		IfRecall ?ExampleQuestion then SayToConsole    "ExampleQuestion:      "+?ExampleQuestion; Continue
		IfRecall ?DoHaveQuestion then SayToConsole     "DoHaveQuestion:       "+?DoHaveQuestion; Continue
		IfRecall ?ConfirmQuestion then SayToConsole    "ConfirmQuestion:      "+?ConfirmQuestion; Continue
		IfRecall ?MoreQuestion then SayToConsole       "MoreQuestion:         "+?MoreQuestion; Continue
		
	Continue
EndTopic	



Priority Topic "debugging Response information" is 
	If ?Debugging matches "#R#"
	Then
		IfRecall ?YesResponse then SayToConsole     "YesResponse:     "+?YesResponse; Continue
		IfRecall ?NoResponse then SayToConsole      "NoResponse:      "+?NoResponse; Continue
		IfRecall ?NotSureResponse then SayToConsole "NotSureResponse: "+?NotSureResponse; Continue
    Continue
EndTopic

Priority Topic "StdStatement Debugging" is 
	If ?Debugging matches "#S#" then
		IfRecall ?Anystatement then SayToConsole         "AnyStatement:         "+?AnyStatement;  Continue
	  	IfRecall ?ActStatement then SayToConsole         "ActStatement:         "+?ActStatement;  Continue
		IfRecall ?FactStatement then SayToConsole        "FactStatement:        "+?FactStatement; Continue
		IfRecall ?MessageStatement then SayToConsole     "MessageStatement:     "+?MessageStatement; Continue
		IfRecall ?IsStatement then SayToConsole          "IsStatement:          "+?IsStatement; Continue
		IfRecall ?HaveStatement then SayToConsole        "HaveStatement:        "+?HaveStatement; Continue
		IfRecall ?WantStatement then SayToConsole        "WantStatement:        "+?WantStatement; Continue
		IfRecall ?TimeStatement then SayToConsole        "TimeStatement:        "+?TimeStatement; Continue
		IfRecall ?ConditionalStatement then SayToConsole "ConditionalStatement: "+?ConditionalStatement; Continue
		IfRecall ?CauseStatement then SayToConsole       "CauseStatement:       "+?CauseStatement; Continue
		IfRecall ?FeelingStatement then SayToConsole     "FeelingStatement:     "+?FeelingStatement; Continue
		IfRecall ?OtherStatement then SaytoConsole       "OtherStatement:       "+?OtherStatement; Continue
	Continue
EndTopic


