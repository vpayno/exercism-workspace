package grains

import (
	"fmt"
)

func ExampleSquare() {
	fmt.Println(Square(0))
	fmt.Println(Square(1))
	fmt.Println(Square(2))
	fmt.Println(Square(64))
	// Output:
	// 0 [0] is not a valid square id on our chess board
	// 1 <nil>
	// 2 <nil>
	// 9223372036854775808 <nil>
}

func ExampleTotal() {
	fmt.Println(Total())
	// Output:
	// 18446744073709551615
}
