////////////////////////////////////////////////////////////////
//CommentFilter.g
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


// This file extracts user comments and emails them to the botmaster. 
// Written by Ray Dillinger for Neuromedia, Inc, March 1998.


	

Priority Topic "Comments to Bot Master" is
	If ?WhatUserSaid Matches "//*" Then
		SayOneOf "Your comment was sent directly to the Bot Master.",
				"Your comment was sent via email to the Bot Master.";

		Remember ?mail.to is "ray@neurostudios.com";
		Remember ?mail.subject is "user comment from shallow red";
		Remember ?mail.replyto is "shallowred@neurostudios.com";
		Remember ?mail.from is "shallowred@neurostudios.com";
		Remember ?mail.body is  "        USER:: "+?WhatUserSaidBeforeThat+
		                        "        SHALLOWRED:: "+?WhatRobotSaidBeforeThat +
								"        USER:: "+?WhatUserSaidBefore +
								"        SHALLOWRED:: "+ ?WhatRobotSaid +
								"        USER:: "+ ?WhatUserSaid;
//		SwitchTo "SendMail";
	Done
EndTopic

sequence topic "SendMail" is

//This is a sequence topic which may be called from anywhere in the bot.
//It assumes you have the mail.* parameters set correctly. 

	Always
		Remember ?Totarget is Compute URLEncoding of ?Mail.to;
		Remember ?Subjecttarget is Compute URLEncoding of ?Mail.Subject;
		Remember ?Replytarget is Compute URLEncoding of ?mail.replyto;
		Remember ?FromTarget is Compute URLEncoding of ?Mail.from;
		Remember ?BodyTarget is Compute URLEncoding of ?mail.body;
		SayToConsole ?BodyTarget;
		DO "SHOW SRC=http://www.neurostudios.com/cgi-neuro/mailman.cgi?TO="+
			?Totarget+"&SUBJECT="+?Subjecttarget+"&REPLY-TO="+?Replytarget+"&FROM="+
			?FromTarget+"&BODY="+?BodyTarget + " Target=_blank";

	SwitchBack 
EndTopic
