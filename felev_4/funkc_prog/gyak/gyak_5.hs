module Gyak5 where

less :: Ord a => a -> a -> a
less x y
    | x < y = x
    | otherwise = y -- ez lehetne True = y is

g :: [([a],[b])] -> String --  [("asd","sdf"),("","gfh"),("","")] vagy [([1..10],[7,8]),([],[2,3]),([],[])]
g (_:([],(_:x)):[_]) = "ok" -- parciális függvény?

hasEmpty :: [[a]] -> Bool
hasEmpty [] = False
hasEmpty (x:xs) =  length x == 0 || hasEmpty xs
    -- | length x == 0 =  True
    -- | otherwise = length x == 0 && hasEmpty xs

--hasEmptyOra :: Eq a => [[a]] -> Bool
--hasEmptyOra (x:xs)
--    | x == [] = True
--    | otherwise = hasEmptyOra xs

hasEmptyOra :: [[a]] -> Bool
hasEmptyOra [] = False
hasEmptyOra ([]:xs) = True
hasEmptyOra (x:xs) =  hasEmptyOra xs

length3lists :: [[a]] -> [[a]] -- nem működik végtelenre
length3lists [] = []
length3lists (x:xs)
    | length x == 3 = x : length3lists xs
    | otherwise = length3lists xs

{-- órai:
length3lists :: [[a]] -> [[a]] 
length3lists [] = []
length3lists (x@(_:_:_:[]):xs) = x : length3lists xs
length3lists (x:xs) = length3lists xs
    
--}

len3 :: [a] -> Bool
len3 (_:_:_:[]) = True
len3 _ = False

first4 :: [a] -> [a]
first4 (x:y:z:t:xs) = [x,y,z,t]

findWord :: [String] -> String
findWord [] = []
findWord (x:xs) 
    | oneAndThree x = x
    | otherwise = findWord xs

oneAndThree :: String -> Bool
oneAndThree (x:y:z:xs) = x == z

duplicateElements :: [a] -> [a]
duplicateElements [] = []
duplicateElements (x:xs) = x : x : duplicateElements xs

everySecond :: [a] -> [a]
everySecond [] = []
everySecond (x:[]) = []
everySecond (x:y:xs) = y : everySecond xs

pizza :: [(String, Int)] -> Int
pizza [] = 0
pizza ((x,y):[]) = y + 500
pizza ((x,y):xs) = y + pizza xs

take' :: Int -> [a] -> [a]
take' 0 (x:xs) = []
take' _ (x:[]) = [x]
take' n (x:xs) = x : take' (n-1) xs

drop' :: Int -> [a] -> [a]
drop' 0 x = x
drop' _ (x:[]) = []
drop' n (x:xs) = drop' (n-1) xs

isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] y = True
isPrefixOf x [] = False
isPrefixOf (x:[]) (y:ys) = x == y  
isPrefixOf (x:xs) (y:ys) = x == y && isPrefixOf xs ys

sortTuples :: Ord a => [(a,a)] -> [(a,a)]
sortTuples [] = []
sortTuples ((x,y):xs) 
    | x > y = (y,x) : sortTuples xs
    | otherwise = (x,y) : sortTuples xs

keepIncreasingTriples :: Ord a => [(a,a,a)] -> [(a,a,a)]
keepIncreasingTriples [] = []
keepIncreasingTriples ((x,y,z):xs)
    | x < y && y < z = (x,y,z) : keepIncreasingTriples xs
    | otherwise = keepIncreasingTriples xs

{--deleteEveryThird :: [a] -> [a]
deleteEveryThird [] = []
deleteEveryThird (x:y:z:xs) 
    | (length (x:xs)) <= 2 = x:xs
    | (length (x:y:z:xs)) `mod` 3 == 0 = x : y : deleteEveryThird xs
    | (length (x:y:z:xs)) `mod` 3 == 1 = x : deleteEveryThird xs
    | otherwise = deleteEveryThird xs --}

deleteEveryThird :: [a] -> [a]
deleteEveryThird [] = []
deleteEveryThird xs = deleteEveryThird' 1 xs
  where
    deleteEveryThird' _ [] = []
    deleteEveryThird' n (x:xs)
        | n `mod` 3 == 0 = deleteEveryThird' (n+1) xs
        | otherwise = x : deleteEveryThird' (n+1) xs
		
alternate :: [a] -> [a] -> [a]
alternate [] [] = []
alternate (x:xs) (y:ys) = x : alternate ys xs
