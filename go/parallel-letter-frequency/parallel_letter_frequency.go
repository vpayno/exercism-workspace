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
	var count int

	freqMap := FreqMap{}

	c := make(chan FreqMap, len(lines))

	frequency := func(s string) {
		c <- Frequency(s)
	}

	for _, line := range lines {
		if len(line) > 0 {
			go frequency(line)
			count++
		}
	}

	for count > 0 {
		count--
		for k, v := range <-c {
			freqMap[k] += v
		}
	}

	return freqMap
}
