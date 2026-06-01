
////////////////////////////////////////////////////////////////
// NameCapture.g
//
// A Gerbil(tm) Standard Robot Module
// For use only with the NeuroStudio(tm) Robot Server and
// Authoring System
//
//////////////////////For use with Shallow Red 16 June 1997
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



PatternList NameCapture.Titles is "Mr,", "Mrs,", "Miss,", "Ms,", "Dr,", "Sir", "Lord", "Lady",
			"Baron","Duke","Duchess","Count","Countess","Contessa","President","Senor", 
			"Herr", "Sr,", "Mister", "^."; //the last (&) is for first initials.

PatternList Namecapture.Prepositions is 
	"to","in","on","of","at","through","over","under","beside","behind", "between","among",
	"before","within","without","inside","outside","around","near","for";

//TopicList RedFilters is "Tsk Tsk", "Just said that", "I just said that";


Sequence Topic "Name Capture" is
	Always
//		Say ?Boldcode+"I'm a Virtual Representative made with NeuroStudio"+?TradeMark+".  "+;
		SayOneOf "What's your name?"+?EndBold,
			"Please tell me your name."+?EndBold,
			"What is your name?"+?EndBold;
		// disable things that commonly override responses to the
		// greeting
//		Suppress RedFilters;
		Remember ?NameTries is "1";
		WaitForResponse;
//		Recover RedFilters;
		SwitchTo "Name Parser";

	 	IfRecall ?HaveName 
		Then
			//Change this line so your bot recognizes its own name.  
			If ?Name Matches "Mr, Mind"
			Then
				//Change this line if you want the bot to say something else when 
				//it detects a user using its own name as the user's own.
				Say "That's my name.  What's yours?";
			TryAgain
			
			//note:  This is the name the automated testing mechanism gives when 
			//running examples.  You may change it if you like, but there are a 
			//couple of topics later in this file that check for it when the user 
			//asks, for example, "Who is testing?" -- we have standard topics in 
			//this file that watch for a user asking a ?whoquestion about her own 
			//name.  So if you change this, the examples in those topics will need 
			//to be changed accordingly.  
			
		 	InitialExample 2 "testing";

	 		//This is what the bot normally says to people who've just given 
			//their names.  Change it as you wish.  
			
			IfHeard "What's yours"  or ?DescriptionQuestion contains "Name" then say
				"I'm MR MIND, "+?Name+", Pleased to meet you.";
			Done				
			
			

		 	Say ?Boldcode+"Hello " + ?Name + ", can you convince me that you are human?"+?EndBold;
			Focus subjects "can you convince me";
		Done

	
		// Change this number to change the behavior of user-name.
		
		
		If ?NameTries Matches "3" Then
			// if we've already tried once plus the original one, give up.
			Say "Well, I can't figure out what name you want to be called, so I'll call you \"User\".  You can change it later if you want.";
			Remember ?Name is "User";
			Remember ?HaveName;
			IfRecall ?AnyQuestion then 
				InterruptSequence;
			Continue
		Done
		
		If ?NameTries Matches "2" Then
			Remember ?NameTries is "3";
		Continue

		If ?NameTries Matches "1" Then
			Remember ?NameTries is "2";
		Continue
		
		IfRecall ?NoResponse Then
			Say "Well, okay.  If you don't want to give your name, I can just call you \"User\".";
			Remember ?Name is "User";
			Remember ?HaveName;
			IfRecall ?AnyQuestion then 
				InterruptSequence;
			Continue
		Done
				
		IfRecall ?ReasonQuestion Then
				//This is what the bot says when it detects someone asking why 
				//it wants their name.  Change it as you like.
			Say "I need your name for no other reason than to make our conversation more pleasant.";
			SayOneOf "Please enter your name.","Please tell me your name.";
		TryAgain
		
		IfRecall ?AnyQuestion then 
			InterruptSequence; 
		Continue
		
		//for some reason this interruptSequence is not getting greeting topics.
		
		//This is what the bot says the second and third time it tries to get their name.  
		//It pops up after the response to whatever the user asked.  You may change it to 
		//suit the character of your bot.  Note that after the third try, the "done" in 
		//the nametries gets executed, so it never reaches here. 
		SayOneOf ?Boldcode+"Please enter your name so I'll know what to call you."+?EndBold,
			?Boldcode+"Please tell me what you want me to call you."+?EndBold;
	TryAgain
EndTopic


PatternList CommonNames is 
//shamelessly lifted from the US social security office records -- most popular names 
//for babies born in the US, 1997, with minor additions and changes by Ray Dillinger
//I figure the US, as a nation of immigrants, is probably a good representative 
//sample of names for the world -- though european names are probably overrepresented.

