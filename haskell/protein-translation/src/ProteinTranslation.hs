module ProteinTranslation
  ( proteins
  ) where

codonToProtein :: [(String, String)]
codonToProtein =
  [ ("AUG", "Methionine")
  , ("UUU", "Phenylalanine")
  , ("UUC", "Phenylalanine")
  , ("UUA", "Leucine")
  , ("UUG", "Leucine")
  , ("UCU", "Serine")
  , ("UCC", "Serine")
  , ("UCA", "Serine")
  , ("UCG", "Serine")
  , ("UAU", "Tyrosine")
  , ("UAC", "Tyrosine")
  , ("UGU", "Cysteine")
  , ("UGC", "Cysteine")
  , ("UGG", "Tryptophan")
  , ("UAA", "STOP")
  , ("UAG", "STOP")
  , ("UGA", "STOP")
  ]

getCodons :: String -> [(String, String)] -> Maybe String
getCodons _ [] = Nothing
getCodons codon ((c, a) : xs) | codon == c = Just a
                              | otherwise  = getCodons codon xs

proteins :: String -> Maybe [String]
proteins []               = Just []
proteins [_]              = Just []
proteins [_, _]           = Just []
proteins (x : y : z : xs) = case getCodons [x, y, z] codonToProtein of
  Just "STOP" -> Just []
  Just codon  -> proteins xs >>= (\protein -> return $ codon : protein)
  Nothing     -> Nothing
