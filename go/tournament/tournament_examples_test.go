package tournament

import (
	"bytes"
	"strings"
)

var input string = `
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Courageous Californians;draw
Devastating Donkeys;Allegoric Alaskans;win
Courageous Californians;Blithering Badgers;loss
Blithering Badgers;Devastating Donkeys;loss
Allegoric Alaskans;Courageous Californians;win
`[1:] // [1:] = strip initial readability newline

func ExampleTally() {
	debug = true

	reader := strings.NewReader(input)
	var buffer bytes.Buffer

	Tally(reader, &buffer)
	// Output:
	// Team                           | MP |  W |  D |  L |  P
	// Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
	// Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
	// Blithering Badgers             |  3 |  1 |  0 |  2 |  3
	// Courageous Californians        |  3 |  0 |  1 |  2 |  1
}