"AALIYAH", "AARON", "ABBIE", "ABBIGAIL", "ABBY", "ABDIEL", "ABEL", "ABIGAIL", 
"ABRAHAM", "ABRAM", "ADAM", "ADAN", "ADDISON", "ADELINE", "ADRIAN", 
"ADRIANA", "ADRIANNA", "AGUSTIN", "AHMAD", "AHMED", "AIDAN", "AILEEN", "AIMEE", 
"AIYANA", "AKIRA", "ALAIN", "ALAINA", "ALAN", "ALANA", "ALANIS", "ALANNA", "ALANNAH", 
"ALAYNA", "ALBERT", "ALBERTO", "ALDO", "ALEC", "ALEENA", "ALEJANDRA", 
"ALEJANDRO", "ALEX", "ALEXA", "ALEXANDER", "ALEXANDRA", "ALEXANDRIA", "ALEXIA", 
"ALEXIS", "ALEXUS", "ALFONSO", "ALFRED", "ALFREDO", "ALI", "ALICE", 
"ALICIA", "ALIJAH", "ALINA", "ALISHA", "ALISON", "ALLAN", "ALLEGRA", "ALLEN", 
"ALLEXIS", "ALLIE", "ALLISON", "ALLYSON", "ALMA", "ALONDRA", "ALONZO", "ALORA", 
"ALVIN", "ALYSHA", "ALYSON", "ALYSSA", "AMAIRANY", "AMALIA", "AMAN", "AMANDA", 
"AMARA", "AMBAR", "AMBER", "AMELIA", "AMIE", "AMINAH", "AMIR", "AMY", "ANA", 
"ANAHI", "ANAIS", "ANALI", "ANASTASIA", "ANDRE", "ANDREA", "ANDRES", "ANDREW", 
"ANDY", "ANGEL", "ANGELA", "ANGELENA", "ANGELICA", "ANGELINA", "ANGELO", 
"ANGIE", "ANIA", "ANISSA", "ANITA", "ANIYA", "ANNA", "ANNABEL", "ANNABELLE", 
"ANNASTASIA", "ANNE", "ANNIE", "ANNIKA", "ANNMARIE", "ANTHONY", "ANTOINE", 
"ANTON", "ANTONIA", "ANTONIO", "ANYA", "APRIL", "ARACELI", "ARACELY", "ARIANA", 
"ARIANNA", "ARIEL", "ARMAND", "ARMANDO", "ARNOLD", "ARTHUR", "ARTURO", "ARYN", 
"ASAD", "ASHLEE", "ASHLEIGH", "ASHLEY", "ASHLY", "ASHLYN", "ASHTEN", "ASHTON", 
"ASHTON", "ASHTYN", "ASIA", "ASPEN", "ASPYN", "AUBREE", "AUBREY", "AUDRA", 
"AUDREY", "AURORA", "AUSTIN", "AUSTYN", "AUTUMN", "AVA", "AVERY", 
"AVERY", "AXEL", "AYANNA", 

"BABY", "BAILEE", "BAILEY", "BAILY", "BARBARA", "BAYLEE", 
"BAYLIE", "BEAR", "BEATRIZ", "BEAU", "BELEN", "BELINDA", "BEN", "BENJAMIN", 
"BENNETT", "BERENICE", "BERNARD", "BETH", "BETHANY", "BETSY", "BEVERLY", 
"BIANCA", "BILLY", "BLADE", "BLAINE", "BLAIR", "BLAKE", "BLANCA", "BLAZE", "BOBBY", 
"BRAD", "BRADEN", "BRADLEY", "BRADY", "BRAEDEN", "BRANDEN", "BRANDI", "BRANDIN", 
"BRANDON", "BRANDY", "BRANNON", "BRAXTON", "BRAYDEN", "BREANA", "BREANNA", 
"BREANNE", "BREEANNA", "BREIANA", "BRENDA", "BRENDAN", "BRENDEN", "BRENDON", 
"BRENNA", "BRENNAN", "BRENT", "BRETT", "BRIA", "BRIAN", "BRIANA", "BRIANNA", 
"BRIANNE", "BRICE", "BRIDGET", "BRIDGETTE", "BRIEANN", "BRIELLE", "BRIGIT", 
"BRIGITTE", "BRIONNA", "BRITNEY", "BRITT", "BRITTANY", "BRITTENY", "BRITTNEE", 
"BRITTNEY", "BROCK", "BRODY", "BROOKE", "BROOKLYN", "BROOKLYNN", 
"BROOKLYNNE", "BRUCE", "BRYAN", "BRYANT", "BRYCE", "BRYN", "BRYSON", 
"BYRON", 

"CADE", "CADEN", "CAIN", "CAITLIN", "CAITLYN", "CALEB", "CALLIE", "CALVIN", 
"CAMDEN", "CAMERON", "CAMERON", "CAMI", "CAMILLE", "CANDACE", "CARA", "CARINA", 
"CARISSA", "CARL", "CARLA", "CARLEE", "CARLEY", "CARLI", "CARLIE", "CARLOS", 
"CARLY", "CARMEN", "CAROL", "CAROLINA", "CAROLINE", "CAROLYN", "CARRIE", 
"CARSON", "CARSON", "CARTER", "CARY", "CASANDRA", "CASEY", "CASEY", "CASSANDRA", 
"CASSIDY", "CASSIE", "CATALINA", "CATHERINE", "CATHLEEN", "CATHY", "CAYLIE", 
"CECILIA", "CELIA", "CEDRIC", "CEDRICK", "CELESTE", "CELINE", "CESAR", "CHAD", "CHANCE", 
"CHANDLER", "CHANDLER", "CHANEL", "CHANELLE", "CHANTEL", "CHARITY", "CHARLENE", 
"CHARLES", "CHARLOTTE", "CHASE", "CHASITY", "CHAUNCEY", "CHAYTON", "CHAZ", 
"CHELSEA", "CHELSEY", "CHESTER", "CHEYANNE", "CHEYENNE", "CHIDI", "CHLOE", 
"CHRIS", "CHRISTEN", "CHRISTIAN", "CHRISTINA", "CHRISTINE", "CHRISTOPHE", 
"CHRISTY", "CHYNA", "CIARA", "CIERRA", "CINDY", "CLAIRE", "CLARA", "CLARENCE", 
"CLARISSA", "CLARK", "CLAUDIA", "CLAY", "CLAYTON", "CLEO", "CLIFFORD", "CLINT", 
"CLINTON", "CLORISSA", "CLYDE", "COBY", "CODIE", "CODY", "COLBY", "COLE", "COLEMAN", 
"COLETTE", "COLIN", "COLLEEN", "COLLIN", "COLT", "COLTAN", "COLTON", "CONNER", 
"CONNOR", "CONOR", "CONRAD", "COOPER", "CORBIN", "CORDERIUS", "COREY", 
"CORINNE", "CORTNEY", "CORY", "COURTNEY", "COY", "CRAIG", "CRISOL", "CRISTAL", 
"CRISTIAN", "CRISTINA", "CRYSTAL", "CULLEN", "CURTIS", "CYNTHIA", 

