module LeapYear
  ( isLeapYear
  ) where

-- leap function declaration, one integer parameter, returns boolean
isLeapYear :: Integer -> Bool

-- leap function definition
-- function name and parameter list
-- using guards, brittany doesn't like comments for each guard
        -- if year is evenly divisible by 400, return true
        -- if year is evenly divisible by 100, return false
        -- if year is evenly divisible by 4, return true
        -- guard that catches everything else, like default case in a switch
isLeapYear year | year `mod` 400 == 0 = True
                | year `mod` 100 == 0 = False
                | year `mod` 4 == 0   = True
                | otherwise           = False
