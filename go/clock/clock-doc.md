<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# clock

```go
import "clock"
```

Package clock that handles times without dates.

## Index

- [type Clock](<#type-clock>)
  - [func New(h, m int) Clock](<#func-new>)
  - [func (c Clock) Add(m int) Clock](<#func-clock-add>)
  - [func (c Clock) String() string](<#func-clock-string>)
  - [func (c Clock) Subtract(m int) Clock](<#func-clock-subtract>)


## type [Clock](<https://github.com/vpayno/exercism-workspace/blob/main/go/clock/clock.go#L7-L10>)

Clock struct that uses hours and minutes to represent time.

```go
type Clock struct {
    // contains filtered or unexported fields
}
```

### func [New](<https://github.com/vpayno/exercism-workspace/blob/main/go/clock/clock.go#L34>)

```go
func New(h, m int) Clock
```

New returns a new clock with the normalized given hours and minutes.

### func \(Clock\) [Add](<https://github.com/vpayno/exercism-workspace/blob/main/go/clock/clock.go#L44>)

```go
func (c Clock) Add(m int) Clock
```

Add returns a clock with the added minutes.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Printf("%s + 00:%2d = %s\n", clock, 20, clock.Add(20))
	fmt.Printf("%s + 00:%2d = %s\n", clock, 40, clock.Add(40))

}
```

#### Output

```
20:35 + 00:20 = 20:55
20:35 + 00:40 = 21:15
```

</p>
</details>

### func \(Clock\) [String](<https://github.com/vpayno/exercism-workspace/blob/main/go/clock/clock.go#L58>)

```go
func (c Clock) String() string
```

String retruns a string representation of the clock struct.

### func \(Clock\) [Subtract](<https://github.com/vpayno/exercism-workspace/blob/main/go/clock/clock.go#L51>)

```go
func (c Clock) Subtract(m int) Clock
```

Subtract returns a clock with the subtracted minutes.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Printf("%s - 00:%2d = %s\n", clock, 20, clock.Subtract(20))
	fmt.Printf("%s - 00:%2d = %s\n", clock, 40, clock.Subtract(40))

}
```

#### Output

```
20:35 - 00:20 = 20:15
20:35 - 00:40 = 19:55
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