"DAIJA", "DAISY", "DAKOTA", "DAKOTAH", "DALE", "DALLAS", "DALTON", 
"DAMIAN", "DAMIEN", "DAMION", "DAMON", "DAN", "DANA", "DANAE", "DANDRE", 
"DANE", "DANGELO", "DANIEL", "DANIELA", "DANIELLA", "DANIELLE", "DANNY", 
"DANTE", "DAPHNE", "DAQUAN", "DARBY", "DARIA", "DARIAN", "DARIUS", "DARLENE", 
"DARNELL", "DARREL", "DARRELL", "DARREN", "DARRIUS", "DASHON", "DASIA", 
"DAVE", "DAVIA", "DAVID", "DAVON", "DAYNA", "DAYTON", "DEAN", "DEANA", 
"DEANDRE", "DEANGELO", "DEANNA", "DEANNE", "DEANTHONY", "DEASIA", 
"DEBORAH", "DEJA", "DELANEY", "DELILAH", "DEMETRIUS", "DEMOND", "DENISE", 
"DENNIS", "DENZEL", "DEONTE", "DEQUAN", "DEREK", "DERRIC", "DERRICK", 
"DESEAN", "DESHAWN", "DESIREE", "DESMOND", "DESTANEE", "DESTANY", 
"DESTINEE", "DESTINY", "DEVAN", "DEVANTE", "DEVIN", "DEVIN", "DEVON", 
"DEVONTA", "DEVONTE", "DEVYN", "DIAMOND", "DIANA", "DIEGO", "DILLAN", 
"DILLION", "DILLON", "DINA", "DION", "DIVINE", "DOMENIC", "DOMINGO", 
"DOMINIC", "DOMINICK", "DOMINIQUE", "DONALD", "DONDRE", "DONNA", 
"DONNIE", "DONNY", "DONOVAN", "DONTAE", "DONTE", "DORIAN", "DOUGLAS", 
"DRAKE", "DREW", "DUANE", "DULCE", "DUNCAN", "DUSTIN", "COLTEN", 
"DUSTY", "DWAYNE", "DYLAN", 

"EAMON", "EBONI", 
"EBONY", "EDDIE", "EDEN", "EDGAR", "EDGARD", "EDMUND", "EDUARDO", "EDWARD", 
"EDWIN", "EFRAIN", "EILEEN", "ELAINA", "ELAINE", "ELEANOR", "ELENA", "ELENI", 
"ELEXUS", "ELI", "ELIANA", "ELIAS", "ELIJAH", "ELISA", "ELISABETH", "ELISE", "ELISHA", 
"ELIZABETH", "ELLA", "ELLEN", "ELSA", "ELSY", "ELVIA", "EMANUEL", "EMELY",  
"EMILEE",  "EMILIO", "EMILY",  "EMMA", "EMMANUEL", "EMMETT", "EMMITT", "EMORY", 
"ENOCH", "ENRIQUE", "ERIC", "ERICA", "ERICH", "ERICK", "ERIK", "ERIKA", "ERIN", 
"ERNEST", "ERNESTINA", "ERNESTO", "ERYKAH", "ESMERALDA", "ESPERANZA", 
"ESSENCE", "ESTEBAN", "ESTEFANI", "ESTEFANIA", "ESTEVAN", "ESTHER", "ETHAN", 
"EUGENE", "EUGENIA", "EULALIA", "EVA", "EVAN", "EVELYN", "EVERETT", "EZEKIEL", 
"EZRA", 

"FABIAN", "FAITH", "FATIMA", "FELICIA", "FELIPE", "FELIX", "FERNANDA", 
"FERNANDO", "FIONA", "FLOR", "FLORA", "FOSTER", "FRANCES", "FRANCESCA", 
"FRANCINE", "FRANCIS", "FRANCISCO", "FRANK", "FRANKIE", "FRANKLIN", "FREDDIE", 
"FREDDY", "FREDERIC", "FREDERICK", "FREDRICK",  

"GABRIEL", "GABRIELA", 
"GABRIELLA", "GABRIELLE", "GAGE", "GARRET", "GARRETT", "GARRISON", "GARY", 
"GAVIN", "GEMMA", "GENESIS", "GENEVIEVE", "GEOFFREY", "GEORGE", "GEORGIA", 
"GERALD", "GERARDO", "GIANCARLO", "GIANLUCA", "GIANNA", "GILBERT", "GILBERTO", 
"GILLIAN", "GINA", "GINO", "GIOVANNI", "GISELLE", "GISSELLE", "GLORIA", "GRACE", 
"GRANT", "GRAYSON", "GREGORY", "GREYSON", "GRIFFIN", "GRISELDA", "GUADALUPE", 
"GUADALUPE", "GUINEVERE", "GUNNAR", "GUNNER", "GUSTAVO", 

"HAILEY", "HAILY", 
"HALEIGH", "HALEY", "HALIE", "HALLIE", "HANA", "HANNA", "HANNAH", "HANS", 
"HARLEY", "HARLEY", "HAROLD", "HARRISON", "HARRY", "HASSAN", "HAVEN", "HAYDEN", 
"HAYLEE", "HAYLEY", "HAYLIE", "HEATHER", "HEAVEN", "HECTOR", "HEIDI", "HELEN", 
"HELENA", "HENRY", "HERIBERTO", "HERMAN", "HIEDI", "HILLARY", "HOLDEN", "HOLLEY", 
"HOLLY", "HOPE", "HUDSON", "HUNTER", "HUNTER", 

"IAN", "IBRAHIM", "IGNACIO", 
"ILA", "ILIANA", "IMANI", "INDIA", "INFANT", "INFANT", "INGRID", "IRENE", "IRIS", 
"IRMA", "IRVIN", "ISAAC", "ISABEL", "ISABELA", "ISABELLA", "ISABELLE", "ISAIAH", 
"ISAIAS", "ISIAH", "ISHMAEL", "ISMAEL", "ISRAEL", "ISSAC", "ITZEL", "IVAN", "IVANNA", 
"IVONNE", "IVORY", "IVY", 

