<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# anagram

```go
import "anagram"
```

Package anagram is a rearrangement of letters to form a new word.

## Index

- [func Detect(subject string, candidates []string) []string](<#func-detect>)


## func [Detect](<https://github.com/vpayno/exercism-workspace/blob/main/go/anagram/anagram.go#L10>)

```go
func Detect(subject string, candidates []string) []string
```

Detect returns a string slice anagram of the passed string.

<details><summary>Example</summary>
<p>

```go
{
	candidates := []string{"enlists", "google", "inlets", "banana"}

	fmt.Printf("%#v", Detect("listen", candidates))

}
```

#### Output

```
[]string{"inlets"}
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
