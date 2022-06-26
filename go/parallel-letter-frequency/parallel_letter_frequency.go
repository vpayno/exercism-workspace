package letter

import (
	"runtime"
	"sync"
	"time"
)

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

type Job struct {
	id int
	s  string
}

type Result struct {
	job     Job
	freqMap FreqMap
}

var maxWorkers int = runtime.NumCPU() * 2

var jobs chan Job = make(chan Job, maxWorkers)
var results chan Result = make(chan Result, maxWorkers)

func worker(wg *sync.WaitGroup) {
	defer wg.Done()

	for job := range jobs {
		output := Result{
			job,
			Frequency(job.s),
		}
		results <- output
	}
}

func createWorkerPool(workers int) {
	defer close(results)

	var wg sync.WaitGroup

	for i := 0; i < workers; i++ {
		wg.Add(1)
		go worker(&wg)
	}

	wg.Wait()
}

func allocate(workers int, lines []string) {
	for i := 0; i < workers; i++ {
		if len(lines[i]) == 0 {
			continue
		}

		job := Job{
			i,
			lines[i],
		}

		jobs <- job
	}

	close(jobs)
}

func result(done chan bool, data chan []FreqMap) {
	var freqList []FreqMap = []FreqMap{}

	for result := range results {
		// fmt.Printf("%d: %#v\n", result.job.id, result.freqMap)
		freqList = append(freqList, result.freqMap)
	}

	data <- freqList // needs to be after signaling that we're done.

	// fmt.Printf("result(): freqList -> %#v\n", freqList)

	// Minimum amount required to prevent the next send from failing.
	// The Printf in the for loop was hiding this problem.
	time.Sleep(time.Millisecond * 1_000)

	done <- true
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(lines []string) FreqMap {
	done := make(chan bool)
	var data chan []FreqMap = make(chan []FreqMap, maxWorkers)

	totalJobs := len(lines)
	go allocate(totalJobs, lines)

	var freqMap FreqMap = FreqMap{}
	go result(done, data)

	createWorkerPool(maxWorkers)

	var freqList []FreqMap = <-data
	<-done // barrier

	// fmt.Printf("ConcurrentFrequency(): freqList -> %#v\n", freqList)

	for _, fm := range freqList {
		// fm := Frequency(line)

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
