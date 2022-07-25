package strand

import (
	"fmt"
	"testing"
)

func ExampleToRNA() {
	var validDNA string = "GCTA"

	fmt.Println(ToRNA(validDNA))
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