"JABARI", "JACE", "JACEE", "JACEY", "JACHAI", "JACI", "JACK", 
"JACKELINE", "JACKELYN", "JACKLYN", "JACKSON", "JACLYN", "JACOB", "JACQUELINE", 
"JACQUELYN", "JADA", "JADE", "JADE", "JADEN", "JADEN", "JAIDA", "JAILENE", "JAIME", 
"JAIME", "JAKE", "JAKEB", "JAKOB", "JALEN", "JALIYAH", "JALYN", "JAMAL", "JAMEL", 
"JAMES", "JAMESHA", "JAMI", "JAMIE", "JAMIE", "JAMIL", "JAMILA", "JANA", "JANAE", 
"JANE", "JANELLE", "JANET", "JAQUELINE", "JARED", "JAROD", "JARON", "JARRED", 
"JARRETT", "JARRYD", "JARVIS", "JASHUE", "JASMIN", "JASMINE", "JASON", "JASPER", 
"JAVIER", "JAVION", "JAVON", "JAWON", "JAY", "JAYDA", "JAYLA", "JAYLEN", "JAYLON", 
"JAYME", "JAZMEN", "JAZMIN", "JAZMINE", "JAZMYNE", "JEAN", "JEANETTE", "JEDIDIAH", 
"JEFFERY", "JEFFREY", "JENA", "JENNA", "JENNI", "JENNIFER", "JENNY", "JERAD", 
"JERAMIAH",  "JEREMY", "JEROLD", "JEROME", "JERRY", "JESICA", "JESSA", "JESSE", 
"JESSENIA", "JESSI", "JESSICA", "JESSIE", "JESUS", "JILL", "JILLIAN", "JIMMY", 
"JOANNA", "JOCELINE", "JOCELYN", "JODIE", "JOE", "JOEL", "JOEY", "JOHANNA", 
"JOHN", "JOHNATHAN", "JOHNATHON", "JOHNNIE", "JOHNNY", "JOMAR", "JON", 
"JONAH", "JONAS", "JONATHAN", "JONATHON", "JORDAN", "JORDAN", "JORDANN", 
"JORDEN", "JORDEN", "JORDON", "JORDYN", "JORGE", "JOSE", "JOSEPH", "JOSEPHINE", 
"JOSEY", "JOSHUA", "JOSIAH", "JOSIE", "JOSLYN", "JOSUE", "JOVAN", "JOVANY", 
"JOY", "JUAN", "JUANITA", "JUDITH", "JULIA", "JULIAN", "JULIANA", "JULIANNA", 
"JULIE", "JULIET", "JULIETTE", "JULIO", "JULISSA", "JUNIOR", "JUSTICE", 
"JUSTIN", "JUSTINE", "JUSTUS", "JUSTYN", "JUWAN", 

"KACIE", "KADE", "KAELA", 
"KAI", "KAILA", "KAILEY", "KAILY", "KAITLIN", "KAITLYN",  "KAITLYNN", "KALEB", 
"KALEE", "KALEIGH", "KALEY", "KALI", "KALIANA", "KALYN", "KAMERON", "KANISHA", 
"KARA", "KAREEM", "KAREN", "KARI", "KARINA", "KARIS", "KARISSA", "KARLA", 
"KARLENE", "KAROLINE", "KARRIE", "KARSYN", "KASANDRA", "KASEY", "KASI", 
"KASIE", "KASON", "KASSANDRA", "KASSIDY", "KATE", "KATELIN", "KATELYN",  
"KATELYNN", "KATERI", "KATERINA", "KATHERINE", "KATHERYN", "KATHLEEN", 
"KATHRYN", "KATHY", "KATIA", "KATIE", "KATLIN", "KATLYN", "KATLYNN", "KATRINA", 
"KAYCE", "KAYCIE", "KAYLA", "KAYLEA", "KAYLEE", "KAYLEIGH", "KAYLENE", 
"KAYLEY", "KAYLIE", "KAYLIN", "KAYLYN", "KAYLYNN", "KC", "KEANA", "KEANNA", 
"KEATON", "KEEGAN", "KEELEY", "KEELY", "KEENAN", "KEIRSTEN", "KEIRSTIN", 
"KEISHA", "KEITH", "KELCIE", "KELLEN", "KELLER", "KELLI", "KELLIE", "KELLY", 
"KELLY", "KELSEY", "KELSI", "KELVIN", "KENDAL", "KENDAL", "KENDALL", 
"KENDALL", "KENDRA", "KENDRICK", "KENIA", "KENNA", "KENNEDI", "KENNEDY", 
"KENNETH", "KENNY", "KENSHAYLA", "KENT", "KENYON", "KENZIE", "KEON", 
"KERRY", "KERSTEN", "KESHAWN", "KETURAH", "KEVIN", "KEVONTE", "KEYLA", 
"KHRISTIAN", "KIANA", "KIARA", "KIERA", "KIERRA", "KIERSTEN", "KIERSTIN", 
"KILA", "KIMBERLY", "KIRK", "KIRSTEN", "KOBE", "KOBY", "KODY", "KOLBY", 
"KOLE", "KOLLIN", "KOLTON", "KONRAD", "KORAH", "KORY", "KOURTNEY", 
"KRISTA", "KRISTEN", "KRISTIAN", "KRISTIN", "KRISTINA", "KRISTOPHER", 
"KRISTY", "KRISTYN", "KRYSTAL", "KYLA", "KYLE", "KYLEE", "KYLER", "KYLIE", 
"KYRA", "KYRAH", 

