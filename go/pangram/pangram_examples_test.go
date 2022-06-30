package pangram

import (
	"fmt"
)

func ExampleIsPangram() {
	fmt.Println(IsPangram("The quick brown fox jumps over the lazy dog."))
	fmt.Println(IsPangram("abc"))
	// Output:
	// true
	// false
}
