package cryptosquare

import "fmt"

func ExampleNormalizeText() {
	data := []string{
		".9K3,7.asEi:js9;70-1+34-aSf_78As=98p2;'./,]p[8rT[7}aR67>uio<2G4",
		"1234",
	}

	for _, input := range data {
		output := NormalizeText(input)
		fmt.Printf(" input: %q\noutput: %q\n", input, output)
	}
	// Output:
	//  input: ".9K3,7.asEi:js9;70-1+34-aSf_78As=98p2;'./,]p[8rT[7}aR67>uio<2G4"
	// output: "9k37aseijs970134asf78as98p2p8rt7ar67uio2g4"
	//  input: "1234"
	// output: "1234"
}

func ExampleGetSquareDimmensions() {
	data := []string{
		"ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots",
		"1234",
	}

	for _, text := range data {
		row, col := GetSquareDimmensions(text)
		fmt.Printf("text: %q\n row: %d\n col: %d\n", text, row, col)
	}
	// Output:
	// text: "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots"
	//  row: 7
	//  col: 8
	// text: "1234"
	//  row: 2
	//  col: 2
}

func ExampleGetTokens() {
	data := []string{
		"ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots",
		"1234",
	}

	for _, text := range data {
		tokens := GetTokens(text)
		fmt.Printf("text: %q\n", text)
		fmt.Printf("%#v\n", tokens)
	}
	// Output:
	// text: "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots"
	// []string{"ifmanwas", "meanttos", "tayonthe", "groundgo", "dwouldha", "vegivenu", "sroots  "}
	// text: "1234"
	// []string{"12", "34"}
}

func ExampleEncodeTokens() {
	data := [][]string{
		[]string{"ifmanwas", "meanttos", "tayonthe", "groundgo", "dwouldha", "vegivenu", "sroots  "},
		[]string{"12", "34"},
	}

	for _, plain := range data {
		cipher := EncodeTokens(plain)

		fmt.Printf(" plain: %#v\n", plain)
		fmt.Printf("cipher: %#v\n", cipher)
	}
	// Output:
	//  plain: []string{"ifmanwas", "meanttos", "tayonthe", "groundgo", "dwouldha", "vegivenu", "sroots  "}
	// cipher: []string{"imtgdvs", "fearwer", "mayoogo", "anouuio", "ntnnlvt", "wttddes", "aohghn ", "sseoau "}
	//  plain: []string{"12", "34"}
	// cipher: []string{"13", "24"}
}

func ExampleEncode() {
	plain := "If man was meant to stay on the ground, god would have given us roots."
	cipher := Encode(plain)
	fmt.Printf(" plain: %q\ncipher: %#v\n", plain, cipher)
	// Output:
	//  plain: "If man was meant to stay on the ground, god would have given us roots."
	// cipher: "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
}
