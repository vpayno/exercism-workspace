package etl

import (
	"fmt"
)

func ExampleTransform() {
	legacy := LegacyScore{
		1: {"A", "E"},
		2: {"D", "G"},
	}

	fmt.Printf("%#v\n", Transform(legacy))
	// Output:
	// etl.ModernScore{"a":1, "d":2, "e":1, "g":2}
}
