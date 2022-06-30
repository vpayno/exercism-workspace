package isbn

import (
	"fmt"
)

func ExampleIsValidISBN() {
	fmt.Println(IsValidISBN("3-598-21508-8"))
	fmt.Println(IsValidISBN("3-598-21508-9"))
	fmt.Println(IsValidISBN("3-598-21507-X"))
	// Output:
	// true
	// false
	// true
}
