package luhn

import (
	"fmt"
)

func ExampleValid() {
	fmt.Println(Valid("4539 3195 0343 6467"))
	fmt.Println(Valid("8273 1232 7352 0569"))
	fmt.Println(Valid("059"))
	fmt.Println(Valid("59"))
	// Output:
	// true
	// false
	// true
	// true
}
