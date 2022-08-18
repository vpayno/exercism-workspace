package rotationalcipher

import (
	"fmt"
)

func ExampleRotationalCipher() {
	plain := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	shift := 3
	cipher := RotationalCipher(plain, shift)
	fmt.Printf(" shift: %d\n plain: %q\ncipher: %q\n", shift, plain, cipher)
	// Output:
	//  shift: 3
	//  plain: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	// cipher: "DEFGHIJKLMNOPQRSTUVWXYZABC"
}
