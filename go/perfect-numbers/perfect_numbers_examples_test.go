package perfect

import "fmt"

func ExampleClassify() {
	c, _ := Classify(6)
	fmt.Printf("6 : %q\n", c)
	c, _ = Classify(28)
	fmt.Printf("28: %q\n", c)

	c, _ = Classify(12)
	fmt.Printf("12: %q\n", c)
	c, _ = Classify(24)
	fmt.Printf("24: %q\n", c)

	c, _ = Classify(8)
	fmt.Printf("8 : %q\n", c)
	c, _ = Classify(11)
	fmt.Printf("11: %q\n", c)
	// Output:
	// 6 : "perfect"
	// 28: "perfect"
	// 12: "abundant"
	// 24: "abundant"
	// 8 : "deficient"
	// 11: "deficient"
}

func ExampleSum() {
	numbers := []int64{1, 10, 100, 1_000, 10_000}
	sum := Sum(numbers)

	fmt.Printf("numbers: %#v\n    sum: %d\n", numbers, sum)
	// Output:
	// numbers: []int64{1, 10, 100, 1000, 10000}
	//     sum: 11111
}

func ExampleFactors() {
	var number int64 = 64
	factors := Factors(number)
	fmt.Printf(" number: %d\nfactors: %#v\n", number, factors)

	number = 123
	factors = Factors(number)
	fmt.Printf(" number: %d\nfactors: %#v\n", number, factors)
	// Output:
	//  number: 64
	// factors: []int64{1, 2, 4, 8, 16, 32}
	//  number: 123
	// factors: []int64{1, 3, 41}
}
