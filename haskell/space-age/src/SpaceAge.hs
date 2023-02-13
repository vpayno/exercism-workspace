module SpaceAge
  ( Planet(..)
  , ageOn
  ) where

-- enum type declaration/definition
data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

-- ageOn function declaration: ageOn(Planet, Float) -> Float
ageOn :: Planet -> Float -> Float

-- ageOn function definition
-- every function needs to be able to run independently of global state so
-- we're using local variables and the case statement as a map/dictionary
ageOn planet seconds = seconds / (secondsInOneEarthYear * orbitalPeriodFactor)
 where
  secondsInOneEarthYear = 365.25 * 24 * 60 * 60
  orbitalPeriodFactor   = case planet of
    Mercury -> 0.2408467
    Venus   -> 0.61519726
    Earth   -> 1.0
    Mars    -> 1.8808158
    Jupiter -> 11.862615
    Saturn  -> 29.447498
    Uranus  -> 84.016846
    Neptune -> 164.79132
