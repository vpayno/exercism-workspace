package anagram

import (
	"fmt"
)

func ExampleDetect() {
	candidates := []string{"enlists", "google", "inlets", "banana"}

	fmt.Printf("%#v", Detect("listen", candidates))
	// Output:
	// []string{"inlets"}
}
