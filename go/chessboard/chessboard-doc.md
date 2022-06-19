<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# chessboard

```go
import "chessboard"
```

## Index

- [func CountAll(cb Chessboard) int](<#func-countall>)
- [func CountInFile(cb Chessboard, file int) int](<#func-countinfile>)
- [func CountInRank(cb Chessboard, rank string) int](<#func-countinrank>)
- [func CountOccupied(cb Chessboard) int](<#func-countoccupied>)
- [type Chessboard](<#type-chessboard>)
- [type Rank](<#type-rank>)


## func [CountAll](<https://github.com/vpayno/exercism-workspace/blob/main/go/chessboard/chessboard.go#L38>)

```go
func CountAll(cb Chessboard) int
```

CountAll should count how many squares are present in the chessboard

<details><summary>Example</summary>
<p>

```go
{
	board := newChessboard()

	fmt.Println(CountAll(board))

}
```

#### Output

```
64
```

</p>
</details>

## func [CountInFile](<https://github.com/vpayno/exercism-workspace/blob/main/go/chessboard/chessboard.go#L25>)

```go
func CountInFile(cb Chessboard, file int) int
```

CountInFile returns how many squares are occupied in the chessboard\, within the given file

<details><summary>Example</summary>
<p>

```go
{
	board := newChessboard()

	fmt.Println(CountInFile(board, 2))

}
```

#### Output

```
1
```

</p>
</details>

## func [CountInRank](<https://github.com/vpayno/exercism-workspace/blob/main/go/chessboard/chessboard.go#L11>)

```go
func CountInRank(cb Chessboard, rank string) int
```

CountInRank returns how many squares are occupied in the chessboard\, within the given rank

<details><summary>Example</summary>
<p>

```go
{
	board := newChessboard()

	fmt.Println(CountInRank(board, "A"))

}
```

#### Output

```
3
```

</p>
</details>

## func [CountOccupied](<https://github.com/vpayno/exercism-workspace/blob/main/go/chessboard/chessboard.go#L51>)

```go
func CountOccupied(cb Chessboard) int
```

CountOccupied returns how many squares are occupied in the chessboard

<details><summary>Example</summary>
<p>

```go
{
	board := newChessboard()

	fmt.Println(CountOccupied(board))

}
```

#### Output

```
15
```

</p>
</details>

## type [Chessboard](<https://github.com/vpayno/exercism-workspace/blob/main/go/chessboard/chessboard.go#L7>)

Chessboard contains a map of eight Ranks\, accessed with keys from "A" to "H"

```go
type Chessboard map[string]Rank
```

## type [Rank](<https://github.com/vpayno/exercism-workspace/blob/main/go/chessboard/chessboard.go#L4>)

Rank stores if a square is occupied by a piece \- this will be a slice of bools

```go
type Rank []bool
```



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)