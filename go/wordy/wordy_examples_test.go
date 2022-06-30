package wordy

import (
	"fmt"
)

func ExampleAnswer() {
	fmt.Println(Answer("What is 5?"))
	fmt.Println(Answer("What is 5 plus 3?"))
	fmt.Println(Answer("What is 5 minus 3?"))
	fmt.Println(Answer("What is 5 multiplied by 3?"))
	fmt.Println(Answer("What is 5 divided by 3?"))
	fmt.Println(Answer("What is 5 raised to the 3rd power?"))
	// Output:
	// 5 true
	// 8 true
	// 2 true
	// 15 true
	// 1 true
	// 125 true
}
