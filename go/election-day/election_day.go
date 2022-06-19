package electionday

import (
	"fmt"
)

// NewVoteCounter returns a new vote counter with
// a given number of initial votes.
func NewVoteCounter(initialVotes int) *int {
	var counter *int

	counter = &initialVotes

	return counter
}

// VoteCount extracts the number of votes from a counter.
func VoteCount(counter *int) int {
	var votes int

	if counter != nil {
		votes = *counter
	} else {
		votes = 0
	}

	return votes
}

// IncrementVoteCount increments the value in a vote counter
func IncrementVoteCount(counter *int, increment int) {
	if counter != nil {
		*counter += increment
	} else {
		*counter = increment
	}
}

// NewElectionResult creates a new election result
func NewElectionResult(candidateName string, votes int) *ElectionResult {
	var result ElectionResult = ElectionResult{
		Name:  candidateName,
		Votes: votes,
	}

	return &result
}

// DisplayResult creates a message with the result to be displayed
func DisplayResult(result *ElectionResult) string {
	var message string

	message = fmt.Sprintf("%v (%v)", result.Name, result.Votes)

	return message
}

// DecrementVotesOfCandidate decrements by one the vote count of a candidate in a map
func DecrementVotesOfCandidate(results map[string]int, candidate string) {
	for key, value := range results {
		if key == candidate && value > 0 {
			results[key]--
		}
	}
}
