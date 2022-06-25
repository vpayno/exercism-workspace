package letter

import (
	"fmt"
)

func ExampleFrequency() {
	fmt.Println(Frequency("abcbccbd"))
	// Output:
	// map[97:1 98:3 99:3 100:1]
}

func ExampleConcurrentFrequency() {
	fmt.Println(ConcurrentFrequency([]string{"abcbccbd"}))
	// Output:
	// map[97:1 98:3 99:3 100:1]
}
