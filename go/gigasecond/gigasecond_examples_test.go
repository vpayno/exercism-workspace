package gigasecond

import (
	"fmt"
	"time"
)

func ExampleAddGigasecond() {
	t := time.Date(2000, time.January, 1, 1, 1, 1, 0, time.UTC)
	fmt.Println(AddGigasecond(t))
	// Output:
	// 2031-09-09 02:47:41 +0000 UTC
}
