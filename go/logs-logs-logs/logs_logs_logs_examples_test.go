package logs

import (
	"fmt"
)

func ExampleApplication() {
	fmt.Println(Application("β recommended recommendation product π"))
	fmt.Println(Application("β recommended product"))
	fmt.Println(Application("π recommended search product"))
	fmt.Println(Application("β recommended weather product"))
	// Output:
	// recommendation
	// recommendation
	// search
	// weather
}

func ExampleReplace() {
	log := "please replace 'π' with 'π'"

	fmt.Println(Replace(log, 'π', 'π'))
	// Output:
	// please replace 'π' with 'π'
}

func ExampleWithinLimit() {
	fmt.Println(WithinLimit("helloβ", 6))
	// Output:
	// true
}
