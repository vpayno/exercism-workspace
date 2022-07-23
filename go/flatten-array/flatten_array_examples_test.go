package flatten

import "fmt"

func ExampleFlatten() {
	input := []interface{}{1, []interface{}{2, 3, 4, 5, interface{}(nil), 6, 7}, 8, interface{}(nil)}
	fmt.Printf("%#v\n", Flatten(input))
	// Output:
	// []interface {}{1, 2, 3, 4, 5, 6, 7, 8}
}
