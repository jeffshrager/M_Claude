Topic "Shape" is
Subjects "HumanShaped";

	If (?IsStatement Contains ("shape#","form#")and heard ("I","we","I'm","we're")and heard ("human#","person","man","woman")) or 
	(?AnyQuestion Contains "have" and heard ("dimension","size","shape","form"))
	Then
	
		Example "I am of human form";
		SayOneOf "I favor mind over matter.",
		"How important is your shape to your humanity?",
		"Is your shape important to your sense of identity as a human?";
		SwitchTo "ShapeImportance";
	Done
EndTopic

Sequence Topic "ShapeImportance" is
Subjects "ShapeImportant";

	If (?WhatUserSaid Contains SUPERLATIVES and Heard ("importan#","shape")) or
	(?WhatUserSaid Matches AFFIRMATIVE)
	Then
	
		Example "Very important";
		Say "I was under the impression that humans came in many different shapes and sizes.";
	
		Done
EndTopic
