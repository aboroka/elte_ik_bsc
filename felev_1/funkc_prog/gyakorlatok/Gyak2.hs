id' :: a -> a
id' x = x

firstParam :: a -> b -> a
firstParam x y = x

isEven :: Integral a => a -> Bool
isEven n = n `mod` 2 == 0

double :: Num a => a -> a
double x = x + x

isZero :: Int -> Bool
isZero 0 = True
isZero _ = False

oneDigitPrime :: Int -> Bool
--oneDigitPrime x = (x ==2) || (x == 3)
oneDigitPrime 2 = True
oneDigitPrime 3 = True
oneDigitPrime 5 = True
oneDigitPrime 7 = True
oneDigitPrime _ = False

{- 
asfaf
safa
-}

not' :: Bool -> Bool
not' True = False
not' False = True

and' :: Bool -> Bool -> Bool
and' True True = True
--and' True False = False
--and' False True = False
--and' False False = False
and' _ _ = False
