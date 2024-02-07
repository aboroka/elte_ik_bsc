module Homework4 where
headTail :: [a] -> (a, [a])
headTail (x:xs) = (x,xs)

doubleHead :: [a] -> [b] -> (a,b)
doubleHead a b = (head a, head b)

hasZero :: [Int] -> Bool
hasZero [] = False
hasZero (0:xs) = True
hasZero (x:xs) = hasZero xs

hasEmpty :: [[a]] -> Bool
hasEmpty [] = False 
hasEmpty ([]:xs) = True
hasEmpty (x:xs) = hasEmpty xs

doubleAll :: [Int] -> [Int]
doubleAll [] = []
doubleAll (x:xs) = x*2:doubleAll xs

last' :: [a]{-nemüres-} -> a
last' [x] = x
last' (x:xs) = last' xs

init' :: [a]{-nemüres-} -> [a]
init' [x] = []
init' (x:xs) = x:init' xs