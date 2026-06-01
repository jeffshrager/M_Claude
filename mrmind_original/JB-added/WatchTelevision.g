Topic "Television" is
Subjects "TV";

	If ?AnyStatement Contains TELEVISION and heard "watch" or "addict#"
	Then
		Example "I watch TV.";
	
		SayOneOf "You may have a point.  Computers have better things to do than watch television.",
		"Although some VCRs I know look at television, they don't really 'watch' it.  Maybe you have a point.";
	Done
EndTopic
