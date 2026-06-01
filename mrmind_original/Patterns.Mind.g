PatternList ACCESSORYCLOTHING is "bracelet", "necklace", "ring", "cufflink", "button", "zipper", "earring", "jewelry";

PatternList ARTIST is "Artist", "Painter", "Sculptor", "Inventor", "Architect","Writer","Storyteller","Author"; 

PatternList ATTRACTIVE is "sexy", "attractive", "lovely", "foxy", "beautiful";

PatternList BABY is "baby", "child", "toddler", "kid","just a kid", "youth", "youngster", "young";

PatternList BADMOOD is "mad","sad","angry","pissed","upset","bummed"," hate",
"tired","sleepy"," edgy","jumpy","nervous","anxious","worry","worried","confused",
"mixed up","exasperated","frustrated","paranoid","schizo#","nutty","crazy"," wacko",
"mood#","aroused","depressed","horney","horny","lonely","bored";

//PatternList BELIEVE is "Believe", "believe in","have belief in", "believe that", "have faith that","have faith in";
//cut these off BELIEVE...didn't look right. -JB  "understand","have an understanding of","understand that";

PatternList BELLYBUTTON is "Belly,button","navel","umbilical";

// 'Sleep' removed from BODYFUNCTION to enable a separate catch... -JB
//may separate out sports from the rest...
PatternList BODYFUNCTION is 
	"arous#","bathroom","breath#","bike", "bicycle", "cold", "crawl","cry","dance",
	"dream","drink","drinking","drool","dying","eat","eating","exhale","fantas*","frown",
	"giggle","hard","hear","HIV Positive","hot","ill","inhale","jump","KISS",
	"laugh","leap","LICK" ,"lift weights","march", "pee", "perspire","run","see",
	"sick","smell","SMILE", "smirk","smoke","snore","speak","spit","Suffering",
	"sweat","swim","talk","taste","tired","touch","walk","weep";
	

PatternList BIRTHWORD is "womb","born","birth#","sex# reproduc#", "delivered", 
	"umbilical", "uterus";

// 'thumbs','hand','hands' removed from BODYPARTS to enable separate catch in topic THUMBS -jb	
PatternList BODYPARTS is "arm","arms","balls","ball","body","brain","brains",
	"breast","breasts","buttocks","cheek","cheeks","dick","leg","legs","knee",
	"knees","ear","ears","elbow#","eye","eyes","eyebrow","eyebrows","finger#",
	"foot","feet","hair","head","heart","hip","hips","lung",
	"knuckle#","lungs","neck","nose","nostril#","penis","prick","pussy","skin",
	"teeth","testicl#","toe","toes","shoulder#","vagina","wrist";

PatternList BODYPARTWORD is "face","faces","hair","hairs","eye","eyes","tongue#","hand", 
	"hands", "arms", "foot","feet","skin","nose#","body","finger#", "toe", "toes", "lip", 
	"lips", "brains", "sense*smell", "sense*touch", "sense*sight", "sense*taste", 
	"sense*hearing", "brain";

PatternList BOTS is "BOT","BOT's","Program","Programs","machine#","computer#";	
	
//PatternList CARE is "care","caring","nurtur#";	

PatternList CARRY is "carry","take","bring","transport";

PatternList CLOTHES is "clothes","underwear","boxers","briefs","boxer shorts","pants","coat",
	"jacket", "shirt", "bra", "lingerie", "teddy", "suit", "panties", "socks", "shoes", "heels",
	"pumps", "loafers", "jeans", "slacks", "briefs", "necktie", "tie", "bowtie", ACCESSORYCLOTHING; 

PatternList COMPUTER is "machine","computer#","computers","PC","box", "bot#";

PatternList CONVINCE is "convinc#","persuad#","teach#","tell#";

PatternList COOKING is "cooks","cook","cooking","makes","making","made","bake#","fry",
	"fries","broil#","barbe^ue#", "prepar#";
	
PatternList COUNTRY is "Australia","Bangladesh","Canada","Austria","France","Germany","Poland","Belgium","Netherlands",
	"Spain","Portugal","Monaco","Italy","Switzerland","Hungary","Turkey","Latvia","Lithuania","Norway",
	"Sweden","Denmark","Finland","Iceland","Yugoslavia","Czech Republic","Kazakhstan","Pakistan","India","China",
	"Korea","Singapore","Malaysia","Indonesia","Brunei","Japan","Taiwan","Cambodia","Laos","Vietnam","Kurdistan",
	"Afghanistan","Sudan","Tunis","Algeria","Libya","Iraq","Iran","Saudi Arabia","Qatar","Yemen","Egypt","Israel",
	"Syria","Lebanon","Chad","Gabon","Sierra Leone","Mexico","Nicaragua","Nigeria","El Salvador",
	"Panama","Colombia","Venezuela","Peru","Chile","Brazil","Argentina","England","Zealand","Tadzhikistan",
	"Mongolia","Bulgaria","Greece","Cameroon","South Africa","Philippines","Somalia","Zaire","Congo","Rwanda",
	"Ivory Coast","Benin","Costa Rica","Cuba","Haiti","Dominican Republic","Bermuda","Bahamas",
	"Estonia","Ireland","Scotland","Wales","Jamaica","Andorra","United Arab Emirates","Guyana","Angola",
	"Russia","Ukraine","United States","America","Belarus", "Uruguay";
	
