package strand

import (
	"fmt"
	"testing"
)

func ExampleToRNA() {
	var validDNA DNA = DNA("GCTA")

	fmt.Println(ToRNA(validDNA.String()))
	// Output:
	// CGAU
}

func TestPanic(t *testing.T) {
	var invalidDNA string = "GCXTA"

	defer func() {
		if r := recover(); r == nil {
			t.Errorf("The code did not panic")
		}
	}()

	ToRNA(invalidDNA)
}
