package letter

import (
	"fmt"
	"io/ioutil"
	"reflect"
	"runtime"
	"strings"
	"testing"
)

// benchMode values: serial, concurrent
var benchMode string = "concurency"

type freqFunc map[string]func(s string) FreqMap

var benchModes freqFunc = freqFunc{
	"serial":     Frequency,
	"concurency": concurrentFrequency,
}

type book struct {
	input string
}

// concurrentFrequency has the same signature as Frequency() so they can be
// used interchangably in the benchmark function.
func concurrentFrequency(s string) FreqMap {
	// How to remove string.Fields() from the timing record without changing
	// the signature of the function?
	return ConcurrentFrequency(strings.Split(s, "\n"))
}

func setup() []book {
	// sorted from smallest to largest
	var bookFiles []string = []string{
		"resources-pride_and_prejudice.txt",
		"resources-moby_dick_or_the_whale.txt",
		"resources-war_and_peace.txt",
	}

	var inputs []book = []book{}

	for _, fileName := range bookFiles {
		data, e := ioutil.ReadFile(fileName)

		if e != nil {
			panic(e)
		}

		newBook := book{input: string(data)}

		inputs = append(inputs, newBook)

		// needed this while trying to figure out how to fix the channels
		// being closed
		// break
	}

	return inputs
}

func cleanup() {
}

func BenchmarkFrequency(b *testing.B) {
	b.Cleanup(cleanup)

	var table []book = setup()

	var result FreqMap
	var r FreqMap

	// Inorder to use benchstat, we have to use the same benchmark function(s)
	// with different algorithims.
	benchmarkFunc, ok := benchModes[benchMode]

	if !ok {
		panic(fmt.Errorf("Can't find %q in benchModes -> %#v\n", benchMode, benchModes))
	}

	funcName := strings.Split(runtime.FuncForPC(reflect.ValueOf(benchmarkFunc).Pointer()).Name(), ".")[1]
	funcName = strings.Title(funcName)
	fmt.Printf("Using function %s()\n", funcName)

	// Reset the timer so we don't time setup code.
	b.ResetTimer()

	for i, v := range table {
		b.Run(fmt.Sprintf("input_size_%d", i), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				r = benchmarkFunc(v.input)
			}
		})
	}

	// Stop the timer so we don't time post-benchmark code.
	b.StopTimer()

	// make sure the function doesn't get optimized away by using it's results
	result = r

	if len(result) == 0 {
		panic(b.Name() + " failed to produce results")
	}
}
