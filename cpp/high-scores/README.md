# High Scores

Welcome to High Scores on Exercism's C++ Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

Manage a game player's High Score list.

Your task is to build a high-score component of the classic Frogger game, one of the highest-selling and most addictive games of all time, and a classic of the arcade era.
Your task is to write methods that return the highest score from the list, the last added score, and the three highest scores.

## Some Additional Notes for C++ Implementation

This exercise uses the [vector container][vector].
You might find it useful to use the [algorithm][algorithm] header to solve this exercise.

Some of the algorithm functions need [`iterators`][iterator] as arguments.
Those can be seen as markers of where a container starts and ends.
If you want to cover the complete container, you start with `my_container.begin()` and end with `my_container.end()`.
If you just want the elements 2, 3, and 4 of a vector you could use `my_vector.begin() + 2` and `my_vector.begin() + 4`.

The last tests check for [immutability][immutability].
None of the functions that you are tasked to write should change the scores of the game.

If you want some extra practice, you can implement a function that adds new scores to the game.

[vector]: https://en.cppreference.com/w/cpp/container/vector
[algorithm]: https://en.cppreference.com/w/cpp/algorithm
[immutability]: https://en.wikipedia.org/wiki/Immutable_object
[iterator]: https://www.learncpp.com/cpp-tutorial/introduction-to-iterators/

## Source

### Created by

- @vaeng

### Based on

Tribute to the eighties' arcade game Frogger

### My Solution

- [my solution]()
- [run-tests](./run-tests-cpp.txt)
