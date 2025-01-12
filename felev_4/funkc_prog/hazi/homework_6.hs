module Homework6 where

import Data.Char

hash :: String -> Integer
hash "" = 0
hash (x:xs) = hashPos 1 (x:xs)
    where
        hashPos _ [] = 0
        hashPos n (x:xs) = (2^(fromIntegral (ord x))* n) + hashPos (n+1) xs

caesarEncrypt :: String -> Int -> String
caesarEncrypt [] _ = []
caesarEncrypt (x:xs) n 
    | (ord x) + n > (ord 'z') = chr ((ord x - 26) + n) : caesarEncrypt xs n
    | otherwise = chr ((ord x) + n) : caesarEncrypt xs n

listDiff :: Eq a => [a] -> [a] -> [a]
listDiff _ [] = []
listDiff [] _ = []
listDiff (x:xs) y
    | element x y = listDiff xs y
    | otherwise = x : listDiff xs y
    where
        element e [] = False
        element e (l:ls) = (e == l) || element e ls

validGame :: String -> Bool
validGame [] = False
validGame x = validGameChecker (words x)
    where
        validGameChecker [] = False
        validGameChecker [_] = False
        validGameChecker [go,gt] = head gt == last go
        validGameChecker (go:gt:gs) = (head gt == last go) && (validGameChecker (gt : gs))
