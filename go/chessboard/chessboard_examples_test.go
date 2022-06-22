package chessboard

import (
	"fmt"
)

func ExampleCountInRank() {
	board := newChessboard()

	fmt.Println(CountInRank(board, "A"))
	// Output: 3
}

func ExampleCountInFile() {
	board := newChessboard()

	fmt.Println(CountInFile(board, 2))
	// Output: 1
}

func ExampleCountAll() {
	board := newChessboard()

	fmt.Println(CountAll(board))
	// Output: 64
}

func ExampleCountOccupied() {
	board := newChessboard()

	fmt.Println(CountOccupied(board))
	// Output: 15
}
