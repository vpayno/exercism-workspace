package hamming

import (
	"fmt"
)

func Example_isValidDNASequence() {
	fmt.Println(isValidDNASequence("ABCCAGTDEF"))
	fmt.Println(isValidDNASequence("GGACTGAAATCTG"))
	// Output:
	// false <nil>
	// true <nil>
}

func ExampleDistance() {
	fmt.Println(Distance("ABCD", "ABCD"))
	fmt.Println(Distance("ABCD", "CAGT"))
	fmt.Println(Distance("CAGT", "ABCD"))
	fmt.Println(Distance("GGACT", "GGACTGAA"))
	fmt.Println(Distance("GGACTGAAATCTG", "GGACTGAAATCTG"))
	fmt.Println(Distance("GGACGGATTCTG", "AGGACGGATTCT"))
	// Output:
	// 0 sequence a isn't valid
	// 0 sequence a isn't valid
	// 0 sequence b isn't valid
	// 0 strings need to be of equal length
	// 0 <nil>
	// 9 <nil>
}
