package space

import (
	"fmt"
)

func ExampleAge() {
	age := Age(1_000_000_000, "Earth")

	fmt.Printf("%.2f Earth-years old\n", age)
	// Output:
	// 31.69 Earth-years old
}
