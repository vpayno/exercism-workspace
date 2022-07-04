package series

import (
	"fmt"
)

func ExampleAll() {
	fmt.Println(All(3, "49142"))
	// Output:
	// [491 914 142]
}

func ExampleUnsafeFirst() {
	fmt.Println(UnsafeFirst(3, "49142"))
	// Output:
	// 491
}
