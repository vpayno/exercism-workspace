<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# atbash

```go
import "atbash"
```

Package atbash implements the atbash ciper.

## Index

- [func Atbash(plain string) string](<#func-atbash>)


## func [Atbash](<https://github.com/vpayno/exercism-workspace/blob/main/go/atbash-cipher/atbash_cipher.go#L15>)

```go
func Atbash(plain string) string
```

Atbash returns a simple substitution cipher text. Ciphertext is written out in groups of fixed length, the traditional group size being 5 letters, leaving numbers unchanged, and punctuation is excluded. This is to make it harder to guess things based on word boundaries. All text will be encoded as lowercase letters.

<details><summary>Example</summary>
<p>

```go
{
	plain := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	cipher := Atbash(plain)

	fmt.Printf(" plain: %q\ncipher: %q\n", plain, cipher)

}
```

#### Output

```
plain: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
cipher: "zyxwv utsrq ponml kjihg fedcb a"
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
