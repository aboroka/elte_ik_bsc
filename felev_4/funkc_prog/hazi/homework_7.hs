module Homework7 where

data RPS = Rock | Paper | Scissors
    deriving (Show, Eq)

firstPlayerWon :: [(RPS, RPS)] -> Int
firstPlayerWon [] = 0
firstPlayerWon ((a,b):xs) 
    | a == Rock && b == Scissors = 1 + firstPlayerWon xs
    | a == Paper && b == Rock = 1 + firstPlayerWon xs
    | a == Scissors && b == Paper = 1 + firstPlayerWon xs
    | otherwise = firstPlayerWon xs

data Box = Empty | B Int 
    deriving (Show, Eq)

increasingBoxes :: Int -> Int -> [Box]
increasingBoxes 0 0 = repeat Empty
increasingBoxes 0 m = Empty : [B e | e <- [1..], e `mod` m == 0]
increasingBoxes n m = [B e | e <- [n..], (e - n) `mod` m == 0]


packBoxes :: [Box] -> Box
packBoxes x 
    | count x /= 0 = B (count x)
    | otherwise = Empty
    where
        count [] = 0
        count (B x:xs) = x + count xs
        count (Empty:xs) = count xs


mergeBoxes :: [Box] -> [Box] -> [Box]
mergeBoxes [] _ = []
mergeBoxes _ [] = []
mergeBoxes (B x:xs) (B y:ys) = B (x + y) : mergeBoxes xs ys
mergeBoxes (Empty:xs) (Empty:ys) = Empty : mergeBoxes xs ys 
mergeBoxes (Empty:xs) (y:ys) = y : mergeBoxes xs ys
mergeBoxes (x:xs) (Empty:ys) = x : mergeBoxes xs ys
 