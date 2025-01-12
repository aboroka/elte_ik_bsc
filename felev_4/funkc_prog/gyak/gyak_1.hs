module Gyak1 where

one :: Int
one = 1

inc :: Int -> Int
inc x = x + 1

-- (+) 2 2 = 4 meg infix: `div` (röpikre példa lehet)

add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

double :: Int -> Int
double x = x + x

areTriangleSides :: Real a => a -> a -> a -> Bool
areTriangleSides a b c = (a + b) > c && (a + c) > b && (b + c) > a
 
myEven :: Int -> Bool
myEven x = x `mod` 2 == 0

myOdd :: Int -> Bool
myOdd x = not (myEven x)

leapYear :: Int -> Bool
leapYear x = (x `mod` 4 == 0 && x `mod` 100 /= 0) || x `mod` 400 == 0