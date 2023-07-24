# Atbash Cipher

Welcome to Atbash Cipher on Exercism's C++ Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

Create an implementation of the Atbash cipher, an ancient encryption system created in the Middle East.

The Atbash cipher is a simple substitution cipher that relies on
transposing all the letters in the alphabet such that the resulting
alphabet is backwards. The first letter is replaced with the last
letter, the second with the second-last, and so on.

An Atbash cipher for the Latin alphabet would be as follows:

```text
Plain:  abcdefghijklmnopqrstuvwxyz
Cipher: zyxwvutsrqponmlkjihgfedcba
```

It is a very weak cipher because it only has one possible key, and it is
a simple monoalphabetic substitution cipher.
However, this may not have been an issue in the cipher's time.

Ciphertext is written out in groups of fixed length, the traditional group size
being 5 letters, and punctuation is excluded.
This is to make it harder to guess things based on word boundaries.

## Examples

- Encoding `test` gives `gvhg`
- Decoding `gvhg` gives `test`
- Decoding `gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt` gives `thequickbrownfoxjumpsoverthelazydog`

## Source

### Created by

- @vivshaw

### Contributed to by

- @AlexLeSang
- @elyashiv
- @jackhughesweb
- @KevinWMatthews
- @LegalizeAdulthood
- @patricksjackson

### Based on

Wikipedia - http://en.wikipedia.org/wiki/Atbash

### My Solution

- [my solution]()
- [run-tests](./run-tests-cpp.txt)