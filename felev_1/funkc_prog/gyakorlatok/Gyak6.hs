module Gyak6 where
import Data.Char

cipher :: String -> String
cipher (x:y:z:xs)
   | isLetter x && isLetter y && isDigit z = [x,y]
   | otherwise = cipher (y:z:ys)
cipher _ = []

zip' :: [a] -> [b] -> [(a,b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys
--zip' _ _ = []

g :: Int
g = 2

f :: Int
f = g where
	g ::Int
	g = 1