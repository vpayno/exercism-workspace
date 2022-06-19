package logs

import (
	"fmt"
)

func ExampleApplication() {
	fmt.Println(Application("❗ recommended recommendation product 🔍"))
	fmt.Println(Application("❗ recommended product"))
	fmt.Println(Application("🔍 recommended search product"))
	fmt.Println(Application("☀ recommended weather product"))
	// Output:
	// recommendation
	// recommendation
	// search
	// weather
}

func ExampleReplace() {
	log := "please replace '👎' with '👍'"

	fmt.Println(Replace(log, '👎', '👍'))
	// Output:
	// please replace '👍' with '👍'
}

func ExampleWithinLimit() {
	fmt.Println(WithinLimit("hello❗", 6))
	// Output:
	// true
}
