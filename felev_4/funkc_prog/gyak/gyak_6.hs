module Gyak6 where

import Data.Char

f :: Int
f = g where
    g :: Int
    g = 1

g :: String
g = "Hello"

h :: Int -> [Int]
h x = [x | x <- [1..10]]

{-- isLonger :: [a] -> [a] -> Bool
isLonger [] [] = False
isLonger x y 
    | length x >= length y = True
    | otherwise = False -}

minToHour :: Int -> (Int, Int)
minToHour x = (h, m)
    where 
        h = x `div` 60
        m = x - (h*60)

isLonger :: [a] -> [a] -> Bool
isLonger [] [] = False
isLonger _ [] = True
isLonger [] _ = False
isLonger (x:xs) (y:ys) = isLonger xs ys

zip' :: [a] -> [b] -> [(a,b)]
zip' [] [] = []
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys


toUpperFirsts :: String -> String
toUpperFirsts [] = []
toUpperFirsts x = unwords [ toUpperOne x | x <- (words x)]

toUpperOne :: String -> String
toUpperOne (x:xs) = toUpper x : xs

cipher :: String -> String
cipher [] = []
cipher (x:y:z:xs) 
    | isDigit z = x : y : []
    | otherwise = cipher (y : z : xs)
cipher _ = []

{-- identifier :: String -> Bool
identifier "" = False
identifier (x:xs)
    | length (x:xs) == 1 = (isUpper x || isLower x)
    | otherwise = (isUpper x || isLower x) && theRest xs
    where
        theRest (x:xs) 
            | isUpper x || isLower x || isDigit x || x == '_' = True && theRest xs
            | otherwise = False
        theRest _ = False --}

identifier :: String -> Bool
identifier "" = False
identifier (x:xs) = (isUpper x || isLower x) && theRest xs
    where 
        theRest "" = True
        theRest (x:xs) = (isLower x || isUpper x || isDigit x || x == '_') && theRest xs
        theRest _ = False

endOfList :: [a] -> [a]
endOfList (x:xs) = xs

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
