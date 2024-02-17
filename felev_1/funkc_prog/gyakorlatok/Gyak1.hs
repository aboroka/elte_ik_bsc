module Gyak1 where

one :: Int 
one = 1

two :: Int
two = one + 1

-- comment
inc :: Int -> Int
inc x = x + one

add :: Int -> Int -> Int
add x y = x + y 

isEven :: Int -> Bool
isEven n = n `mod` 2 == 0

isOdd :: Int -> Bool
isOdd n = not (isEven n)