"LACEY", "LACY", "LADARIUS", "LAKIN", "LAMAR", "LAMONT", 
"LANCE", "LANDON", "LANE", "LAQUANDA", "LARRY", "LAURA", "LAUREN", 
"LAURENCE", "LAURYN", "LAWRENCE", "LEAH", "LEANN", "LEE", "LEIGH", 
"LEIGHANNE", "LEILANI", "LELAND", "LENA", "LEO", "LEON", "LEONARD", 
"LEONARDO", "LEONEL", "LESLEY", "LESLIE", "LESLIE", "LESLY", "LETICIA", 
"LEVI", "LEWIS", "LEXI", "LEXIE", "LEXIS", "LEXUS", "LIAM", "LIANA", "LIANNA", 
"LILIAN", "LILIANA", "LILIBETH", "LILLIAN", "LILLIANNE", "LILLIE", "LILLY", "LILY", 
"LINA", "LINDA", "LINDSAY", "LINDSEY", "LINH", "LISA", "LIZBETH", "LIZMARIE", 
"LLOYD", "LOGAN", "LOGAN", "LOREN", "LORENA", "LORENZO", "LOUIS", 
"LOURDES", "LUCAS", "LUCIANO", "LUCIO", "LUCY", "LUIS", "LUISA", "LUKAS", 
"LUKE", "LYDIA", "LYLE", "LYNDON", "LYNDSEY", "LYNN", "LYNZIE", 

"MACEY", "MACKENZIE", "MACY", "MADALYN", "MADELEINE", "MADELINE", 
"MADELYN", "MADILYN", "MADILYNN", "MADISON", "MADISON", "MADYSON", 
"MAEGEN", "MAEVE", "MAGDALENA", "MAGGIE", "MAHMOUD", "MAKAILA", 
"MAKAYLA", "MAKENNA", "MAKENZIE", "MALCOLM", "MALENA", "MALIA", 
"MALIK", "MALLORY", "MANDY", "MANUEL", "MARAH", "MARANDA", "MARC", 
"MARCEL", "MARCELLUS", "MARCO", "MARCOS", "MARCUS", "MARGARET", 
"MARGARITA", "MARGARITO", "MARIA", "MARIAH", "MARIANA", "MARIBEL", 
"MARICELA", "MARIE", "MARIHA", "MARILYN", "MARINA", "MARIO", "MARISA", 
"MARISOL", "MARISSA", "MARJORIE", "MARK", "MARLA", "MARLEE", "MARLENA", 
"MARLENI", "MARLON", "MARQUIS", "MARQUISE", "MARSHALL", "MARTHA", 
"MARTIN", "MARVIN", "MARY", "MASON", "MASON", "MATEO", "MATHEW", 
"MATTHEW", "MATTISON", "MAURA", "MAURICE", "MAX", "MAXIMILIAN", 
"MAXIMILLIA", "MAXWELL", "MAYA", "MAYRA", "MAYTE", "MCKAYLA", "MCKENNA", 
"MCKENZIE", "MEAGAN", "MEAGHAN", "MEGAN", "MEGHAN", "MELANIE", "MELINA", 
"MELINDA", "MELISSA", "MELVIN", "MERCEDES", "MEREDITH", "MIA", "MICAH", 
"MICAH", "MICHAEL", "MICHAELA", "MICHAELLA", "MICHEAL", "MICHELE", 
"MICHELLE", "MICKI", "MICKIE", "MIGUEL", "MIKA", "MIKAELA", "MIKAIL", 
"MIKAL", "MIKALA", "MIKAYLA", "MIKE", "MIKEL", "MIKHAIL", "MILES", "MILTON", 
"MINDY", "MIRANDA", "MIRELLA", "MIREYA", "MIRIAM", "MITCHELL", "MOHAMED", 
"MOHAMMAD", "MOHAMMED", "MOLLIE", "MOLLY", "MONA", "MONAE", "MONET", 
"MONICA", "MONIQUE", "MONTY", "MORGAN", "MORGAN", "MORIAH", "MOSES", 
"MOSHE", "MYCALA", "MYKAYLA", "MYLES", "MYRA", "MYRANDA", 

"NADIA", 
"NADINE", "NANCY", "NAOMI", "NASHALIE", "NASHALY", "NASIR", "NATALIA", 
"NATALIE", "NATASHA", "NATHAN", "NATHANAEL", "NATHANIAL", "NATHANIEL", 
"NAUTICA", "NEAL", "NEHEMIAH", "NEIL", "NIA", "NICHOLAS", "NICHOLE", 
"NICKLAS", "NICKOLAS", "NICOLAS", "NICOLE", "NICOLETTE", "NIKHIL", 
"NIKKI", "NINA", "NOAH", "NOE", "NOEL", "NOEMI", "NOLAN", "NOOR", 
"NORBERTO", "NORMA", "NORMAN", "NYASIA", "NYLA", 

"OCTAVIO", "OCTAVIOUS", 
"OLIVER", "OLIVIA", "OMAR", "ORLANDO", "OSBALDO", "OSCAR", "OSCAR", 
"OSVALDO", "OWEN", 

"PABLO", "PAIGE", "PAMELA", "PAOLA", "PARIS", "PARKER", 
"PASSION", "PATRICIA", "PATRICK", "PAUL", "PAULA", "PAULINA", "PAULINE", 
"PAYTON", "PAYTON", "PEDRO", "PERLA", "PERRY", "PETER", "PEYTON", 
"PEYTON", "PHILIP", "PHILLIP", "PHOEBE", "PIERCE", "PIERRE", "PRECIOUS", 
"PRESTON", "PRINCESS", "PRISCILLA", "PRIYA", 

"QUENTIN", "QUINN", "QUINTON", 

"RACHAEL", "RACHEAL", "RACHEL", "RADHIKA", "RAFAEL", 
"RAHEEM", "RAHMAN", "RAINA", "RAJEEV", "RALPH", "RAMIRO", "RAMON", 
"RANDALL", "RANDY","RAPHAEL", "RAQUEL", "RASHAWN", "RAUL", "RAVEN", 
"RAYMON", "RAYMOND", "RAYVON", "REAGAN", "REBECCA", "REBEKAH", 
"REECE", "REGAN", "REGINA", "REGINALD", "REID", "REILLY", "REMY", 
"RENE", "REYNA", "REYNALDO", "RHETT", "RICARDO", "RICHARD", 
"RICKEY", "RICKY", "RILEY", "RILEY", "RITA", "ROBBIE", "ROBERT", 
"ROBERTO", "ROBIN", "ROBYN", "RODERICK", "RODNEY", "RODRIGO", 
"ROGER", "ROLAND", "ROMAN", "ROMEO", "RONALD", "RONNIE", "RORY", 
"ROSA", "ROSE", "ROSS", "ROXANA", "ROXANNA", "ROY", "RUBEN", "RUBY", 
"RUDY", "RUEBEN", "RUSSELL", "RUSTY", "RUTH", "RYAN", "RYAN", 
"RYLAND", "RYLEE", "RYLEIGH", "RYLEY", "RYLIE", 

