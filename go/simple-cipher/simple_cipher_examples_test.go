package cipher

import "fmt"

func ExampleNormalizeText() {
	data := []string{
		".9K3,7.asEi:js9;70-1+34-aSf_78As=98p2;'./,]p[8rT[7}aR67>uio<2G4",
		"12 34",
	}

	for _, input := range data {
		output := normalize(input)
		fmt.Printf(" input: %q\noutput: %q\n", input, output)
	}
	// Output:
	//  input: ".9K3,7.asEi:js9;70-1+34-aSf_78As=98p2;'./,]p[8rT[7}aR67>uio<2G4"
	// output: "kaseijsasfaspprtaruiog"
	//  input: "12 34"
	// output: ""
}

func ExampleFixKey() {
	oldKey := "1234567890"
	newKey := fixKey(oldKey, 20)

	fmt.Printf("oldKey: %q\nnewKey: %q\n", oldKey, newKey)
	// Output:
	// oldKey: "1234567890"
	// newKey: "12345678901234567890"
}

func ExampleCeasarCipher() {
	data := []string{
		"A.B.C;defuvw:X,Y,Z,",
		"abcxyz",
	}
	for _, plain := range data {
		caesar := NewCaesar()
		encoded := caesar.Encode(plain)
		decoded := caesar.Decode(encoded)
		fmt.Printf("  plain: %q\nencoded: %q\ndecoded: %#v\n", plain, encoded, decoded)
	}
	// Output:
	//   plain: "A.B.C;defuvw:X,Y,Z,"
	// encoded: "defghixyzabc"
	// decoded: "abcdefuvwxyz"
	//   plain: "abcxyz"
	// encoded: "defabc"
	// decoded: "abcxyz"
}

func ExampleShiftCipher() {
	data := []string{
		"A.B.C;defuvw:X,Y,Z,",
		"abcxyz",
	}
	for _, plain := range data {
		shift := NewShift(3)
		encoded := shift.Encode(plain)
		decoded := shift.Decode(encoded)
		fmt.Printf("  plain: %q\nencoded: %q\ndecoded: %#v\n", plain, encoded, decoded)
	}
	// Output:
	//   plain: "A.B.C;defuvw:X,Y,Z,"
	// encoded: "defghixyzabc"
	// decoded: "abcdefuvwxyz"
	//   plain: "abcxyz"
	// encoded: "defabc"
	// decoded: "abcxyz"
}

func ExampleVigenereCipher() {
	data := [][]string{
		[]string{"abcdefghijklmnopqrstuvwxyz", "aaaaaaaaaaaaaaaaaaaaaaaaaa"},
	}
	for _, entry := range data {
		key := entry[0]
		plain := entry[1]

		vigenere := NewVigenere(key)
		encoded := vigenere.Encode(plain)
		decoded := vigenere.Decode(encoded)
		fmt.Printf("     key: %q\n  plain: %q\nencoded: %q\ndecoded: %#v\n", key, plain, encoded, decoded)
	}
	// Output:
	//     key: "abcdefghijklmnopqrstuvwxyz"
	//   plain: "aaaaaaaaaaaaaaaaaaaaaaaaaa"
	// encoded: "abcdefghijklmnopqrstuvwxyz"
	// decoded: "aaaaaaaaaaaaaaaaaaaaaaaaaa"
}
