module Homework10 where
import Data.Char

upperCharToLower :: String -> String
upperCharToLower s = map toLower (filter isUpper s)

swapIfCond :: (a -> Bool) -> [(a,a)] -> [(a,a)]
swapIfCond p [] = []
swapIfCond p ((a,b):xs) 
    | p a = (b,a) : swapIfCond p xs
    | otherwise = (a,b) : swapIfCond p xs 

findIndices :: (a -> Bool) -> [a] -> [Int]
findIndices p x = [v | (u,v) <- zip x [0..], p u]