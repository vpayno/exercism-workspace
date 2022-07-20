package lsproduct

import (
	"fmt"
)

func ExampleLargestSeriesProduct() {
	s := "0123456789"
	l := 3
	r, e := LargestSeriesProduct(s, l)
	fmt.Printf("%q:%d -> %d:%v\n", s, l, r, e)
	// Output:
	// "0123456789":3 -> 504:<nil>
}
