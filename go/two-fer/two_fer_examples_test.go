package twofer

import (
	"fmt"
)

func ExampleShareWith() {
	fmt.Println(ShareWith("Alice"))
	fmt.Println(ShareWith(""))
	fmt.Println(ShareWith("Bob"))
	// Output:
	// One for Alice, one for me.
	// One for you, one for me.
	// One for Bob, one for me.
}
