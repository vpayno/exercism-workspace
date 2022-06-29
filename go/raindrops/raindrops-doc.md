<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# raindrops

```go
import "raindrops"
```

Package raindrops converts a number into a string that contains raindrop sounds corresponding to certain potential factors\.

## Index

- [func Convert(number int) string](<#func-convert>)


## func [Convert](<https://github.com/vpayno/exercism-workspace/blob/main/go/raindrops/raindrops.go#L10>)

```go
func Convert(number int) string
```

Convert returns a string containing raindrop sounds corresponding to factors of the number\, \`int\`\, given\.

<details><summary>Example</summary>
<p>

```go
{
	rain := []int{1, 3, 5, 6, 7, 8, 15, 35, 105}
	for _, drop := range rain {
		fmt.Println(Convert(drop))
	}

}
```

#### Output

```
1
Pling
Plang
Pling
Plong
8
PlingPlang
PlangPlong
PlingPlangPlong
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)