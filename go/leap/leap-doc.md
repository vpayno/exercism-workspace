<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# leap

```go
import "leap"
```

Package leap is used to report if a year is a leap year in the Gregorian calendar\.

## Index

- [func IsLeapYear(year int) bool](<#func-isleapyear>)


## func [IsLeapYear](<https://github.com/vpayno/exercism-workspace/blob/main/go/leap/leap.go#L5>)

```go
func IsLeapYear(year int) bool
```

IsLeapYear retuns true if the year is a leap year\.

<details><summary>Example</summary>
<p>

```go
{
	years := []int{1996, 1997, 1900, 2000}

	for _, year := range years {
		fmt.Printf("%d: %v\n", year, IsLeapYear(year))
	}

}
```

#### Output

```
1996: true
1997: false
1900: false
2000: true
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