"SABRINA", "SAGAR", 
"SAGE", "SALVADOR", "SALVATORE", "SAM", "SAMANTHA", "SAMIR", "SAMIRA", 
"SAMMY", "SAMUEL", "SANDRA", "SANDY", "SANTIAGO", "SANTINO", "SARA",  
"SARAH",  "SASHA", "SAUL", "SAVANAH", "SAVANNA", "SAVANNAH", "SCOTT", 
"SEAN", "SEBASTIAN", "SELENA", "SERENA", "SERENITY", "SERGIO", "SETH", 
"SHAKIRA", "SHAKUR", "SHAN", "SHANE", "SHANIA", "SHANNON", "SHANNON", 
"SHANTEL", "SHAQUILLE", "SHAROD", "SHARON", "SHAUN", "SHAWNEE", 
"SHAY", "SHAY", "SHAYLA", "SHAYNA", "SHEA", "SHEA", "SHEILA", "SHELBY", 
"SHELTON", "SHEMAR", "SHERIDAN", "SHILO", "SHYANN", "SIDNEY", "SIERRA", 
"SILAS", "SIMON", "SIMONE", "SKYLAR", "SKYLER", "SKYLER", "SOFIA", 
"SOLOMON", "SONIA", "SONJA", "SONYA", "SOPHIA", "SOPHIE", "SPENCER", 
"STACY", "STANLEY", "STARR", "STEELE", "STEFANIE", "STEFANY", 
"STEPHAN", "STEPHANIE", "STEPHEN", "STEPHON", "STERLING", "STEVE", 
"STEVEN", "STONE", "SULLIVAN", "SUMMER", "SUSAN", "SUSANA", "SUSANNA", 
"SUZANNA", "SYDNEY", "SYLVIA", 

"TABITHA", "TAHJ", "TAJAY", "TALIA", "TAMARA", "TAMERA", "TAMIA", "TANIA", 
"TANISHA", "TANNER", "TANYA", "TARA", "TARYN", "TASHA", "TATIANA", 
"TATIANNA", "TATYANA", "TAYLER", "TAYLOR", "TAYLOR", "TEA", "TEDDY", 
"TERENCE", "TERRANCE", "TERRELL", "TERRENCE", "TERRI", "TERRY", "TESS", 
"TESSA", "THADDEUS", "THALIA", "THEODORE", "THERESA", "THOMAS", "TIA", 
"TIANA", "TIARA", "TIARRA", "TIERA", "TIERRA", "TIFFANY", "TIMMOTHY", 
"TIMMY", "TIMOTHY", "TINA", "TOBY", "TODD", "TOMMY", "TONY", "TORI", 
"TRACE", "TRAVIS", "TRE", "TRENT", "TRENTON", "TRESTON", "TREVOR", 
"TREY", "TRINITY", "TRISTAN", "TRISTEN", "TRISTIN", "TRISTON", "TROY", 
"TUCKER", "TURNER", "TY", "TYGA","TYLER", "TYLOR", "TYRA", "TYREE", 
"TYREEK", "TYRELL", "TYRONE", "TYSON", 

"URIAH", "URIEL", "UZZIEL", 

"VALERIA", "VALERIE", "VANESA", "VANESSA", "VERONICA", "VICENTE", "VICTOR", 
"VICTORIA", "VIKRAM", "VINCENT", "VIRGINIA", "VIVIAN", "VIVIANA", "VLADIMIR", 

"WALKER", "WALTER", "WAYLON", "WAYNE", "WESLEY", "WESTON", 
"WHITNEY", "WILFREDO", "WILLIAM", "WILLIE", "WILSON", "WYATT", 

"XAVIER", "XENA", 

"YASMIN", "YASMINE", "YESENIA", "YESSENIA", "YOLANDA", "YVETTE",

"ZACHARIAH", "ZACHARIAS", "ZACHARY", "ZACHERY", "ZACKARY", "ZACKERY", 
"ZANE", "ZOE";


Sequence Topic "Name Parser" is
//This topic scans an utterance looking for a user's name.  The assumption is that 
//you just asked for a name, then waited for a response, then switched here.  If a 
//name is found, and ?Havename is set, then the name will be changed to the one that 
//was found.  If a name is found, and ?havename is not set, then ?Havename will be set 
//and the name will be changed to that found.  If a name is not found, then the name 
//field will be set to "user" and ?Havename will not be set.  
//In all cases, it switches back to the topic that switched-to it.  


