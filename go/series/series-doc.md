<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# series

```go
import "series"
```

Package series returns contiguous substrings from a string.

## Index

- [func All(size int, input string) []string](<#func-all>)
- [func UnsafeFirst(size int, input string) string](<#func-unsafefirst>)


## func [All](<https://github.com/vpayno/exercism-workspace/blob/main/go/series/series.go#L10>)

```go
func All(size int, input string) []string
```

All returns all the contiguous substrings of length n in that string in the order that they appear.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(All(3, "49142"))

}
```

#### Output

```
[491 914 142]
```

</p>
</details>

## func [UnsafeFirst](<https://github.com/vpayno/exercism-workspace/blob/main/go/series/series.go#L39>)

```go
func UnsafeFirst(size int, input string) string
```

UnsafeFirst return the first contiguous substrings of length n in that string.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(UnsafeFirst(3, "49142"))

}
```

#### Output

```
491
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
