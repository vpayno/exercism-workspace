package wordcount

import (
	"fmt"
)

func ExampleWordCount() {
	fmt.Printf("%#v\n", WordCount("one two three"))
	// Output:
	// wordcount.Frequency{"one":1, "three":1, "two":1}
}
