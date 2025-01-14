# Reverse String

Welcome to Reverse String on Exercism's Tcl Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Introduction

Reversing strings (reading them from right to left, rather than from left to right) is a surprisingly common task in programming.

For example, in bioinformatics, reversing the sequence of DNA or RNA strings is often important for various analyses, such as finding complementary strands or identifying palindromic sequences that have biological significance.

## Instructions

Your task is to reverse a given string.

Some examples:

- Turn `"stressed"` into `"desserts"`.
- Turn `"strops"` into `"sports"`.
- Turn `"racecar"` into `"racecar"`.

## Tcl-specific instructions

There are a couple of builtin commands that make this exercise trivial:

* [`string reverse`](https://www.tcl.tk/man/tcl/TclCmd/string.htm#M43)
* [`lreverse`](https://www.tcl.tk/man/tcl/TclCmd/lreverse.html)

Try to implement this yourself without using those "cheats".

## Source

### Created by

- @glennj

### Based on

Introductory challenge to reverse an input string - https://medium.freecodecamp.org/how-to-reverse-a-string-in-javascript-in-3-different-ways-75e4763c68cb

### My Solution

- [reverse-string.tcl](./reverse-string.tcl)
- [run-tests](./run-tests-tcl.txt)
