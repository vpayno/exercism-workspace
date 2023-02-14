module Raindrops
  ( convert
  ) where

-- https://hoogle.haskell.org/?hoogle=concat
-- https://stackoverflow.com/questions/9220986/is-there-any-haskell-function-to-concatenate-list-with-separator
-- https://stackoverflow.com/questions/37996610/how-to-apply-a-function-on-each-element-in-a-list-in-haskell
-- https://www.haskelltutorials.com/guides/haskell-lists-ultimate-guide.html
-- https://wiki.haskell.org/List_comprehension

convert :: Int -> String

-- if the string buffer is empty, return the number as a string
-- otherwise return the string buffer
convert n | null buffer = show n
          | otherwise   = buffer
 where
  -- "map" of factors to rain sounds
  sounds = [(3, "Pling"), (5, "Plang"), (7, "Plong")]

  -- list comprehension used to concatenate a sound to the buffer when
  -- n has i as one of it's factors
  -- if there are no matches, the buffer will be empty
  buffer = concat [ sound | (i, sound) <- sounds, n `mod` i == 0 ]
