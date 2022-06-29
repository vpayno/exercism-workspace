<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# hamming

```go
import "hamming"
```

<details><summary>Example (Is Valid DNA Sequence)</summary>
<p>

```go
{
	fmt.Println(isValidDNASequence("ABCCAGTDEF"))
	fmt.Println(isValidDNASequence("GGACTGAAATCTG"))

}
```

#### Output

```
false <nil>
true <nil>
```

</p>
</details>

## Index

- [func Distance(a, b string) (int, error)](<#func-distance>)


## func [Distance](<https://github.com/vpayno/exercism-workspace/blob/main/go/hamming/hamming.go#L16>)

```go
func Distance(a, b string) (int, error)
```

Distance returns an int for the Hamming Distance or 0 and an error if there aer issues\.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(Distance("ABCD", "ABCD"))
	fmt.Println(Distance("ABCD", "CAGT"))
	fmt.Println(Distance("CAGT", "ABCD"))
	fmt.Println(Distance("GGACT", "GGACTGAA"))
	fmt.Println(Distance("GGACTGAAATCTG", "GGACTGAAATCTG"))
	fmt.Println(Distance("GGACGGATTCTG", "AGGACGGATTCT"))

}
```

#### Output

```
0 sequence a isn't valid
0 sequence a isn't valid
0 sequence b isn't valid
0 strings need to be of equal length
0 <nil>
9 <nil>
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)