//Design note:  There are only two acceptable results from this procedure; 
//success and failure.  Make **SURE** that no matter how you modify this, it 
//Always calls exactly one of the two sequence topics "Name parser got name" 
//or "Name parser missed name" immediately before exiting.  They do some 
//bookkeeping and control-variable stuff that this routine relies on to 
//function correctly if called again. 

	Always
	//first thing, the guy who says "no you can't have my name."
	IfRecall ?NoResponse then 
		SwitchTo "Name Parser Missed Name";
	SwitchBack
	
	//At the beginning of this silliness, We are working with ?WhatUserSaid.
	//We are not using ?WhatUserMeant because we don't want usernames spellchecked.
	Remember ?NameCapture.TempName is ?WhatUserSaid;
	
	//This is a flag; it is true or false when we return, depending on whether 
	//we have identified and set a new username.
	Forget ?HaveName;

	//This is a "fallback value" name that we may use if we can't detect a name 
	// in something that *MUST* have a name in it... our best guess, in other words. 
	// however, at this point it is possibly a stale value left over from last call.
	// we're about to set it if necessary; we forget it now so if it's not being set 
	// this call we reliably find that it is empty during this call. 
	Forget ?NameCapture.RecoverName;

	//First if one of these prefatory phrases appears, we get rid of everything that comes 
	//before it.  The name, if it appears, comes after these. 
		If ?NameCapture.TempName Contains "name is*", "name be*", "name's*", "known as*", "called*", 
			"named*", "I'm just plain old*", "I'm just plain*", "I'm just*", "I'm*", 
			"it's just me*", "It is just me*", "it is just*", "it's just*",
			"I am just plain old*", "I am just plain *", "I am just*", "I am*", "call me*", 
			"it is*", "it's*", "named me*", "name me*", "this is*" 
		Then Remember ?NameCapture.TempName is *1;
		//and since these clauses are dead giveaways that a name follows, we will remember 
		//a "last-ditch" name just in case nothing else works, which is the first following 
		//word.  Basically if those phrases appear, we will pick *something* to call a name. 
		     if ?NameCapture.TempName Matches "#*" then remember ?NameCapture.RecoverName is #1;
			 Continue
		Continue


	//Proactively look for common names  in the absence of a "giveaway phrase" --  
		If ?NameCapture.TempName matches "#*" and #1 matches COMMONNAMES then 
			Remember ?NameCapture.RecoverName is #1; 
		Continue
		If DontRecall ?NameCapture.RecoverName 
			and ?NameCapture.TempName contains COMMONNAMES then
			Remember ?NameCapture.RecoverName is *Match; 
		Continue
		
				
	If (Recall ?AnyQuestion and dontRecall ?NameCapture.RecoverName)
		//if the user asked a question, and didn't give us a giveaway phrase that indicates 
		//a name -- or a common name -- we assume no name was present...
	Then
		Switchto "Name Parser Missed Name";
	SwitchBack

	//before we strip phrases that follow commas, we have to check for the "Bond, James Bond" case.
	//note, we're using non-literal commas in this pattern - they might be periods, or semicolons, 
	//or altogether absent.
	If ?NameCapture.Tempname matches "#, # #,*"  
		Then 
			if #1 Matches #3 
			Then Remember ?NameCapture.Tempname is #2;
		continue
	Continue

	// The next thing we do is strip off any subsequent phrases following commas: 
	// Commas, other than in the above situation, do not appear within names, and the 
	// name should now be in the first clause (or the clause containing the above prefatory 
	// phrase if any). 
	
	If ?NameCapture.TempName Matches "*\,*\,*\,*" then remember ?NameCapture.TempName is *1; Continue
	If ?NameCapture.TempName Matches "*\,*\,*" then remember ?NameCapture.TempName is *1; Continue
	If ?NameCapture.TempName Matches "*\,*" then remember ?NameCapture.TempName is *1; Continue

		Switchto "strip non-name words";		Switchto "strip non-name words";

	//Now we check.  If we have a single word, the simplest case, then we will call 
	//that word our user's name.
	
		If ?NameCapture.Tempname matches "#", "#-#", "^\.^\.","^\.,#"
		//also hyphenated names like anne-marie and jean-luc and pairs of initials.
		Then 
			SwitchTo "Name Parser Got Name";
		SwitchBack

	//now we strip things from the front that are never names.
		Switchto "strip non-name words";		Switchto "strip non-name words";

	//We check again to see if we've cut it down to a single word. 
		If ?NameCapture.Tempname matches "#", "#-#","^\.^\.","^\.,#"
		Then 
			SwitchTo "Name Parser Got Name";
		SwitchBack

	//Now we look for prepositions -- if anything follows a preposition, it's not part of the name.
		If ?NameCapture.TempName matches "*"+NameCapture.Prepositions+"*"
		Then 
			Remember ?NameCapture.TempName is *1;
		Continue

	//We check again to see if we've cut it down to a single word. 
		If ?NameCapture.Tempname matches "#","#-#","^\.^\.","^\.,#"
		Then 
			SwitchTo "Name Parser Got Name";
		SwitchBack

	//We're also checking for initials separated by periods and not followed by a period...
		If ?NameCapture.TempName Matches "^\.^" Then
			Remember ?NameCapture.TempName is ?NameCapture.TempName+"."; 
			SwitchTo "Name Parser got Name";
		SwitchBack

	//We're also willing to check at this point for title + lastname.
		If ?NameCapture.TempName Matches NameCapture.Titles + ("#","#-#") 
		Then
			// A title and a last name, keep both
			SwitchTo "Name Parser got Name";
		SwitchBack
		
		
    //Title plus more than one word, we assume means the name is the first word following 
	//The title. 
		If ?NameCapture.TempName Matches NameCapture.Titles + " # *" Then 
			Remember ?NameCapture.TempName is #1;
		Continue
		
		If ?NameCapture.TempName Matches NameCapture.Titles + " #-# *" Then 
			Remember ?NameCapture.TempName is #1+"-"+#2;
		Continue

  	//We make our check again to see if we've reduced it to a word.
		If ?NameCapture.TempName Matches ("#","#-#","^\.^\.") 
		Then
			SwitchTo "Name Parser got Name";
		SwitchBack
		
	//If it hasn't fallen out by this point, we'll try to take the first word of 
	//the ?Namecapture.tempname string.  It's always possible we've reduced it to 
	//nothing by this point though. 
	
		If ?NameCapture.TempName matches ("# *")
	 	then 
			Remember ?NameCapture.TempName is #1;
			SwitchTo "Name Parser got Name";
		Switchback
		
		If ?NameCapture.TempName matches ("#-# *")
	 	then 
			Remember ?NameCapture.TempName is #1+"-"+#2;
			SwitchTo "Name Parser got Name";
		Switchback
		
		If ?NameCapture.TempName Matches "^\.^ *","^\.^\. *" 
		Then
			Remember ?NameCapture.TempName is ^1+"."+^2+"."; 
			SwitchTo "Name Parser got Name";
		SwitchBack

	//At this point we're very nearly out of tricks.  If we haven't managed to 
	//get a name yet, we're going to use the ?Recovername we captured at the beginning 
	//as the first word following a "dead giveaway" phrase, and hope. Sometimes, it'll 
	//be something stupid like "THE", but whatever... this shouldn't happen often. 
	
		If Recall ?NameCapture.RecoverName 
		Then 
			SayToConsole "#### WARNING:  UNHANDLED CASE IN NAME CAPTURE ROUTINE!!! ####";
			Remember ?NameCapture.TempName is ?NameCapture.RecoverName;
			SwitchTo "Name Parser got Name";
		SwitchBack

	//Last thing: If the user refuses to give his name, we just pretend he said 
	//his name was "user." 
		If Recall ?NoResponse Then
			Say "That's ok, I'll just call you \"User\".  ";
			Remember ?NameCapture.TempName is "User";
			SwitchTo "Name Parser got Name"; 
		SwitchBack
		
		//And if all of that didn't work, then ....
		SwitchTo "Name Parser Missed Name";
	SwitchBack
