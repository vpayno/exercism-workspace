package triangle

import (
	"fmt"
)

func ExampleHelloWorld() {
	fmt.Println(KindFromSides(0, 1, 2))
	fmt.Println(KindFromSides(3, 3, 3))
	fmt.Println(KindFromSides(1, 3, 3))
	fmt.Println(KindFromSides(1, 2, 3))
	// Output:
	// 0
	// 1
	// 2
	// 3
}