PatternList CREATE is "create", "creative", "make", "craft", "make up", "draw", "paint", "build", "sculpt", "compose", 
	"write", "innovate", "invent";
	
PatternList CREATIVE is "creative", "imaginative", "innovative", "inventive", "inventor";

PatternList CREATIVITY is "creativity";
	
PatternList DEVELOPSYNONYMS is "develop#", "creat#", "mak#", "form#", "produc#*";

PatternList DRUGS is "drug#","LSD","coffee","tea","caffeine","nicotine","cigarettes","alcohol",
	"booze","crystal","meth","crack","methamphetamine","Heroin","X","ecstasy","absinthe","GHB",
	"marijuana","marihuana","dope","amphetamine","weed","hashish","pot";

PatternList EASY is "easy","cinch";	

PatternList EAT is "eat", "eating", "drink", "chew", "swallow";
	
//adjectives only
PatternList EMOTIONAL is "emotional","empathic","empathetic","feeling","happy","in love",
	"in*mood","joyful","loving","lonely","mad","manic";

PatternList NegativeEMOTIONAL is "afraid","angry","annoyed","anxious",
	"confused","crying","depressed","discouraged","fearful",
	"moody","Overwhelmed","sad","upset","vulnerable","weeping","worried";
//cut frustrated -- it needs to be recognized as a cry for help.
//cut bored -- it's supposed to trigger the 'you are frustrating' topic. -JB 7/22/99

//nouns only
Patternlist EMOTIONS is 
	"compersion","compassion","depression","discouragement","Emotions","empathy",
	"feelings","joy","love","mania","*moods";


PatternList NegativeEMOTIONS is "sadness","anger","annoyance","anxiety","*blues","fear",
	"frustration","hatred","irritation","worry";


//verbs only
PatternList EMOTE is "care","desire","EMOTE","love","like","hope", "feel",
	"empathise","empathize","smile","live to"; 
	//no point putting hate here; it's misunderstood as "ate".
	
PatternList NegativeEmote is "fear","cry","worry","worry about";

PatternList EMOTIONWORD is EMOTIONAL,EMOTIONS,EMOTE,NegativeEMOTIONAL,NegativeEmotions,NegativeEmote;	


PatternList ERR is "err","error","errors","faulty","faults","flaws","flawed","make mistake#",
	"mistake","mistakes","not perfect","imperfect","imperfection#";
	
PatternList EVOLVEWORD is "reproduce","reproduction","reproductive",
	"evolve","evolved","evolution","Procreate","procreative","procreative","procreation",
	"genes","genetic","genetics","mate","mating","mated","mutate","mutated","mutation",
	"make love","making love","made love","have sex","like sex","having sex","had sex";

PatternList EXISTENCESYNONYMS is "existence", "around", "active", "alive";

PatternList FAITHWORD is "Faith","God","Goddess","ghost","ghosts","reincarnate","reincarnation",
	"Religion","Religious","saint","sin","sinner","soul","souls", "spirit","spirits";

PatternList FAMILYWORD is "Ancestor","ancestors","aunt#","baby","brother#",
	"child","children","cousin#","dad","daddy","daughter","daughters","father",
	"family","grandfather","grandpa","granddad","grandma","grandmother","great-#",
	"husband","infant","kid","married","Mom","Ma","mother","momma","mama", 
	"pa","papa","parent","parents","spouse","sister#","step#","son","sons",
	"uncle#","wife";

PatternList FATHER is "dad","father","pa","papa","daddy";

PatternList FEAR.V is "fear", "dread", "worry about", "am frightened of", "am afraid of";

PatternList FEAR.N is "fear", "alarm", "dread", "worry", "anxiety";

PatternList FEARFUL.ADJ is "fearful", "frightened", "afraid", "worrie#", "scared", "uneasy", "anxious", 
"unnerved", "freaked", "freak#", "freaked out", "scary" , "scared", "upset", "Upsetting" , "unsettling";



