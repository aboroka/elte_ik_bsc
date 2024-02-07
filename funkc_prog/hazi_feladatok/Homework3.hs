module Homework3 where

onAxis :: (Int, Int) -> Bool
onAxis (0,0) = True
onAxis (_,0) = True
onAxis (0,_) = True
onAxis _ = False

shift :: (Int, Int) -> Int -> (Int,Int)
shift (x,y) z = ((x+((y+z)`div` 60)) `mod` 24, (y+z) `mod` 60)

divisors :: Int -> [Int]
divisors n = [x | x <- [1.. n-1], n `mod` x == 0]

sumDiv :: Int -> Int
sumDiv x = sum(divisors x)

areAmicableNumbers :: Int -> Int -> Bool
areAmicableNumbers x y = (sumDiv x == y) && (sumDiv y == x)