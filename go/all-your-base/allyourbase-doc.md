<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# allyourbase

```go
import "allyourbase"
```

Package allyourbase is used to convert from any base to any other base.

## Index

- [func ConvertFromBase10(outputBase int, inputNum int) []int](<#func-convertfrombase10>)
- [func ConvertIntToIntList(num int) []int](<#func-convertinttointlist>)
- [func ConvertStrToIntList(inputStr string) []int](<#func-convertstrtointlist>)
- [func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error)](<#func-converttobase>)
- [func ConvertToBase10(inputBase int, inputDigits []int) int](<#func-converttobase10>)


## func [ConvertFromBase10](<https://github.com/vpayno/exercism-workspace/blob/main/go/all-your-base/all_your_base.go#L147>)

```go
func ConvertFromBase10(outputBase int, inputNum int) []int
```

ConvertFromBase10 returns a base x number. It didn't make sense to pass the functions an int slice so I'm hiding that part of the algorithm in the function.

<details><summary>Example</summary>
<p>

```go
{
	digits := 5
	base := 10

	fmt.Printf("number: %#v, base: %d\n", digits, base)
	fmt.Printf("number: %#v, base: %d\n", ConvertFromBase10(2, digits), 2)

}
```

#### Output

```
number: 5, base: 10
number: []int{1, 0, 1}, base: 2
```

</p>
</details>

## func [ConvertIntToIntList](<https://github.com/vpayno/exercism-workspace/blob/main/go/all-your-base/all_your_base.go#L98>)

```go
func ConvertIntToIntList(num int) []int
```

ConvertIntToIntList returns a list of intergers for the passed int.

## func [ConvertStrToIntList](<https://github.com/vpayno/exercism-workspace/blob/main/go/all-your-base/all_your_base.go#L108>)

```go
func ConvertStrToIntList(inputStr string) []int
```

ConvertStrToIntList returns a list of intergers for the passed string.

<details><summary>Example</summary>
<p>

```go
{
	s := "12345"
	l := ConvertStrToIntList(s)

	fmt.Printf("str: %q\nlist: %#v\n", s, l)

}
```

#### Output

```
str: "12345"
list: []int{1, 2, 3, 4, 5}
```

</p>
</details>

## func [ConvertToBase](<https://github.com/vpayno/exercism-workspace/blob/main/go/all-your-base/all_your_base.go#L12>)

```go
func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error)
```

ConvertToBase returns an integer slice of converted numbers.

<details><summary>Example</summary>
<p>

```go
{
	numbers, _ := ConvertToBase(2, []int{1, 0, 1}, 10)

	fmt.Printf("base %d %v to base %d %v\n", 2, []int{1, 0, 1}, 10, numbers)

}
```

#### Output

```
base 2 [1 0 1] to base 10 [5]
```

</p>
</details>

## func [ConvertToBase10](<https://github.com/vpayno/exercism-workspace/blob/main/go/all-your-base/all_your_base.go#L125>)

```go
func ConvertToBase10(inputBase int, inputDigits []int) int
```

ConvertToBase10 returns a base 10 number.

<details><summary>Example</summary>
<p>

```go
{
	digits := []int{1, 0, 1}
	base := 2

	fmt.Printf("number: %#v, base: %d\n", digits, base)
	fmt.Printf("number: %#v, base: %d\n", ConvertToBase10(base, digits), 10)

}
```

#### Output

```
number: []int{1, 0, 1}, base: 2
number: 5, base: 10
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
