module Homework5 where

toBin :: Integer -> [Int]
toBin n 
    | n == 0 = [0]
    | n == 1 = [1]
    | n `mod` 2 == 0 = 0 : toBin (n `div` 2)
    | n `mod` 2 == 1 = 1 : toBin (n `div` 2)

remdup :: Eq a => [a] -> [a]
remdup [] =  []
remdup [x] = [x]
remdup (x:xs)
    | x == head xs = remdup xs
    | otherwise = x : remdup xs

keepIncreasingTriples :: Ord a => [(a,a,a)] -> [(a,a,a)]
keepIncreasingTriples [] = []
keepIncreasingTriples ((x,y,z):xs)
    | x < y && y < z = (x,y,z) : keepIncreasingTriples xs
    | otherwise = keepIncreasingTriples xs

deleteEveryThird :: [a] -> [a]
deleteEveryThird [] = []
deleteEveryThird xs = deleteEveryThird' 1 xs
  where
    deleteEveryThird' _ [] = []
    deleteEveryThird' n (x:xs)
        | n `mod` 3 == 0 = deleteEveryThird' (n+1) xs
        | otherwise = x : deleteEveryThird' (n+1) xs

alternate :: [a] -> [a] -> [a]
alternate [] [] = []
alternate (x:xs) (y:ys) = x : alternate ys xs

