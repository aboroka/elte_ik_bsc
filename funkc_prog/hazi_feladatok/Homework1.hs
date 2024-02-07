module Homework1 where

greater :: Int -> Int -> Bool
greater x y = x > y

rectPerimeter :: Int -> Int -> Int
rectPerimeter x y = (x + y)*2

isPythagoreanTriple :: Int -> Int -> Int -> Bool
isPythagoreanTriple x y z = (x * x) + (y * y) == (z * z) || (z * z) + (y * y) == (x * x) || (x * x) + (z * z) == (y * y)