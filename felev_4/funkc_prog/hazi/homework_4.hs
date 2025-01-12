module Homework4 where

headTail :: [a] -> (a, [a])
headTail (x:xs) = (x, xs)

doubleHead :: [a] -> [b] -> (a, b)
doubleHead (x:xs) (y:ys) = (x,y)

changeHead :: [a] -> a -> [a]
changeHead (x:xs) y = y : xs

password :: [Char] -> [Char]
password [] = []
password (x:xs) = '*' : password xs

filterIncPairs :: Ord a => [(a,a)] -> [(a,a)]
filterIncPairs [] = []
filterIncPairs (x:xs) 
    | firstSmaller x = x : filterIncPairs xs
    | otherwise = filterIncPairs xs

firstSmaller :: Ord a => (a,a) -> Bool
firstSmaller (x,y) = x < y
