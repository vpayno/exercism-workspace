module Bob
  ( responseFor
  ) where

-- isSpace, isUppwer
import           Data.Char

-- dropWhile, dropWhileEnd
import           Data.List

-- https://hackage.haskell.org/package/text-2.0.1/docs/Data-Text.html
-- https://stackoverflow.com/questions/1475896/looking-for-an-explanation-of-function-composition

responseFor :: String -> String
responseFor = respond . trim
 where
  respond text | isSilence text      = "Fine. Be that way!"
               | isLoudQuestion text = "Calm down, I know what I'm doing!"
               | isQuestion text     = "Sure."
               | isYelling text      = "Whoa, chill out!"
               | otherwise           = "Whatever."

-- https://stackoverflow.com/questions/6270324/in-haskell-how-do-you-trim-whitespace-from-the-beginning-and-end-of-a-string
trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

-- https://stackoverflow.com/questions/30242668/remove-characters-from-string-in-haskell
-- https://stackoverflow.com/questions/43899090/remove-numbers-from-a-string-haskell
onlyLettersAndNumbers :: String -> String
onlyLettersAndNumbers xs = [ x | x <- xs, x `notElem` " ,.?!-:;)(^*%@#$\"\'" ]

removeWhiteSpace :: String -> String
removeWhiteSpace = filter (not . isSpace)

-- I need an isUpper that doesn't return false for numbers or punctuation or white space.
isUpperOrDigit :: Char -> Bool
isUpperOrDigit char | isLetter char = isUpper char
                    | isDigit char  = True
                    | otherwise     = False

-- "Does this cryogenic chamber make me look fat?"
isQuestion :: String -> Bool
isQuestion text = last text `elem` "?"

-- "WHAT THE HELL WERE YOU THINKING?"
isLoudQuestion :: String -> Bool
isLoudQuestion text =
  isQuestion text && any isUpper chars && all isUpperOrDigit chars
  where chars = onlyLettersAndNumbers text

-- "WATCH OUT!"
isYelling :: String -> Bool
isYelling text =
  not (isQuestion text) && any isUpper chars && all isUpperOrDigit chars
  where chars = onlyLettersAndNumbers text

-- ""
isSilence :: String -> Bool
isSilence text = null chars where chars = removeWhiteSpace text
