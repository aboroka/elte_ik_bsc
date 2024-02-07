module Homework6 where

import Data.List
import Data.Char

listDiff :: Eq a => [a] -> [a] -> [a]
listDiff [] _ = []
listDiff (x:xs) y
    | any (==x) y = listDiff xs y
    | otherwise = x : listDiff xs y

validGame ::  String -> Bool
validGame [] = True
validGame [_, _] = True
validGame (x:y:z:xs)
    | y == ' ' && x == z = validGame (y:z:xs)
    | y == ' ' && x /= z = False
    | otherwise = validGame (y:z:xs)

countSingletons :: Eq a => [[a]] -> Int
countSingletons [] = 0
countSingletons (x:xs)
    | seged x = 1 + countSingletons xs
    | otherwise = countSingletons xs
    where
        seged :: Eq a => [a] -> Bool
        seged [_] = True
        seged _ = False

sameParity :: [Int] -> Bool
sameParity [_] = True
sameParity [] = True
sameParity (x:y:xs)
    | x `mod` 2 == y `mod` 2 = sameParity (y:xs)
    | otherwise = False

longestChain :: String -> Int
longestChain [] = 0
longestChain x = seged (group x)
    where
        seged :: [[a]] -> Int
        seged [x] = sum [1 | y <- x]
        seged (x:y:xs)
            | length x > length y = seged (x:xs)
            | otherwise = seged (y:xs)

normalizeText :: String -> String
normalizeText [] = []
normalizeText (x:xs)
    | any (==x) ['a'..'z'] = toUpper x : normalizeText xs
    | any (==x) ['A'..'Z'] = x : normalizeText xs
    | otherwise = normalizeText xs