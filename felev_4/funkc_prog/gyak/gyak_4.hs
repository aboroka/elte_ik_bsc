module Gyak4 where

-- lista generátorok

allTimes :: [(Int,Int)]
allTimes = [(x,y) | x <- [0..23], y <- [0..59]]

{-- factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factors n == [1,n] --}

isPrime :: Int -> Bool
isPrime n = [x | x <- [1..n], n `mod` x == 0] == [1,n]

countSpace :: [Char] -> Int
countSpace x = sum [1 | x <- x, x == ' ']

pizza :: [([Char], Integer)] -> Integer
pizza xs = sum [c | (_,c) <- xs] + 500

-- minták listákra

null' :: [a] -> Bool
null' [] = True
null' _ = False

head' :: [a] -> a
head' (x:xs) = x

tail' :: [a] -> [a]
tail' (x:xs) = xs

isSingleton :: [a] -> Bool
isSingleton [] = False
isSingleton (x:[]) = True
isSingleton _ = False

headZero :: (Num a, Eq a) => [a] -> Bool
headZero [] = False
headZero (x:xs) = x == 0

fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact (n-1)

sumN :: Integer -> Integer
sumN 0 = 0
sumN n = n + sumN (n-1)

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length' xs

sum' :: Num a => [a] -> a
sum' [] = 0 
sum' (x:xs) = x + sum' xs

last' :: [a] ->  a
last' [] = error "Empty list"
last' (x:[]) = x
last' (x:xs) = last' xs

init' :: [a] -> [a]
init' [] = error "Empty list"
init' (x:[]) = [] 
init' (x:xs) = x : init' xs

