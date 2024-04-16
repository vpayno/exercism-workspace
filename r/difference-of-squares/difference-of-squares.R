# this is a stub function that takes a natural_number
# and should return the difference-of-squares as described
# in the README.md
square_of_sum <- function(number) {
  sum <-  number * (number + 1) / 2
  square <- sum ^ 2

  return(square)
}

sum_of_squares <- function(number) {
  return(number * (number + 1) * (2 * number + 1) / 6)
}

difference_of_squares <- function(number) {
  return(square_of_sum(number) - sum_of_squares(number))
}
