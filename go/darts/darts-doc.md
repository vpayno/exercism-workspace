<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# darts

```go
import "darts"
```

Package darts is used to calculate the score in a game of darts\.

## Index

- [func Score(x, y float64) int](<#func-score>)


## func [Score](<https://github.com/vpayno/exercism-workspace/blob/main/go/darts/darts.go#L9>)

```go
func Score(x, y float64) int
```

Score returns a score for a single dart throw\.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Printf("score for (%d, %d): %d\n", 12, 12, Score(12, 12))
	fmt.Printf("score for (%d, %d): %d\n", 0, 0, Score(0, 0))
	fmt.Printf("score for (%d, %d): %d\n", 2, 2, Score(2, 2))
	fmt.Printf("score for (%d, %d): %d\n", 7, 7, Score(7, 7))

}
```

#### Output

```
score for (12, 12): 0
score for (0, 0): 10
score for (2, 2): 5
score for (7, 7): 1
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)