EndTopic


Sequence Topic "strip non-name words" is 
	Always 
		if ?NameCapture.TempName matches 
			("a","an","the","one","I", "hi", "howdy", "hello", "what", "another","or",
				"who", "this", "just","great","my","your","best","worst", "Don't","know")+"*" 
		then 
		remember ?NameCapture.TempName is *1;
		Continue		
	SwitchBack
EndTopic

//Punctuation to strip from the end of names.
PatternList Punc is "\.","\?","\!","\,";

Sequence topic "Name Parser Got Name" is 
	Always 
		//okay, if we get to here, then ?NameCapture.Tempname is the new name.
	 	Remember ?Name is ?NameCapture.TempName;
		
		//first we strip trailing punctuation, in cases other than initials.
		if ?Name matches "#"+Punc+Punc+Punc+Punc Then remember ?Name is #1; continue
		if ?Name matches "#"+Punc+Punc Then remember ?Name is #1; continue
		if ?Name matches "#"+Punc Then remember ?Name is #1; continue

		//then we fuss with the capitalization....
		Remember ?name is compute Lowercase of ?Name;
		Remember ?Name is compute Capitalize of ?Name;
		If ?Name matches "^\.^\." then remember ?NAME is compute uppercase of ?Name; continue
			//and in the case of a first initial and name, we "correct" spacing as well.
		If ?name matches "^\.,#" then 
			remember ?Name1 is compute uppercase of ^1;
			remember ?Name2 is compute capitalize of #1;
			remember ?name is ?Name1+". "+?Name2;
		continue 
		
		//Then we set the flag to tell the caller that Name Parser succeeded
		Remember ?HaveName;

	SwitchBack
EndTopic


Sequence Topic "Name Parser Missed Name" is 
	Always 
		If DontRecall ?Name //If the user has no name
		then 
			Remember ?Name is "User"; 
				//Placeholder -- this guarantees that ?name is never 
				//empty after the first time this routine is called.
		SwitchBack
			
		If ?Name DoesNotMatch "User" 
			then //No action:  we prefer to keep using it rather than re-dubbing her "User".
		SwitchBack
		
	SwitchBack  //This switchback is executed in the case where the name parser 
				//was called on a user whose username was "User", and failed.
EndTopic


Topic "about the user's name and name change" is
Subjects "USER";
	If (?DescriptionQuestion Contains "my*name","call me")
		or (?WhoQuestion Matches I)
    Then
		Example "What is my name?";
		Say "You told me your name is " +?Name+".";
	Done
EndTopic

Topic "Quit calling me Shirley!" is 
Subjects "USER";
   	IfHeard "quit call# me ","stop call# me", "lied*my name","change my name" 
	  or (heard NT and ("my name","call# me"))
	Then
		Example "Quit calling me Shirley!";
		Say "What would you like to be called?";
		WaitForResponse;
		SwitchTo "Name Parser";
	 		IfRecall ?HaveName 
			Then
				Say "Thank you, " + ?Name + ".";
			Done

	//and if you didn't get a name, bug the guy about it. 
	  	Say "I'm not sure I understand.  What did you want to change your name to?";
		WaitForResponse;
		SwitchTo "Name Parser";
 			IfRecall ?HaveName 
			Then
				Say "Thank you, " + ?Name + ".";
			Done
			
			IfRecall ?NoResponse 
			Then
				Say "Okay.  Remember you can change your name whenever you want.";
			Done
				
			IfRecall ?YesResponse 
			Then
				Say "What would you like to be called?";
			TryAgain
		Say "Ok. I must have made a mistake.";
	Done
EndTopic
	

Topic "Who is User's name?" is
SUBJECTS "USER"; 
	If Recall ?WhoQuestion and Heard ?Name 
	Then 
		Example "Who is testing?";
		Say "Well, you told me that you were "+?Name+".";
	Done
EndTopic



Topic "My name is ... " is 
Subjects "USER";
	If ?WhatUserSaid Matches "my name is *", "my name's *", "call me *", "please, call me *", 
			"I * be called *" and notheard 
			"call me*"+("tomorrow", "sometime", "in a few", "in a couple", 
						"whenever", "in just a", "next*" )
	    Then
		SwitchTo "Name Parser";
 		IfRecall ?HaveName Then
			Example "call me Testing";
			Say "Ok, " + ?Name + ".";
		Done
		Otherwise Always
			Say "I'm sorry, I don't understand what you mean.";
		Done
	Continue
EndTopic	


OtherExamples of "What is my name" are 
	"Do you know my name?";



Topic "Can you tell me my name" is
SUBJECTS "USER";
//this is a kluge -- the question is answered above, but there is another question 
//for shallow red's name that responds to it with greater specificity, hence this is 
//needed to pre-empt it.
	If Heard YOU and Recall ?CanQuestion, ?DescriptionQuestion, ?FactQuestion and 
		Heard "tell me*my name" Then
		Example "Can you tell me my name?";
		Say "Sure. Your name is "+?Name+".";
	Done
EndTopic

