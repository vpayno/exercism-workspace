// Package grains calculates the number of grains of wheat on a given
// chessboard square or on the whole chessboard given that the number on each
// square doubles.
package grains

import (
	"errors"
	"fmt"
	"math"
)

// const squareIdMin is the starting chessboard square id.
const squareIdMin int = 1

// const squareIdMax is the ending chessboard square id.
const squareIdMax int = 64

// isValidSquareId returns true if the id number is in the range 1-64
// (inclusive).
func isValidSquareId(id int) bool {
	if id >= squareIdMin && id <= squareIdMax {
		return true
	}

	return false
}

// Square returns the number of grains for the given square on a chessboard.
func Square(number int) (uint64, error) {
	if !isValidSquareId(number) {
		return 0, errors.New(fmt.Sprintf("[%d] is not a valid square id on our chess board.", number))
	}

	var power float64 = float64(number - 1)

	return uint64(math.Pow(2.0, power)), nil
}

// Total returns the number of grans for a while chessboard.
func Total() uint64 {
	var total uint64

	for i := squareIdMin; i <= squareIdMax; i++ {
		v, e := Square(i)

		if e != nil {
			panic(e)
		}

		total += v
	}

	return total
}
