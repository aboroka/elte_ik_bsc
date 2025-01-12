module Homework3 where

timeFromSec :: Int -> (Int, Int, Int)
timeFromSec n = (h,m,s)
    where
        h = n `div` 3600
        nd = n - h * 3600
        m = nd `div` 60
        nm = nd - m * 60
        s = nm

quadToList :: (a,a,a,a) -> [a]
quadToList (a,b,c,d) = [a,b,c,d]

numbers1 :: [Int]
numbers1 = [x | x <- [1000,999..0], x `mod` 5 == 3, (x*3) `mod` 7 == 2]

numbers2 :: [Int]
numbers2 = [x `div` 2 | x <- [0..500], x `mod` 7 == 3 && (x*2) `mod` 6 == 2, even x]

numbers3 :: [Int]
numbers3 = [x | x <- [1..100], (x `mod` 3 == 0 && x `mod` 5 /= 0)||( x `mod` 5 == 0 && x `mod` 3 /= 0), even x]
