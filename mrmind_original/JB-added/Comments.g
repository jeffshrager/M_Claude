Topic "Comments" Is
Subjects "Comments";
	If (?CanQuestion Contains ("send","have","submit","offer") and ("email","comments","message","mail","feedback"))
		or (?MethodQuestion Contains ("send","have","submit","offer") and ("email","comments","message","mail","feedback"))
		or (?HaveStatement Contains ("send","have","submit","offer") and ("comments","feedback","suggestions"))
	Then
	Example "Can # send email to your programmer?";
	Say ("Please direct all comments to <a href=mailto:MRMIND@weblab.org>MRMIND@weblab.org</a>");
	Done
EndTopic
