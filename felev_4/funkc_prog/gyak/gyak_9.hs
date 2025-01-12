module Gyak9 where

import Data.Char

{-- 

--}

data INode = File String Integer | Directory String Integer
    deriving (Eq, Show)

type INodes = [INode]

delEmptyFolders :: INodes -> INodes
delEmptyFolders [] = []
delEmptyFolders (Directory _ 0:xs) = delEmptyFolders xs
delEmptyFolders (x:xs) = x : delEmptyFolders xs

filesStartingHf :: INodes -> Int
filesStartingHf [] = 0
filesStartingHf (File s _:xs)
    | (toLowerList (take 2 s)) == "hf" = 1 + filesStartingHf xs
    | otherwise = filesStartingHf xs
filesStartingHf _ = 0

toLowerList :: String -> String
toLowerList [] = []
toLowerList (s:ss) = toLower s : toLowerList ss

searchFolder :: INodes -> String -> Maybe INode
searchFolder [] s = Nothing
searchFolder ((Directory s n):xs) st
    | s == st = Just (Directory s n)
    | otherwise = searchFolder xs st
searchFolder ((File s n):xs) st = searchFolder xs st

largestFile :: INodes -> Maybe INode
largestFile [] = Nothing
largestFile [File s t] = Just (File s t)
largestFile [File s n,File t d]
    | n < d = Just (File t d)
    | otherwise = Just (File s n)
largestFile [File s n, Directory t d] = Just (File s n)
largestFile (File s n:File t d:xs)
    | n < d = largestFile ((File t d) : xs)
    | n > d = largestFile ((File s n) : xs)
    | otherwise = Nothing
largestFile (File s n:Directory t d:xs) = largestFile ((File s n) : xs)
largestFile (_:xs) = largestFile xs

filterFiles :: INodes -> INodes
filterFiles [] = []
filterFiles (File x y:xs) = (File x y) : filterFiles xs
filterFiles (_:xs) = filterFiles xs

largestFile' :: INodes -> Maybe INode
largestFile' [] = Nothing
largestFile' f@[a] = Just a
largestFile' f@[File s t,File a b]
    | t < b = Just (File a b)
    | otherwise = Just (File s t)
largestFile' (f@(File s t:File a b:xs))
    | t < b = largestFile' ((File a b):xs)
    | otherwise = largestFile' ((File s t):xs)
largestFile' (_:xs) = Nothing
    where 
        f = filterFiles f

{-- largestSSD :: [Storage] -> Maybe Storage
largestSSD [] = Nothing
largestSSD (SSD s x) = Just (SSD s x)
largestSSD (SSD s x:xs)
    | x > maxNum = Just (SSD s x)
    | otherwise = maxNum
    where maxNum = largestSSD xs --}

{-- házi függvénypróbálkozások:

timeTable :: [Time] -> Time -> Int -> Maybe Time
timeTable (Time h m:xs) (Time h1 m1) d = --}

{-- 
summerVacation :: [Weather] -> [Weather]
summerVacation [] = []
summerVacation (Sunny:xs) = Sunny : summerVacation xs
summerVacation (Cloudy:xs) = Cloudy : summerVacation xs
summerVacation (_:xs) = summerVacation xs

splitOnes :: [Int] -> [[Int]]
splitOnes [] = []
splitOnes (x:xs)
    | x == 1 = let (ones, rest) = span (== 1) xs in (x:ones) : splitOnes rest
    | otherwise = splitOnes xs

maxPrecipitation x = sum [d | Rainy d <- x]

--maxPrecipitation x = addRains (head [u | (v,u) <- zip listOfLengths splittedDays, v == maximum listOfLengths])

--listOfLengths = map length (splittedDays)

--}