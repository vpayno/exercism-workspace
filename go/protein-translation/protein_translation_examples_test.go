package protein

import (
	"fmt"
)

func ExampleFromRNA() {
	fmt.Println(FromRNA("UGGUGUUAUUAAUGGUUU"))
	// Output:
	// [Tryptophan Cysteine Tyrosine] <nil>
}

func ExampleFromCodon() {
	fmt.Println(FromCodon("AUG"))
	// Output:
	// Methionine <nil>
}
