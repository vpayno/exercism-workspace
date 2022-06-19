package chessboard

// Rank stores if a square is occupied by a piece - this will be a slice of bools
type Rank []bool

// Chessboard contains a map of eight Ranks, accessed with keys from "A" to "H"
type Chessboard map[string]Rank

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank
func CountInRank(cb Chessboard, rank string) int {
	var count int

	for _, value := range cb[rank] {
		if value {
			count++
		}
	}

	return count
}

// CountInFile returns how many squares are occupied in the chessboard,
// within the given file
func CountInFile(cb Chessboard, file int) int {
	var count int

	for key := range cb {
		if (file-1 >= 0 && file-1 < 8) && cb[key][file-1] {
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
