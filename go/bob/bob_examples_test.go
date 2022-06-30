package bob

import "fmt"

func ExampleHey() {
	fmt.Println(Hey("How are you?"))
	fmt.Println(Hey("YELLING!!!"))
	fmt.Println(Hey("YELLING?"))
	fmt.Println(Hey(" "))
	fmt.Println(Hey("Other"))
	// Output:
	// Sure.
	// Whoa, chill out!
	// Calm down, I know what I'm doing!
	// Fine. Be that way!
	// Whatever.
}
