# Collatz Conjecture

Welcome to Collatz Conjecture on Exercism's WebAssembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

The Collatz Conjecture or 3x+1 problem can be summarized as follows:

Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is
odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely.
The conjecture states that no matter which number you start with, you will
always reach 1 eventually.

Given a number n, return the number of steps required to reach 1.

## Examples

Starting with n = 12, the steps would be as follows:

0. 12
1. 6
2. 3
3. 10
4. 5
5. 16
6. 8
7. 4
8. 2
9. 1

Resulting in 9 steps. So for input n = 12, the return value would be 9.

If `n` is _not_ a positive integer, don't continue executing and return `-1` to indicate an error condition.

## Source

### Created by

- @bushidocodes

### Based on

An unsolved problem in mathematics named after mathematician Lothar Collatz - https://en.wikipedia.org/wiki/3x_%2B_1_problem

### My Solution

- [my solution]()
- [run-tests](./run-tests-wasm.txt)