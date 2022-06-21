package booking

// Time makes it difficult to write example code/output that doesn't need updating.

import (
	"fmt"
)

func ExampleSchedule() {
	fmt.Println(Schedule("7/25/2019 13:45:00"))
	// Output:
	// 2019-07-25 13:45:00 +0000 UTC
}

func ExampleHasPassed() {
	fmt.Println(HasPassed("July 25, 2019 13:45:00"))
	fmt.Println(HasPassed("December 9, 2112 11:59:59"))
	// Output:
	// true
	// false
}

func ExampleIsAfternoonAppointment() {
	fmt.Println(IsAfternoonAppointment("Thursday, July 25, 2019 11:30:00"))
	fmt.Println(IsAfternoonAppointment("Thursday, July 25, 2019 13:45:00"))
	fmt.Println(IsAfternoonAppointment("Thursday, July 25, 2019 21:15:00"))
	// Output:
	// false
	// true
	// false
}

func ExampleDescription() {
	fmt.Println(Description("7/25/2019 13:45:00"))
	fmt.Println(Description("6/6/2005 10:30:00"))
	fmt.Println(Description("9/19/1994 12:15:00"))
	fmt.Println(Description("4/4/2012 16:45:00"))
	// Output:
	// You have an appointment on Thursday, July 25, 2019, at 13:45.
	// You have an appointment on Monday, June 6, 2005, at 10:30.
	// You have an appointment on Monday, September 19, 1994, at 12:15.
	// You have an appointment on Wednesday, April 4, 2012, at 16:45.
}

func ExampleAnniversaryDate() {
	fmt.Println(AnniversaryDate())
	// Output:
	// 2022-09-15 00:00:00 +0000 UTC
}
