module Homework5 where

password :: [Char] -> [Char]
password [] = []
password (x:xs) = '*' : password xs

lookup' :: Eq a => a -> [(a, b)] -> b
lookup' x ((a,b):xs)
    | x == a = b
    | x /= a = lookup' x xs

toBin :: Integer -> [Int]
toBin 0 = []
toBin x
    | x `mod` 2 == 0 = 0 : toBin (x `div` 2)
    | x `mod` 2 == 1 = 1 : toBin (x `div` 2)

remdup :: Eq a => [a] -> [a]
remdup [] = []
remdup (x:[]) = [x]
remdup (x:y:xs) 
    | x == y = remdup (x:xs)
    | x /= y = x : remdup (y:xs)