module Homework8 where

data T = A String Int | B String Int | C

f :: [T] -> Int
f (_:_:B _ 1:_)            = 0
f (_:_:B [] _:[])          = 1
f (_:A [_] _:B [] _:[xs])  = 2
f (_:A _ _:B _ _:xs)       = 3

g :: [T]
g = [C, A "a" 2, B "" 3, C]

triangleArea :: (Double, Double, Double) -> Maybe Double
triangleArea (a,b,c)
    | (a < 0) || (b < 0) || (c < 0) = Nothing
    | (a + b) < c || (a + c) < b || (b + c) < a = Nothing
    | a^2 + b^2 /= c^2 = Nothing 
    | otherwise = Just ((a * b) / 2)

data Storage = HDD String Int Int | SSD String Int 
    deriving (Show, Eq)

largestSSD :: [Storage] -> Maybe Storage
largestSSD [] = Nothing
largestSSD [SSD s d] = Just (SSD s d)
largestSSD [HDD _ _ _] = Nothing
largestSSD [SSD s1 d1,SSD s2 d2]
    | d1 < d2 = Just (SSD s2 d2)
    | otherwise = Just (SSD s1 d1)
largestSSD (HDD _ _ _:xs) = largestSSD xs
largestSSD (SSD s1 d1:SSD s2 d2:xs)
    | d1 < d2 = largestSSD ((SSD s2 d2): xs)
    | otherwise = largestSSD ((SSD s1 d1): xs)

hugeHDDs :: [Storage] -> [Storage]
hugeHDDs [] = [] 
hugeHDDs (HDD s d n:xs)
    | n > hddNum (largestSSD (HDD s d n:xs)) = (HDD s d n) : hugeHDDs xs
    | otherwise = hugeHDDs xs
    where
        hddNum Nothing = 0
        hddNum (Just (SSD s d)) = d
hugeHDDs (SSD _ _:xs) = hugeHDDs xs