package parsinglogfiles

import (
	"fmt"
)

func ExampleIsValidLine() {
	fmt.Println(IsValidLine("[ERR] A good error here"))
	fmt.Println(IsValidLine("Any old [ERR] text"))
	fmt.Println(IsValidLine("[BOB] Any old text"))
	// Output:
	// true
	// false
	// false
}

func ExampleSplitLogLine() {
	fmt.Printf("%#v\n", SplitLogLine("section 1<*>section 2<~~~>section 3"))
	// Output:
	// []string{"section 1", "section 2", "section 3"}
}

func ExampleCountQuotedPasswords() {
	lines := []string{
		`[INF] passWord`, // contains 'password' but not surrounded by quotation marks
		`"passWord"`,     // count this one
		`[INF] User saw error message "Unexpected Error" on page load.`,          // does not contain 'password'
		`[INF] The message "Please reset your password" was ignored by the user`, // count this one
	}

	fmt.Println(CountQuotedPasswords(lines))
	// Output:
	// 2
}

func ExampleRemoveEndOfLineText() {
	fmt.Println(RemoveEndOfLineText("[INF] end-of-line23033 Network Failure end-of-line27"))
	// Output:
	// [INF]  Network Failure
}

func ExampleTagWithUserName() {
	result := TagWithUserName([]string{
		"[WRN] User James123 has exceeded storage space.",
		"[WRN] Host down. User   Michelle4 lost connection.",
		"[INF] Users can login again after 23:00.",
		"[DBG] We need to check that user names are at least 6 chars long.",
	})

	fmt.Println("[]string {")
	for _, line := range result {
		fmt.Printf(" %q,\n", line)
	}
	fmt.Println("}")
	// Output:
	// []string {
	//  "[USR] James123 [WRN] User James123 has exceeded storage space.",
	//  "[USR] Michelle4 [WRN] Host down. User   Michelle4 lost connection.",
	//  "[INF] Users can login again after 23:00.",
	//  "[DBG] We need to check that user names are at least 6 chars long.",
	// }
}
