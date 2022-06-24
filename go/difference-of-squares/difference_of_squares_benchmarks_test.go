package diffsquares

import (
	"fmt"
	"testing"
)

var table = []struct {
	input int
}{
	{input: 10},
	{input: 100},
	{input: 1_000},
	{input: 10_000},
}

var result int

func Benchmark_squareOfSumBruteForce(b *testing.B) {
	var r int

	for _, v := range table {
		b.Run(fmt.Sprintf("input_size_%d", v.input), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				r = squareOfSumBruteForce(v.input)
			}
		})
	}

	result = r
}

func Benchmark_sumOfSquaresBruteForce(b *testing.B) {
	var r int

	for _, v := range table {
		b.Run(fmt.Sprintf("input_size_%d", v.input), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				r = sumOfSquaresBruteForce(v.input)
			}
		})
	}

	result = r
}

func Benchmark_squareOfSumGauss(b *testing.B) {
	var r int

	for _, v := range table {
		b.Run(fmt.Sprintf("input_size_%d", v.input), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				r = squareOfSumGauss(v.input)
			}
		})
	}

	result = r
}

func Benchmark_sumOfSquaresGauss(b *testing.B) {
	var r int

	for _, v := range table {
		b.Run(fmt.Sprintf("input_size_%d", v.input), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				r = sumOfSquaresGauss(v.input)
			}
		})
	}

	result = r
}

func BenchmarkDifference2(b *testing.B) {
	var r int

	for _, v := range table {
		b.Run(fmt.Sprintf("input_size_%d", v.input), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				r = Difference(v.input)
			}
		})
	}

	result = r
}

/*
	$ time go test --run=xxx --bench . --benchmem
	goos: linux
	goarch: amd64
	pkg: diffsquares
	cpu: Intel(R) Core(TM) i7-7Y75 CPU @ 1.30GHz

	Benchmark_squareOfSumBruteForce/input_size_10-4                 29426822                36.32 ns/op            0 B/op          0 allocs/op
	Benchmark_squareOfSumBruteForce/input_size_100-4                 8640528               131.1 ns/op             0 B/op          0 allocs/op
	Benchmark_squareOfSumBruteForce/input_size_1000-4                1308825               945.4 ns/op             0 B/op          0 allocs/op
	Benchmark_squareOfSumBruteForce/input_size_10000-4                115472              9273 ns/op               0 B/op          0 allocs/op
	Benchmark_sumOfSquaresBruteForce/input_size_10-4                 3680767               291.4 ns/op             0 B/op          0 allocs/op
	Benchmark_sumOfSquaresBruteForce/input_size_100-4                 341122              3511 ns/op               0 B/op          0 allocs/op
	Benchmark_sumOfSquaresBruteForce/input_size_1000-4                 32896             34281 ns/op               0 B/op          0 allocs/op
	Benchmark_sumOfSquaresBruteForce/input_size_10000-4                 3711            347095 ns/op               0 B/op          0 allocs/op

	Benchmark_squareOfSumGauss/input_size_10-4                      26699696                50.20 ns/op            0 B/op          0 allocs/op
	Benchmark_squareOfSumGauss/input_size_100-4                     30163941                34.02 ns/op            0 B/op          0 allocs/op
	Benchmark_squareOfSumGauss/input_size_1000-4                    38001340                34.72 ns/op            0 B/op          0 allocs/op
	Benchmark_squareOfSumGauss/input_size_10000-4                   31666057                35.09 ns/op            0 B/op          0 allocs/op
	Benchmark_sumOfSquaresGauss/input_size_10-4                     439645538                2.339 ns/op           0 B/op          0 allocs/op
	Benchmark_sumOfSquaresGauss/input_size_100-4                    497528520                2.323 ns/op           0 B/op          0 allocs/op
	Benchmark_sumOfSquaresGauss/input_size_1000-4                   483448791                2.396 ns/op           0 B/op          0 allocs/op
	Benchmark_sumOfSquaresGauss/input_size_10000-4                  438887734                2.466 ns/op           0 B/op          0 allocs/op

	PASS
	ok      diffsquares     36.072s

	real    0m36.562s
	user    0m38.104s
	sys     0m0.711s
*/
