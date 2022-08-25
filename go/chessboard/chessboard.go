// Package chessboard returns stats on a chessboard.
package chessboard

// File stores if a square is occupied by a piece - this will be a slice of bools
type File []bool

// Chessboard contains a map of eight Files, accessed with keys from "A" to "H"
type Chessboard map[string]File

// CountInFile returns how many squares are occupied in the chessboard,
// within the given rank
func CountInFile(cb Chessboard, rank string) int {
	var count int

	for _, value := range cb[rank] {
		if value {
			count++
		}
	}

	return count
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given file
func CountInRank(cb Chessboard, file int) int {
	var count int

	for key := range cb {
		if (file > 0 && file <= 8) && cb[key][file-1] {
			count++
		}
	}

	return count
}

// CountAll should count how many squares are present in the chessboard
func CountAll(cb Chessboard) int {
	var count int

	for key := range cb {
		for range cb[key] {
			count++
		}
	}

	return count
}

// CountOccupied returns how many squares are occupied in the chessboard
func CountOccupied(cb Chessboard) int {
	var count int

	for key := range cb {
		for _, value := range cb[key] {
			if value {
				count++
			}
		}
	}

	return count
}
