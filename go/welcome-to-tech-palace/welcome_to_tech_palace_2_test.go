package techpalace

import (
	"fmt"
)

func ExampleWelcomeMessage() {
	fmt.Println(WelcomeMessage("Judy"))
	// Output:
	// Welcome to the Tech Palace, JUDY
}

func ExampleAddBorder() {
	fmt.Println(AddBorder("Welcome!", 10))
	// Output:
	// **********
	// Welcome!
	// **********
}

func ExampleCleanupMessage() {
	var message string = `
	**************************
	*    BUY NOW, SAVE 10%   *
	**************************
	`

	fmt.Println(CleanupMessage(message))
	// Output:
	// BUY NOW, SAVE 10%
}
