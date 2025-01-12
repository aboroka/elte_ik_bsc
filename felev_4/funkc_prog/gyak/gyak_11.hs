module Gyak11 where

import Data.Char
import Data.List

{-- ELMÉLET

--}

-- 10. gyak elmaradt anyag

f1 :: Int -> Bool
f1 a = even a && a `mod` 5 == 0
-- (\x -> even x && x `mod` 5 == 0) 10
    
f2 :: Num a => a -> a -> a
f2 a b = a^2 + b^2
-- (\x y -> x^2 + y^2) 10 12

f3 :: (b, a) -> (a, b, a)
f3 (a,b) = (b,a,b)
-- (\(x,y) -> (y,x,y)) (10,1)

f4 :: [b] -> ([b], b)
f4 (x:xs) = (xs, x)
-- (\(x:xs) -> (xs,x)) [1..10] 

--evenList :: Integral a => [[a]] -> [[a]]


--11. gyak

c :: (a -> b -> c) -> (b -> a -> c)
c f a b = b `f` a

w :: (a -> a -> a) -> a -> a
w f x = x `f` x

mapFuns :: a -> [(a -> b)] -> [b]
mapFuns a [] = []
mapFuns a (f:fs) = (f a) : mapFuns a fs

ntimes :: (a -> a -> a) -> a -> Int -> a
ntimes f a 1 = a
ntimes f a n = a `f` (ntimes f a (n-1))

selectUnless :: (t -> Bool) -> (t -> Bool) -> [t] -> [t]
selectUnless p1 p2 [] = []
selectUnless p1 p2 (x:xs)
    | p1 x && not (p2 x) = x : selectUnless p1 p2 xs
    | otherwise = selectUnless p1 p2 xs

selectiveApply :: (a -> a) -> (a -> Bool) -> [a] -> [a]
selectiveApply f p [] = []
selectiveApply f p (x:xs)
    | p x = f x : selectiveApply f p xs
    | otherwise = x : selectiveApply f p xs

applyWithDefault :: (a -> Bool) -> (a -> b) -> b -> [a] -> [b]
applyWithDefault