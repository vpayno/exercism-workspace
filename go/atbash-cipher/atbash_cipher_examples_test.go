package atbash

import (
	"fmt"
)

func ExampleAtbash() {
	plain := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	cipher := Atbash(plain)

	fmt.Printf(" plain: %q\ncipher: %q\n", plain, cipher)
	// Output:
	//  plain: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	// cipher: "zyxwv utsrq ponml kjihg fedcb a"
}
