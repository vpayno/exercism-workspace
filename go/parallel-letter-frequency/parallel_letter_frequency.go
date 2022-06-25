package letter

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(s string) FreqMap {
	m := FreqMap{}
	for _, r := range s {
		m[r]++
	}
	return m
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(lines []string) FreqMap {
	var freqMap FreqMap = FreqMap{}
	// var results []FreqMap = []FreqMap{}

	for _, line := range lines {
		// import "golang.org/x/exp/maps" - doesn't merge values
		// maps.Copy(result, Frequency(line))  // needs go1.18

		// import "github.com/samber/lo" - doesn't merge values
		// result = lo.Assign(result, Frequency(line))  // needs go1.18

		fm := Frequency(line)

		for k, v := range fm {
			if _, found := freqMap[k]; found {
				freqMap[k] += v
			} else {
				freqMap[k] = v
			}
		}

	}

	return freqMap
}
