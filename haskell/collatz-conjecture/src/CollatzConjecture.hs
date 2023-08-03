module CollatzConjecture
  ( collatz
  ) where

collatz :: Integer -> Maybe Integer
collatz n = collatz' n 0

collatz' :: Integer -> Integer -> Maybe Integer
collatz' n steps | n == 1    = Just steps
                 | n <= 0    = Nothing
                 | even n    = collatz' (n `div` 2) (steps + 1)
                 | otherwise = collatz' (3 * n + 1) (steps + 1)
