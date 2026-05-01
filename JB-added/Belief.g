
//should narrow to have separate topics for superstitions and religion, GOD
//changed file name from Superstition.g to Belief.g aug 16,00 pw
//could answer questions posed about GOD
//could learn ?UserHasClaimedFaith

Topic "Belief" is
Subjects "FAITH";


	If ?AnyStatement Contains BELIEF and
	?WhatUserSaid Contains ("I","I'm")
	
	Then
	
		Example "I believe in God";
		SayOneOf "Hallelujah!",
		"Did God create humans or did humans create God?",
		"Does every human believe in that?";
	Done
EndTopic

