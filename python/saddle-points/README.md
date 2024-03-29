# Saddle Points

Welcome to Saddle Points on Exercism's Python Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Introduction

You are planning on building a tree house in the woods near your house so that you can watch the sun rise and set.

You've obtained data from a local survey company that shows the heights of all the trees in each rectangular section of the map.
You need to analyze each grid on the map to find the perfect tree for your tree house.

The best tree will be the tallest tree compared to all the other trees to the east and west, so that you have the best possible view of the sunrises and sunsets.
You don't like climbing too much, so the perfect tree will also be the shortest among all the trees to the north and to the south.

## Instructions

Your task is to find the potential trees where you could build your tree house.

The data company provides the data as grids that show the heights of the trees.
The rows of the grid represent the east-west direction, and the columns represent the north-south direction.

An acceptable tree will be the the largest in its row, while being the smallest in its column.

A grid might not have any good trees at all.
Or it might have one, or even several.

Here is a grid that has exactly one candidate tree.

    1  2  3  4
  |-----------
1 | 9  8  7  8
2 | 5  3  2  4  <--- potential tree house at row 2, column 1, for tree with height 5
3 | 6  6  7  1

- Row 2 has values 5, 3, and 1. The largest value is 5.
- Column 1 has values 9, 5, and 6. The smallest value is 5.

So the point at `[2, 1]` (row: 2, column: 1) is a great spot for a tree house.

## Exception messages

Sometimes it is necessary to [raise an exception](https://docs.python.org/3/tutorial/errors.html#raising-exceptions). When you do this, you should always include a **meaningful error message** to indicate what the source of the error is. This makes your code more readable and helps significantly with debugging. For situations where you know that the error source will be a certain type, you can choose to raise one of the [built in error types](https://docs.python.org/3/library/exceptions.html#base-classes), but should still include a meaningful message.

This particular exercise requires that you use the [raise statement](https://docs.python.org/3/reference/simple_stmts.html#the-raise-statement) to "throw" a `ValueError` if the `matrix` is irregular. The tests will only pass if you both `raise` the `exception` and include a message with it.

To raise a `ValueError` with a message, write the message as an argument to the `exception` type:

```python
# if the matrix is irregular
raise ValueError("irregular matrix")
```

## Source

### Created by

- @betegelse

### Contributed to by

- @Alexhans
- @AnAccountForReportingBugs
- @behrtam
- @BethanyG
- @cmccandless
- @crsmi
- @ctholho
- @DocFogel
- @Dog
- @elyssonmr
- @ikhadykin
- @ilmanzo
- @kytrinyx
- @N-Parsons
- @pheanex
- @pywkm
- @sjakobi
- @tqa236
- @yawpitch

### Based on

J Dalbey's Programming Practice problems - https://users.csc.calpoly.edu/~jdalbey/103/Projects/ProgrammingPractice.html

### My Solution

- [my solution](./saddle_points.py)
- [run-tests](./run-tests-python.txt)
