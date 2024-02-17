module Gyak4 where

fact :: Integer -> Integer
fact 0 = 1
fact n
    | n < 0 = 0
    | n >= 0 = n * fact (n-1)
--  | otherwise = 42

null' :: [a] -> Bool
null' [] = True
null' _ = False

head' :: [a] -> a
head' (x:_) = x

--parciális függvény: nincs minden létező esetre definiálva

tail' :: [a] -> [a]
tail' (_:xs) = xs

isSingleton :: [a] -> Bool
isSingleton [_] = True
isSingleton _ = False

length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length' xs