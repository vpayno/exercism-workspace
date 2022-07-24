<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# strain

```go
import "strain"
```

Package strain implements collection keep and discard functions\.

## Index

- [type Ints](<#type-ints>)
  - [func (i Ints) Discard(filter func(int) bool) Ints](<#func-ints-discard>)
  - [func (i Ints) Keep(filter func(int) bool) Ints](<#func-ints-keep>)
- [type Lists](<#type-lists>)
  - [func (l Lists) Keep(filter func([]int) bool) Lists](<#func-lists-keep>)
- [type Strings](<#type-strings>)
  - [func (s Strings) Keep(filter func(string) bool) Strings](<#func-strings-keep>)


## type [Ints](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L5>)

Ints integer collection\.

```go
type Ints []int
```

### func \(Ints\) [Discard](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L31>)

```go
func (i Ints) Discard(filter func(int) bool) Ints
```

Discard returns a new collection containing those elements where the predicate is false\.

<details><summary>Example</summary>
<p>

```go
{
	list := Ints{1, 2, 3, 4, 5, 6, 7, 8, 9}
	f := func(n int) bool { return n%2 == 0 }

	fmt.Println(list.Discard(f))

}
```

#### Output

```
[1 3 5 7 9]
```

</p>
</details>

### func \(Ints\) [Keep](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L14>)

```go
func (i Ints) Keep(filter func(int) bool) Ints
```

Keep returns a new collection containing those elements where the predicate is true\.

<details><summary>Example</summary>
<p>

```go
{
	list := Ints{1, 2, 3, 4, 5, 6, 7, 8, 9}
	f := func(n int) bool { return n%2 == 0 }

	fmt.Println(list.Keep(f))

}
```

#### Output

```
[2 4 6 8]
```

</p>
</details>

## type [Lists](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L8>)

Lists slice integer collection\.

```go
type Lists [][]int
```

### func \(Lists\) [Keep](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L48>)

```go
func (l Lists) Keep(filter func([]int) bool) Lists
```

Keep returns a new collection containing those elements where the predicate is true\.

<details><summary>Example</summary>
<p>

```go
{
	list := Lists{
		[]int{1, 2, 3},
		[]int{4, 5, 6, 7},
		[]int{8, 9},
	}
	f := func(list []int) bool {
		for _, n := range list {
			if n == 5 {
				return true
			}
		}
		return false
	}

	fmt.Println(list.Keep(f))

}
```

#### Output

```
[[4 5 6 7]]
```

</p>
</details>

## type [Strings](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L11>)

Strings string collection\.

```go
type Strings []string
```

### func \(Strings\) [Keep](<https://github.com/vpayno/exercism-workspace/blob/main/go/strain/strain.go#L65>)

```go
func (s Strings) Keep(filter func(string) bool) Strings
```

Keep returns a new collection containing those elements where the predicate is true\.

<details><summary>Example</summary>
<p>

```go
{
	list := Strings{"one", "two", "three", "four"}
	f := func(s string) bool { return len(s)%2 == 0 }

	fmt.Println(list.Keep(f))

}
```

#### Output

```
[four]
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)