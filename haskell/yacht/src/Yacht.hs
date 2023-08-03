module Yacht
  ( yacht
  , Category(..)
  ) where

import qualified Data.Map                      as M
import           Data.Map                       ( (!)
                                                , Map
                                                )

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int
yacht category dice =
  let
    numbersCount :: Map Int Int
    numbersCount = countNumbers dice
  in
    case category of
      Ones   -> countN 1 numbersCount
      Twos   -> countN 2 numbersCount
      Threes -> countN 3 numbersCount
      Fours  -> countN 4 numbersCount
      Fives  -> countN 5 numbersCount
      Sixes  -> countN 6 numbersCount
      FullHouse ->
        if distinctNbs numbersCount == 2 && elem 3 (M.elems numbersCount)
          then sum dice
          else 0
      FourOfAKind -> maybe 0 (4 *) $ firstIdxOf numbersCount (4 <=)
      LittleStraight ->
        if distinctNbs numbersCount == 5 && numbersCount ! 6 == 0 then 30 else 0
      BigStraight -> if distinctNbs numbersCount == 5 && numbersCount ! 1 == 0
        then 30
        else 0
      Choice -> sum dice
      Yacht  -> if distinctNbs numbersCount == 1 then 50 else 0

countN :: Int -> Map Int Int -> Int
countN n counts = n * (counts ! n)

countItem :: Int -> Map Int Int -> Map Int Int
countItem n = M.insertWith (+) n 1

countNumbers :: [Int] -> Map Int Int
countNumbers = foldr countItem (M.fromList [ (i, 0) | i <- [1 .. 6] ])

distinctNbs :: Map Int Int -> Int
distinctNbs counts = length $ filter (0 <) $ M.elems counts

firstIdxOf :: Map Int Int -> (Int -> Bool) -> Maybe Int
firstIdxOf counts condition =
  let aux mapAsList = case mapAsList of
        []             -> Nothing
        (idx, cnt) : q -> if condition cnt then Just idx else aux q
  in  aux $ M.toList counts
