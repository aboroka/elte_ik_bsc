module Gyak5 where

duplicateElements :: [a] -> [a]
duplicateElements [] = []
duplicateElements (x:xs) = x : x : duplicateElements xs
-- [1,2,3]
-- 1 : 1 : (2 : 2 : (3 : 3 : []))

everySecond :: [a] -> [a]
everySecond [] = []
everySecond [x] = []
everySecond [x,y] = [y]
everySecond (x:y:xs) = y : everySecond xs

take' :: Int -> [a] -> [a]
take' _ [] = []
take' 0 _ = []
take' n (x:xs) 
    | n <= 0 = [] 
    | n > 0 =  x : take' (n-1) xs 

isPrefixOf ::  Eq a => [a] -> [a] -> Bool
--isPrefixOf [] [] = True
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (x:xs) (y:ys)
    | x == y = isPrefixOf xs ys
    | otherwise = False
--isPrefixOf (x:xs) (y:ys) = x == y && isPrefixOf xs ys

merge :: Ord a => [a] -> [a] -> [a]
--merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x == y x : merge xs ys
    | x < y = x : merge xs (y:ys)
    | x > y = y : merge (x:xs) ys
	
sublist :: Int -> Int -> [a] -> [a]
sublist _ _ [] = []
--sublist 0 0 _ = []
sublist n 0 _ = []
sublist n m (x:xs) = sublist (n-1) m xs
sublist 0 m (x:xs) = x : sublist 0 (m-1) xs

pizza' :: [(String, Int)]