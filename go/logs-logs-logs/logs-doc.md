<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# logs

```go
import "logs"
```

## Index

- [func Application(log string) string](<#func-application>)
- [func Replace(log string, oldRune, newRune rune) string](<#func-replace>)
- [func WithinLimit(log string, limit int) bool](<#func-withinlimit>)


## func [Application](<https://github.com/vpayno/exercism-workspace/blob/main/go/logs-logs-logs/logs_logs_logs.go#L9>)

```go
func Application(log string) string
```

Application identifies the application emitting the given log\.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(Application("❗ recommended recommendation product 🔍"))
	fmt.Println(Application("❗ recommended product"))
	fmt.Println(Application("🔍 recommended search product"))
	fmt.Println(Application("☀ recommended weather product"))

}
```

#### Output

```
recommendation
recommendation
search
weather
```

</p>
</details>

## func [Replace](<https://github.com/vpayno/exercism-workspace/blob/main/go/logs-logs-logs/logs_logs_logs.go#L32>)

```go
func Replace(log string, oldRune, newRune rune) string
```

Replace replaces all occurrences of old with new\, returning the modified log to the caller\.

<details><summary>Example</summary>
<p>

```go
{
	log := "please replace '👎' with '👍'"

	fmt.Println(Replace(log, '👎', '👍'))

}
```

#### Output

```
please replace '👍' with '👍'
```

</p>
</details>

## func [WithinLimit](<https://github.com/vpayno/exercism-workspace/blob/main/go/logs-logs-logs/logs_logs_logs.go#L38>)

```go
func WithinLimit(log string, limit int) bool
```

WithinLimit determines whether or not the number of characters in log is within the limit\.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(WithinLimit("hello❗", 6))

}
```

#### Output

```
true
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)