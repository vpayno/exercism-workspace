module Triangle
  ( TriangleType(..)
  , triangleType
  ) where

data TriangleType = Equilateral
                  | Isosceles
                  | Scalene
                  | Illegal
                  deriving (Eq, Show)

-- http://learnyouahaskell.com/types-and-typeclasses#:~:text=is%20called%20a-,class%20constraint.,-We%20can%20read
triangleType :: (Num a, Ord a) => a -> a -> a -> TriangleType

triangleType a b c | isEquilateral a b c = Equilateral
                   | isIsosceles a b c   = Isosceles
                   | isScalene a b c     = Scalene
                   | otherwise           = Illegal

isTriangle :: (Num a, Ord a) => a -> a -> a -> Bool
isTriangle a b c | a <= 0 || b <= 0 || c <= 0             = False
                 | a + b >= c && a + c >= b && b + c >= a = True
                 | otherwise                              = False

isEquilateral :: (Num a, Ord a) => a -> a -> a -> Bool
isEquilateral a b c | not (isTriangle a b c) = False
                    | a == b && a == c       = True
                    | otherwise              = False

isIsosceles :: (Num a, Ord a) => a -> a -> a -> Bool
isIsosceles a b c
  | not (isTriangle a b c) = False
  | a == b && a /= c || b == c && b /= a || a == c && a /= b = True
  | otherwise              = False

isScalene :: (Num a, Ord a) => a -> a -> a -> Bool
isScalene a b c | not (isTriangle a b c)     = False
                | a /= b && a /= c && b /= c = True
                | otherwise                  = False
