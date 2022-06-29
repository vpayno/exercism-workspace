<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# twofer

```go
import "twofer"
```

Package twofer for https://exercism.org/tracks/go/exercises/two-fer

## Index

- [func ShareWith(name string) string](<#func-sharewith>)


## func [ShareWith](<https://github.com/vpayno/exercism-workspace/blob/main/go/two-fer/two_fer.go#L9>)

```go
func ShareWith(name string) string
```

ShareWith returns a string with the sharing instructions\.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(ShareWith("Alice"))
	fmt.Println(ShareWith(""))
	fmt.Println(ShareWith("Bob"))

}
```

#### Output

```
One for Alice, one for me.
One for you, one for me.
One for Bob, one for me.
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)