package sorting

import (
	"fmt"
)

func ExampleDescribeNumber() {
	fmt.Println(DescribeNumber(-12.345))
	// Output:
	// This is the number -12.3
}

type exampleNumberBox struct {
	n int
}

func (nb exampleNumberBox) Number() int {
	return nb.n
}

func ExampleDescribeNumberBox() {
	nb := exampleNumberBox{12}

	fmt.Println(DescribeNumberBox(nb))
	// Output:
	// This is a box containing the number 12.0
}

func ExampleExtractFancyNumber() {
	fnb := FancyNumber{"12"}

	fmt.Println(ExtractFancyNumber(fnb))
	// Output:
	// 12
}

func ExampleDescribeFancyNumberBox() {
	fnb := FancyNumber{"12"}

	fmt.Println(DescribeFancyNumberBox(fnb))
	// Output:
	// This is a fancy box containing the number 12.0
}

func ExampleDescribeAnything() {
	fnb := FancyNumber{"12"}

	fmt.Println(DescribeAnything(fnb))
	// Output:
	// This is a fancy box containing the number 12.0
}
