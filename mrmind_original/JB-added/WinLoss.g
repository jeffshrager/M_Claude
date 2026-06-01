Topic "Win/lose" is
Subjects "Win/lose";

	If ?FactStatement contains (("I","you") + ("won","win"), ("I","you") + ("beat","defeated") + ("you","me"), ("I","you")+("lose","lost","fail")) or
	?FactQuestion contains (("I","you") + ("won","win"), ("I","you") + ("beat","defeated") + ("you","me"), ("I","you")+("lose","lost","fail"))
	
	Then
		Example "I beat you";
		Say "It's not whether you win or lose; it's how you play the game.";
	Done
EndTopic

OtherExamples of "I beat you" are
	"You lose";