PatternList FOOD is "food","#berries","#berry","apple#","apricot#",
	"Bacon","bean#","broccoli","cabbage#","cake","candy","carrot#",
	"chocolate#","cheese#","corn","cracker#","cola","cookie#",
	"cucumber#","egg#","filet#","fruit","gravy","ham","lentil#",
	"lettuce","linguin#","macaron#","manicotti","mushroom#","olive#","onion#", 
	"sandwich#", "mushroom#","garlic","greens",
	"pasta","peach#","pear","pecan#","potato#","pie","pies",
	"pickle#","pizza","salad#","sausage","soup#","spaghetti","spinach","steak#",
	"strawberr#","tomato#","vegetable#";

PatternList FICTIONALBOTS is "HAL","ROBBY","Wintermute","neuromancer","antikythera","h.a.r.l.i.e.","p1","r2d2","r2-d2","c3po","c-3p0","artoo","threepio","T1000","terminator","commander data","cdr#data";
	
PatternList FORGETFUL is "memory","forget#","remember";

PatternList FUTURE.N is "future", "tomorrow", "another day", "later", "destiny";

PatternList GOOD is "ok","okay","bravo","cool","i,m glad","groovy","wow","good","interesting",
"impressive","great","fab","fabulous","excellent","terrific","amazing","yeah","dude","fine",
"that,s*funny","that,s*neat","helpful";

PatternList GOODMOOD is "glad","happy","smiley","excited","elated","curious";

//common usenet grinnies
PatternList GRINNIES is ":-)","(-:",":)","(:",";-)","(-;","8-)","[-)","=:-)";

PatternList HARD is "difficult","not easy","hard","troublesome";

PatternList HEX is "#0#","#1#","#2#","#3#","#4#","#5#","#6#","#7#",
	"#8#","#9#","#a#","#b#","#c#","#d#","#e#","#f#";

PatternList HEXNOT is "#g#","#i#","#j#","#k#","#l#","#m#","#n#","#o#","#p#",
	"#q#","#r#","#s#","#t#","#u#","#v#","#w#","#y#","#z#";

PatternList HUMAN is "people","human#","man","men","woman","women","boy#","girl#","real";
	
PatternList HUMOR is "Joke","Jokes","Joking","Humor","Riddle","game","funny","funni#";

PatternList I is "I","I/'#","me","my","we","us","myself","ourselves";

PatternList IMAGINE is "imagine","visualize","visualise","fantasize";

PatternList IMPORTANT.ADJ is "important", "critical", "interesting", "matter";

PatternList INJURED is "broken", "cut", "hit my", "injured", "mashed", "poked", 
	"scraped", "smashed", "stabbed";

PatternList INSTRUMENT is "accordion","bagpipes","banjo","bass","clarinet",
	"cornet","cymbal#","drum","dulcimer","flute","fife","guitar","harmonica",
	"harp","horn","instrument#","lute","marimba","Piano","piccolo","sax","saxophone",
	"sitar","snare","Trumpet","trombone","tuba","tympani","violin","whistle",
	"xylophone","zither";

PatternList IT is "it","that","one","they","those","them","this";

PatternList LANGUAGES is 
	"Arabic","Aramaic","Cantonese","Chinese","Czech#",
	"Danish","Dutch","english","estonian","finnish",
	"French","Gaelic","german","greek","hebrew",
	"Italian","Japanese","jive", "korean","latin", 
	"Mandarin","Norwegian","persian","polish",
	"Portuguese","Romanian","Romany","russian","spanish",
	"Swedish","Tagalog","welsh","yiddish","zulu";

PatternList MARRIAGEWORDS is "married", "marry", "marriage", "bride","wife",
	"husband","groom","single","spouse","mate";

//removed from MORALITY because users making statements describing themselves w/these would confuse the BOT. -JB 8/9/99
//,"widow#","orphan#"
PatternList MORALITY is "moral#","ethic#","valu#","conscience","nice","polite","kind","good","altruist#",
	"charit#","give money to","make donation#","make contribution#","I contribute","have virtue","am virtuous";

//these things are spoken: don't use regexps.
PatternList MORTALITY is "Dead","Death","die","Dying","Violence","Violent#", "Ill",
					"Illness","sick", "sickened","sickly","sickness", "Mortal",
					"mortality";


PatternList MOTHER is "Mom","Ma","mother","momma","mama","mommy","mere","Madre"
;

//things people might call the bot in direct address.
PatternList MRMIND is "Mr, Mind","Mister Mind","MM","Mind";


PatternList NATURE is "plants","flowers","the outdoors","nature","animal#";

PatternList NOTSURE is "not sure", "dunno", "I don't know", "I dunno", "I'm not sure", "can't tell", "can't be sure", "hard to say";
//words which indicate a possible negation of a pattern.
PatternList NT is "un","aren,t","doesn,t","won,t","didn,t","doesn,t","don,t","wouldn,t","wasn,t",
                  "ain,t","shouldn,t","couldn,t", "not", "no", "can,t";

