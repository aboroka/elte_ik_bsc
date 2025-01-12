module Vizsga where

import Data.Maybe
import Data.Char
import Data.List

-- 1. feladat - 2p
keepEvenIndexes :: [a] -> [a] -> [a]
keepEvenIndexes [] (y:w:ys) = w : keepEvenIndexes [] ys
keepEvenIndexes (x:z:xs) [] = z : keepEvenIndexes xs []
keepEvenIndexes [x,y] [z] = [y]
keepEvenIndexes [x] [z,y] = [y]
keepEvenIndexes (x:z:xs) (y:w:ys) = z : w : keepEvenIndexes xs ys
keepEvenIndexes _ _ = []

-- 2. feladat - 2p
isIncreasing :: (Ord a) => [a] -> Bool 
isIncreasing [] = True
isIncreasing [x] = True
isIncreasing [x,y] = x < y
isIncreasing (x:y:xs)
    | x < y = isIncreasing (y:xs)
    | otherwise = False

-- 3. feladat - 2p
sumLargerBefore :: (Ord a, Num a) => [a] -> Bool
sumLargerBefore [] = False
sumLargerBefore xs = eleje > vege
    where
        eleje = sum (takeWhile (> 0) xs)
        others = dropWhile (> 0) xs
        negative = head others
        vege = sum (tail others)

-- 4. feladat - 2p
sumTuples :: Num a => [(a, a)] -> (a, a)
sumTuples [] = (0,0)
sumTuples xs = (firsts, seconds)
    where
        firsts = sum $ map fst xs
        seconds = sum $ map snd xs

-- 5. feladat - 2p
aliveTrees :: [(Int, Maybe String)] -> [(Int, Maybe String)]
aliveTrees [] = []
aliveTrees ((age,tree):xs)
    | isNothing tree = aliveTrees xs
    | otherwise = (age + 1, tree) : aliveTrees xs

-- 6. feladat
{-- separate :: Int -> Int -> [a] -> [[a]]
separate _ _ [] = []
separate n m xs = seged n list --take n list : separate n m (drop n list)
    where
        list = [x | (x,y) <- zip xs [1..], y `mod` m /= 0] 
        seged n [] = []
        seged n xs = take n xs : seged n (drop n xs) --}

--separate :: Int -> Int -> [a] -> [[a]]
--separate _ _ [] = []
--separate n m xs = take n xs : separate n m (drop (m-n) dr)
--    where
--        dr = drop n xs

-- 7. feladat - 3p
type Suly = Integer

data Hal = Keszeg Suly | Harcsa Suly | Karasz Suly | Ponty Suly
    deriving (Eq, Show)

type Szak = [Hal]

data Horgaszhely = Versenyzo String Int Szak
    deriving (Eq, Show)

type Verseny = [Horgaszhely]

summarize :: Verseny -> [(String, Int, Suly)]
summarize [] = []
summarize ((Versenyzo s n xs):ts) = (s, n, suly) : summarize ts
        where
            getSuly (Keszeg d) = d
            getSuly (Karasz d) = d
            getSuly (Ponty d) = d
            getSuly (Harcsa d) = 0
            suly = sum $ map getSuly xs

-- 8. feladat
--evenDigits :: (Integral a) => a -> Int
