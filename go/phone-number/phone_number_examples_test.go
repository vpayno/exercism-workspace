package phonenumber

import (
	"fmt"
)

func ExampleNumber() {
	fmt.Println(Number("+1 (613)-995-0253"))
	fmt.Println(Number("613-995-0253"))
	fmt.Println(Number("1 613 995 0253"))
	fmt.Println(Number("613.995.0253"))
	// Output:
	// 6139950253 <nil>
	// 6139950253 <nil>
	// 6139950253 <nil>
	// 6139950253 <nil>
}

func ExampleAreaCode() {
	fmt.Println(AreaCode("+1 (613)-995-0253"))
	fmt.Println(AreaCode("613-995-0253"))
	fmt.Println(AreaCode("1 613 995 0253"))
	fmt.Println(AreaCode("613.995.0253"))
	// Output:
	// 613 <nil>
	// 613 <nil>
	// 613 <nil>
	// 613 <nil>
}

func ExampleFormat() {
	fmt.Println(Format("+1 (613)-995-0253"))
	fmt.Println(Format("613-995-0253"))
	fmt.Println(Format("1 613 995 0253"))
	fmt.Println(Format("613.995.0253"))
	// Output:
	// (613) 995-0253 <nil>
	// (613) 995-0253 <nil>
	// (613) 995-0253 <nil>
	// (613) 995-0253 <nil>
}
