package blackjack

import (
	"fmt"
)

func ExampleParseCard() {
	fmt.Println(ParseCard("ace"))
	// Output: 11
}

func ExampleFirstTurn() {
	fmt.Println(FirstTurn("ace", "ace", "jack"))
	fmt.Println(FirstTurn("ace", "king", "ace"))
	fmt.Println(FirstTurn("five", "queen", "ace"))
	// Output:
	// P
	// S
	// H
}
