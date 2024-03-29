<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# cipher

```go
import "cipher"
```

Package cipher is comprised of multiple cipher implementations.

<details><summary>Example (Ceasar Cipher)</summary>
<p>

```go
{
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

}
```

#### Output

```
plain: "A.B.C;defuvw:X,Y,Z,"
encoded: "defghixyzabc"
decoded: "abcdefuvwxyz"
  plain: "abcxyz"
encoded: "defabc"
decoded: "abcxyz"
```

</p>
</details>

<details><summary>Example (Fix Key)</summary>
<p>

```go
{
	oldKey := "1234567890"
	newKey := fixKey(oldKey, 20)

	fmt.Printf("oldKey: %q\nnewKey: %q\n", oldKey, newKey)

}
```

#### Output

```
oldKey: "1234567890"
newKey: "12345678901234567890"
```

</p>
</details>

<details><summary>Example (Normalize Text)</summary>
<p>

```go
{
	data := []string{
		".9K3,7.asEi:js9;70-1+34-aSf_78As=98p2;'./,]p[8rT[7}aR67>uio<2G4",
		"12 34",
	}

	for _, input := range data {
		output := normalize(input)
		fmt.Printf(" input: %q\noutput: %q\n", input, output)
	}

}
```

#### Output

```
input: ".9K3,7.asEi:js9;70-1+34-aSf_78As=98p2;'./,]p[8rT[7}aR67>uio<2G4"
output: "kaseijsasfaspprtaruiog"
 input: "12 34"
output: ""
```

</p>
</details>

<details><summary>Example (Shift Cipher)</summary>
<p>

```go
{
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

}
```

#### Output

```
plain: "A.B.C;defuvw:X,Y,Z,"
encoded: "defghixyzabc"
decoded: "abcdefuvwxyz"
  plain: "abcxyz"
encoded: "defabc"
decoded: "abcxyz"
```

</p>
</details>

<details><summary>Example (Vigenere Cipher)</summary>
<p>

```go
{
	data := [][]string{
		{"abcdefghijklmnopqrstuvwxyz", "aaaaaaaaaaaaaaaaaaaaaaaaaa"},
	}
	for _, entry := range data {
		key := entry[0]
		plain := entry[1]

		vigenere := NewVigenere(key)
		encoded := vigenere.Encode(plain)
		decoded := vigenere.Decode(encoded)
		fmt.Printf(
			"     key: %q\n  plain: %q\nencoded: %q\ndecoded: %#v\n",
			key,
			plain,
			encoded,
			decoded,
		)
	}

}
```

#### Output

```
key: "abcdefghijklmnopqrstuvwxyz"
  plain: "aaaaaaaaaaaaaaaaaaaaaaaaaa"
encoded: "abcdefghijklmnopqrstuvwxyz"
decoded: "aaaaaaaaaaaaaaaaaaaaaaaaaa"
```

</p>
</details>

## Index

- [type Cipher](<#type-cipher>)
  - [func NewCaesar() Cipher](<#func-newcaesar>)
  - [func NewShift(distance int) Cipher](<#func-newshift>)
  - [func NewVigenere(key string) Cipher](<#func-newvigenere>)


## type [Cipher](<https://github.com/vpayno/exercism-workspace/blob/main/go/simple-cipher/cipher.go#L4-L7>)

The Cipher interface describes the Encode\(\) and Decode\(\) functions.

```go
type Cipher interface {
    Encode(string) string
    Decode(string) string
}
```

### func [NewCaesar](<https://github.com/vpayno/exercism-workspace/blob/main/go/simple-cipher/simple_cipher.go#L18>)

```go
func NewCaesar() Cipher
```

NewCaesar returns a Cipher.

### func [NewShift](<https://github.com/vpayno/exercism-workspace/blob/main/go/simple-cipher/simple_cipher.go#L27>)

```go
func NewShift(distance int) Cipher
```

NewShift returns a Cipher.

### func [NewVigenere](<https://github.com/vpayno/exercism-workspace/blob/main/go/simple-cipher/simple_cipher.go#L94>)

```go
func NewVigenere(key string) Cipher
```

NewVigenere returns a Cipher.



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
