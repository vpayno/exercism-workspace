package proverb

import (
	"fmt"
)

func ExampleProverb() {
	words := []string{"nail", "shoe", "horse", "rider", "message", "battle", "kingdom"}

	for _, line := range Proverb(words) {
		fmt.Println(line)
	}
	// Output:
	// For want of a nail the shoe was lost.
	// For want of a shoe the horse was lost.
	// For want of a horse the rider was lost.
	// For want of a rider the message was lost.
	// For want of a message the battle was lost.
	// For want of a battle the kingdom was lost.
	// And all for the want of a nail.
}
