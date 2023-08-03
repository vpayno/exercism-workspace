module Hamming
  ( distance
  ) where

distance :: String -> String -> Maybe Int
distance lhs rhs
  | length lhs /= length rhs = Nothing
  | otherwise = Just
    (length [ nucleotide | nucleotide <- zip lhs rhs, uncurry (/=) nucleotide ])
