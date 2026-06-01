
// Lexical increment and lexical decrement capable of counting up and down 
// to/from 2000.  It's perfectly obvious how to make it count to any 
// finite number... 

// Please don't make me implement multiplication and division routines this way....
//							Ray D. 

// To use these, you just set the variable ?score to whatever, switchto them, 
// and when they switchback you set whatever to the new value of ?score.

Sequence topic "raisescore" is 
    //counts up -- to a thousand if need be
Always 

	If ?Score matches "9" then Remember ?Score is "10"; Continue
	Otherwise if ?Score matches "99" then Remember ?Score is "100"; continue
	Otherwise if ?Score matches "999" then Remember ?Score is "1000"; continue

	Otherwise If ?Score matches "#8" then Remember ?Score is #1+"9"; Continue
	Otherwise If ?Score matches "#7" then Remember ?Score is #1+"8"; Continue
	Otherwise If ?Score matches "#6" then Remember ?Score is #1+"7"; Continue
	Otherwise If ?Score matches "#5" then Remember ?Score is #1+"6"; Continue
	Otherwise If ?Score matches "#4" then Remember ?Score is #1+"5"; Continue
	Otherwise If ?Score matches "#3" then Remember ?Score is #1+"4"; Continue
	Otherwise If ?Score matches "#2" then Remember ?Score is #1+"3"; Continue
	Otherwise If ?Score matches "#1" then Remember ?Score is #1+"2"; Continue
	Otherwise If ?Score matches "#0" then Remember ?Score is #1+"1"; Continue

	Otherwise If ?Score matches "#89" then Remember ?Score is #1+"90"; Continue
	Otherwise If ?Score matches "#79" then Remember ?Score is #1+"80"; Continue
	Otherwise If ?Score matches "#69" then Remember ?Score is #1+"70"; Continue
	Otherwise If ?Score matches "#59" then Remember ?Score is #1+"60"; Continue
	Otherwise If ?Score matches "#49" then Remember ?Score is #1+"50"; Continue
	Otherwise If ?Score matches "#39" then Remember ?Score is #1+"40"; Continue
	Otherwise If ?Score matches "#29" then Remember ?Score is #1+"30"; Continue
	Otherwise If ?Score matches "#19" then Remember ?Score is #1+"20"; Continue
	Otherwise If ?Score matches "#09" then Remember ?Score is #1+"10"; Continue

	Otherwise If ?Score matches "#899" then Remember ?Score is #1+"900"; Continue
	Otherwise If ?Score matches "#799" then Remember ?Score is #1+"800"; Continue
	Otherwise If ?Score matches "#699" then Remember ?Score is #1+"700"; Continue
	Otherwise If ?Score matches "#599" then Remember ?Score is #1+"600"; Continue
	Otherwise If ?Score matches "#499" then Remember ?Score is #1+"500"; Continue
	Otherwise If ?Score matches "#399" then Remember ?Score is #1+"400"; Continue
	Otherwise If ?Score matches "#299" then Remember ?Score is #1+"300"; Continue
	Otherwise If ?Score matches "#199" then Remember ?Score is #1+"200"; Continue
	Otherwise If ?Score matches "#099" then Remember ?Score is #1+"100"; Continue

	SwitchBack
EndTopic


Sequence topic "lowerscore" is 
    //counts to a thousand.
Always 
	If ?Score matches "1000" then Remember ?Score is "999"; Continue
	Otherwise If ?Score matches "100" then Remember ?Score is "99"; Continue
	Otherwise If ?Score matches "10" then Remember ?Score is "9"; Continue

	Otherwise If ?Score matches "#9" then Remember ?Score is #1+"8"; Continue
	Otherwise If ?Score matches "#8" then Remember ?Score is #1+"7"; Continue
	Otherwise If ?Score matches "#7" then Remember ?Score is #1+"6"; Continue
	Otherwise If ?Score matches "#6" then Remember ?Score is #1+"5"; Continue
	Otherwise If ?Score matches "#5" then Remember ?Score is #1+"4"; Continue
	Otherwise If ?Score matches "#4" then Remember ?Score is #1+"3"; Continue
	Otherwise If ?Score matches "#3" then Remember ?Score is #1+"2"; Continue
	Otherwise If ?Score matches "#2" then Remember ?Score is #1+"1"; Continue
	Otherwise If ?Score matches "#1" then Remember ?Score is #1+"0"; Continue

	Otherwise If ?Score matches "#90" then Remember ?Score is #1+"89"; Continue
	Otherwise If ?Score matches "#80" then Remember ?Score is #1+"79"; Continue
	Otherwise If ?Score matches "#70" then Remember ?Score is #1+"69"; Continue
	Otherwise If ?Score matches "#60" then Remember ?Score is #1+"59"; Continue
	Otherwise If ?Score matches "#50" then Remember ?Score is #1+"49"; Continue
	Otherwise If ?Score matches "#40" then Remember ?Score is #1+"39"; Continue
	Otherwise If ?Score matches "#30" then Remember ?Score is #1+"29"; Continue
	Otherwise If ?Score matches "#20" then Remember ?Score is #1+"19"; Continue
	Otherwise If ?Score matches "#10" then Remember ?Score is #1+"09"; Continue
	
	Otherwise If ?Score matches "#900" then Remember ?Score is #1+"899"; Continue
	Otherwise If ?Score matches "#800" then Remember ?Score is #1+"799"; Continue
	Otherwise If ?Score matches "#700" then Remember ?Score is #1+"699"; Continue
	Otherwise If ?Score matches "#600" then Remember ?Score is #1+"599"; Continue
	Otherwise If ?Score matches "#500" then Remember ?Score is #1+"499"; Continue
	Otherwise If ?Score matches "#400" then Remember ?Score is #1+"399"; Continue
	Otherwise If ?Score matches "#300" then Remember ?Score is #1+"299"; Continue
	Otherwise If ?Score matches "#200" then Remember ?Score is #1+"199"; Continue
	Otherwise If ?Score matches "#100" then Remember ?Score is #1+"099"; Continue


	SwitchBack
EndTopic

