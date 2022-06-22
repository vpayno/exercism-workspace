package electionday

import (
	"fmt"
)

func ExampleNewVoteCounter() {
	var initialVotes int
	var counter *int

	initialVotes = 2
	counter = NewVoteCounter(initialVotes)

	fmt.Println(*counter == initialVotes)
	// Output:
	// true
}

func ExampleVoteCount() {
	var votes int
	votes = 3

	var voteCounter *int
	voteCounter = &votes

	var nilVoteCounter *int

	fmt.Println(VoteCount(voteCounter))
	fmt.Println(VoteCount(nilVoteCounter))
	// Output:
	// 3
	// 0
}

func ExampleIncrementVoteCount() {
	var votes int
	var voteCounter *int

	votes = 3
	voteCounter = &votes

	IncrementVoteCount(voteCounter, 2)

	fmt.Println(votes == 5)
	fmt.Println(*voteCounter == 5)
	// Output:
	// true
	// true
}

func ExampleNewElectionResult() {
	var result *ElectionResult

	result = NewElectionResult("Peter", 3)

	fmt.Println(result.Name == "Peter")
	fmt.Println(result.Votes == 3)
	// Output:
	// true
	// true
}

func ExampleDisplayResult() {
	var result *ElectionResult

	result = &ElectionResult{
		Name:  "John",
		Votes: 32,
	}

	message := DisplayResult(result)

	fmt.Println(message)
	// Output:
	// John (32)
}

func ExampleDecrementVotesOfCandidate() {
	var finalResults = map[string]int{
		"Mary": 10,
		"John": 51,
	}

	DecrementVotesOfCandidate(finalResults, "Mary")

	fmt.Println(finalResults["Mary"])
	// Output:
	// 9
}
