module Gyak2 where

{--
mintaillesztés
:r Gyak2 (reload, odakell irni a module nevet is)
--}

isZero :: Int -> Bool
isZero 0 = True
--isZero x = False
isZero _ = False

oneDigitPrime :: Int -> Bool
oneDigitPrime 2 = True
oneDigitPrime 3 = True
oneDigitPrime 5 = True
oneDigitPrime 7 = True
oneDigitPrime _ = False

and' :: Bool -> Bool -> Bool
and' True True = True
and' _ _ = False

or' :: Bool -> Bool -> Bool
or' False False = False
or' _ _ = True

xor' :: Bool -> Bool -> Bool
xor' True True = False
xor' False False = False
xor' _ _ = True

replaceNewline :: Char -> Char
replaceNewline '\n' = ' '
replaceNewline x = x

-- tuple

isEvenTuple ::Int -> (Int,Bool)
isEvenTuple x = (x, x `mod` 2 == 0)

isOrigo :: (Int, Int) -> Bool
isOrigo (0,0) = True
isOrigo(_,_) = False
-- isOrigo x = fst x == 0 && snd x == 0
-- isOrigo (x,y) = x == 0 && y == 0

-- (fst,snd) - lehet igy is hivatkozni rá

isOnXAxis :: (Int, Int) -> Bool
isOnXAxis (0,_) = True
isOnXAxis (_,_) = False

mul :: (Int, Int) -> (Int, Int) -> (Int, Int)
mul (x,y) (a,b) = (x * a, y * b)

swapInt :: (Int,Int) -> (Int,Int)
swapInt (x,y) = (y,x)

--parametrikus polimorfizmus
swap :: (a, b) -> (b, a)
swap (a, b) = (b, a)

triplicate :: a -> (a, a, a)
triplicate x = (x,x,x)

--ad-hoc polimorfizmus
double :: Num a => a -> a
double x = x + x

