# Scrabble Score

Welcome to Scrabble Score on Exercism's Go Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

Given a word, compute the Scrabble score for that word.

## Letter Values

You'll need these:

```text
Letter                           Value
A, E, I, O, U, L, N, R, S, T       1
D, G                               2
B, C, M, P                         3
F, H, V, W, Y                      4
K                                  5
J, X                               8
Q, Z                               10
```

## Examples

"cabbage" should be scored as worth 14 points:

- 3 points for C
- 1 point for A, twice
- 3 points for B, twice
- 2 points for G
- 1 point for E

And to total:

- `3 + 2*1 + 2*3 + 2 + 1`
- = `3 + 2 + 6 + 3`
- = `5 + 9`
- = 14

## Extensions

- You can play a double or a triple letter.
- You can play a double or a triple word.

## Source

### Created by

- @nathany

### Contributed to by

- @alebaffa
- @bitfield
- @ekingery
- @ferhatelmas
- @HaraldNordgren
- @hilary
- @ilmanzo
- @kotp
- @kytrinyx
- @leenipper
- @petertseng
- @robphoenix
- @sebito91
- @sjakobi
- @tleen
- @eklatzer

### Based on

Inspired by the Extreme Startup game - https://github.com/rchatley/extreme_startup

### My Solution

- [my solution](./scrabble_score.go)
- [my examples](./scrabble_score_examples_test.go)
- [test cases](./cases_test.go)
- [tests](./scrabble_score_test.go)
- [run-tests](./run-tests-go.txt)
- [coverage](./coverage.html)
- [documentation](./scrabble-doc.md)
