// Package grains calculates the number of grains of wheat on a given
// chessboard square or on the whole chessboard given that the number on each
// square doubles.
package grains

import (
	"fmt"
	"math"
	"math/big"
)

// const squareIDMin is the starting chessboard square id.
const squareIDMin int = 1

// const squareIDMax is the ending chessboard square id.
const squareIDMax int = 64

// isValidSquareID returns true if the id number is in the range 1-64
// (inclusive).
func isValidSquareID(id int) bool {
	if id >= squareIDMin && id <= squareIDMax {
		return true
	}

	return false
}

// Square returns the number of grains for the given square on a chessboard.
func Square(number int) (uint64, error) {
	if !isValidSquareID(number) {
		return 0, fmt.Errorf("[%d] is not a valid square id on our chess board", number)
	}

	var power float64 = float64(number - 1)

	return uint64(math.Pow(2.0, power)), nil
}

// Total returns the number of grans for a while chessboard.
// https://en.wikipedia.org/wiki/Wheat_and_chessboard_problem#:~:text=The%20number%20of%20grains%20of,of%20one%20grain%20of%20wheat).
func Total() uint64 {
	// Can't use gemetric sequences because we need a number larger than 2^64 to substract 1 from.
	// This breaks after (2^62 - 1)
	// var total uint64 = uint64(math.Pow(2.0, float64(64)) - 1.0)

	// Fun fact, the max number for uint64 is (2^64 - 1) which is why you can't subtract 1 from 2^64.
	// So the best optimization is just to return the max uint64 number.
	// var total uint64 = math.MaxUint64

	// https://pkg.go.dev/math/big
	// slower than the second solution and faster than the first.
	two := big.NewInt(int64(2))
	size := big.NewInt(int64(squareIDMax))

	var total *big.Int = new(big.Int).Exp(two, size, nil)
	total.Sub(total, big.NewInt(int64(1)))

	return total.Uint64()
}

/*
  $ benchstat benchstat-brute_force.txt benchstat-constant.txt

  name      old time/op    new time/op    delta
  Square-4    1.53µs ± 0%    1.52µs ± 0%   ~     (p=1.000 n=1+1)
  Total-4     2.92µs ± 0%    0.00µs ± 0%   ~     (p=1.000 n=1+1)

  name      old alloc/op   new alloc/op   delta
  Square-4      232B ± 0%      232B ± 0%   ~     (all equal)
  Total-4      0.00B          0.00B        ~     (all equal)

  name      old allocs/op  new allocs/op  delta
  Square-4      7.00 ± 0%      7.00 ± 0%   ~     (all equal)
  Total-4       0.00           0.00        ~     (all equal)
*/

/*
  $ benchstat benchstat-brute_force.txt benchstat-big_int.txt

  name      old time/op    new time/op    delta
  Square-4    1.53µs ± 0%    1.52µs ± 0%   ~     (p=1.000 n=1+1)
  Total-4     2.92µs ± 0%    0.69µs ± 0%   ~     (p=1.000 n=1+1)

  name      old alloc/op   new alloc/op   delta
  Square-4      232B ± 0%      200B ± 0%   ~     (p=1.000 n=1+1)
  Total-4      0.00B        128.00B ± 0%   ~     (p=1.000 n=1+1)

  name      old allocs/op  new allocs/op  delta
  Square-4      7.00 ± 0%      7.00 ± 0%   ~     (all equal)
  Total-4       0.00           6.00 ± 0%   ~     (p=1.000 n=1+1)
*/