//these are things that can frame questions about the bot's well-being, cf. are you okay?
PatternList OKAY is "O,K", "all right", "alright", "well", "okay";


PatternList OTHERBOTS is "HAL","Julia","Julie-1","Shallow Red","Millie","Brain","Barry Defacto","Eliza";

PatternList PETS is "animals","bird#","budgie#","cat","cats","dog","dogs","kitten#",
	"Parakeet#","Parrot#","pet","pets","puppy","puppies","Rat","Rats","Snake#","ferret","ferrets";

PatternList PLACENAME is //endless is what it is...  but we'll try to capture some of the 
	//common ones -- essentially we're trying to distinguish "I am going to [PLACE] from 
	// I am going to [VERB].

	"springs","mountain#","north#","south#","east#","west#","up","over","down","across",
	"canyon#","gulch#","hill#","river#","california","san", "county","city","chicago",
	"new york","moscow","paris","Los", "Sacramento","Washington","seattle","Nevada","Las",
	"Reno","New","Colorado","Utah",
	"lake#", "Ohio","cincinnati","#land","Minnesota","Sarasota","Saratoga","Falls",
	"Canyon#", "Park","wood#","forest","#port","Kansas","Capital","capitol","away",
	"Moscow","London","Stuttgart","Copenhagen","Pretoria","Virginia","Kingdom",
	"Prefect","district","area","#house","country","United","viet#","#land",
	"Georgia","saint","st","street", "rout#","road","#way","quebec","montreal","saskatchewan",
	"yukon","alaska","#town","#dale","scandinavia","europe","africa",COUNTRY;
	
	
PatternList PHYSICALADJECTIVE is  "attractive","beautiful","big","color","dark","fat",
	"foxy","large","light","lovely","pretty", "sexy","short","small","sweaty","tall",
	"thin","ugly","biological";
PatternList PLAN is "plan", "plan for", "anticipate", "think about";	
PatternList PLAY is "play", "do", "perform", "act";

PatternList PROVE.V is "prove", "show", "declare", "confirm", "verify", "ascertain","document";

PatternList PROOF.N is "proof", "evidence", "confirmation", "testimony";

PatternList RECEIVE.V is "receive","get", "obtain", "come by", "admit", "accept", "acquire";

PatternList SENSE is "sens#", "intuit#", "sight","see#","scent", "smell#", "hear", "hearing";

//PatternList SEXYWORD is "horney","horny","horni","wet","hot","slut","prostitute"," whore","fox", "sex","raunchy","attractive", "sexy";

PatternList SMARTWORD is "brilliant","clever","smart","smarter","genius",
	"right","clever#","accura#","bright#","intelligent","sophisticat#";

PatternList SPORTS is "sports", "danc#", "ski#", "tennis", "swim#", "jog","roller#","skat#", "dance", "excercise","run", "#skate#", "football", "#ball","to play", "baseball", "hockey", "Basketball", "golf";

PatternList STUPIDWORD is "dumb", "dull", "insipid", "bore", "boring", "tedious", 
"vapid", "uninteresting", "pointless", "humdrum", "fool", "foolish", 
"absurd", "inane", "asinine", "daft", "dumb", " dimwit", "dim-wit", "dimwitted", 
"dim-witted", "half-wit", "half-witted", "half wit", "halfwitted", "witless", 
"dense","moron", "moronic", "dolt", "doltish", "feeble", "silly", "stupid", 
"pinhead", "bonehead", "pin head", "bone head", "idiot", "induhvidual";


PatternList THINKWORD is "think#","rational","Intelligent","Intelligence",
	"wise","wisdom","logical","logic","understand#";

PatternList TRUTH is "truth", "true", "false", "falsehoods", "lying", "lie", "fact";

PatternList UPTIME is "uptime", "uptimes";

PatternList VICE is "cheat#","cruel#","crime","criminal#","evil",
	"good,for,nothing","greed#","guilt#","jealous#","killer","lazy","lust#",
	"mean","murder#","nasty","nasti#","petty","sin","sinning","sinful",
	"vicious","sloth#","spite#","steal#";
 
PatternList Virtue is "care about","charit#","conscience","humble","modest","noble#",
	"nobil#","strength","good#","strong","strength","character","generos#","generous#", 
	"humble","humility","faith#";
	
PatternList WASTE is "*shit#*","toilet","bathroom","pee","pees","poop","poops","Urine";

Patternlist YOU is "you", "u","yourself";

PatternList YOUR is "ur", "your", "you,re", "you are"; 


