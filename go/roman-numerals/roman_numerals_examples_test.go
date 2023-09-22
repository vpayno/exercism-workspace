package romannumerals

import "fmt"

func ExampleToRomanNumeral() {
	numbers := []int{
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
		50, 51, 100, 101,
		500, 501, 1_000, 1_001,
		3_000, 3_001, 4_001,
	}

	for _, n := range numbers {
		v, e := ToRomanNumeral(n)
		fmt.Printf("%d -> %q, e: %v\n", n, v, e)
	}

	// Output:
	// 0 -> "", e: Roman numerals can't be less than or equal to 0
	// 1 -> "I", e: <nil>
	// 2 -> "II", e: <nil>
	// 3 -> "III", e: <nil>
	// 4 -> "IV", e: <nil>
	// 5 -> "V", e: <nil>
	// 6 -> "VI", e: <nil>
	// 7 -> "VII", e: <nil>
	// 8 -> "VIII", e: <nil>
	// 9 -> "IX", e: <nil>
	// 10 -> "X", e: <nil>
	// 11 -> "XI", e: <nil>
	// 50 -> "L", e: <nil>
	// 51 -> "LI", e: <nil>
	// 100 -> "C", e: <nil>
	// 101 -> "CI", e: <nil>
	// 500 -> "D", e: <nil>
	// 501 -> "DI", e: <nil>
	// 1000 -> "M", e: <nil>
	// 1001 -> "MI", e: <nil>
	// 3000 -> "MMM", e: <nil>
	// 3001 -> "MMMI", e: <nil>
	// 4001 -> "", e: Roman numerals were apparently rarely greater than 3k
}
