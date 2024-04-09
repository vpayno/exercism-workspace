raindrops <- function(number) {
  sounds <- ""

  # using 3 different ways of appending to a string

  if (number %% 3 == 0) {
    sounds <- paste(sounds, "Pling", sep = "")
  }

  if (number %% 5 == 0) {
    sounds <- paste0(sounds, "Plang")
  }

  if (number %% 7 == 0) {
    sounds <- append(sounds, "Plong")
    sounds <- paste(sounds, collapse = "")
  }

  if (sounds == "") {
    sounds <- as.character(number)
  }

  return(sounds)
}
