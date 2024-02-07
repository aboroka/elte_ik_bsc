module Homework11 where

import Data.Char

testFile0 :: File 
testFile0 = ["asd  qwe", "-- Foo", "", "\thello world "]

type Line = String
type File = [Line]

countWordsInLine :: Line -> Int
countWordsInLine a = length(words a)

countWords :: File -> Int
countWords x = foldr ((+).countWordsInLine) 0 x

countChars :: File -> Int
countChars x = sum (map length x)

capitalizeWordsInLine :: Line -> Line
capitalizeWordsInLine a = unwords [toUpper y : ys | (y:ys) <- words a]

isComment :: Line -> Bool
isComment (x:y:ys) 
    | x == '-' && y == '-' = True
    | otherwise = False

dropComments :: File -> File
dropComments x = filter ((not).(isComment)) x 

numberLines :: File -> File
numberLines = zipWith (++) [show x ++ ": " | x <- [1..]]

dropTrailingWhitespaces :: Line -> Line
dropTrailingWhitespaces xs = reverse $ dropWhile isSpace $ reverse xs

replaceTab :: Int -> Char -> [Char]
replaceTab x y
    | y == '\t' = replicate x ' '
    | otherwise = [y]

replaceTabs :: Int -> File -> File
replaceTabs x = map (concatMap $ replaceTab x)