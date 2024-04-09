leap <- function(year) {
  if (year %% 400 == 0) {
    return(TRUE)
  }

  if (year %% 100 == 0) {
    return(FALSE)
  }

  if (year %% 4 == 0) {
    return(TRUE)
  }

  return(FALSE)
}
