package meetup

import (
	"fmt"
	"time"
)

/*
        July 2022
   Su Mo Tu We Th Fr Sa
                   1  2
    3  4  5  6  7  8  9
   10 11 12 13 14 15 16
   17 18 19 20 21 22 23
   24 25 26 27 28 29 30
   31
*/

func ExampleDay() {
	fmt.Println(Day(First, time.Monday, time.July, 2022))
	fmt.Println(Day(Second, time.Tuesday, time.July, 2022))
	fmt.Println(Day(Third, time.Wednesday, time.July, 2022))
	fmt.Println(Day(Fourth, time.Thursday, time.July, 2022))
	fmt.Println(Day(Teenth, time.Friday, time.July, 2022))
	fmt.Println(Day(Last, time.Saturday, time.July, 2022))
	fmt.Println(Day(First, time.Friday, time.July, 2022))
	// Output:
	// 4
	// 12
	// 20
	// 28
	// 15
	// 30
	// 1
}
