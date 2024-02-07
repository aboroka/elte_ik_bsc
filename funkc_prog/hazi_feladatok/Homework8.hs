module Homework8 where

data Base = A | T | G | C 
    deriving (Eq, Show)

isComplement :: [Base] -> [Base] -> Bool
isComplement [] [] = True
isComplement (x:xs) (y:ys)
    | seged x y = isComplement xs ys
    | otherwise = False
    where
        seged :: Base -> Base -> Bool
        seged x y
            | A == x && T == y = True
            | T == x && A == y = True
            | C == x && G == y = True
            | G == x && C == y = True
            | otherwise = False

data Transaction = Transfer Int Int | Purchase Int | Receive Int Int String
    deriving (Show)

netGain :: [Transaction] -> Int
netGain [] = 0
netGain ((Transfer x _):xs) = (-x) + netGain xs
netGain ((Purchase x):xs) = (-x) + netGain xs
netGain ((Receive x _ _):xs) = x + netGain xs

netGain' :: [Transaction] -> [Int]
netGain' [] = []
netGain' ((Transfer x _):xs) = (-x) : netGain' xs
netGain' ((Purchase x):xs) = (-x) : netGain' xs
netGain' ((Receive x _ _):xs) = x : netGain' xs

seged :: [Int] -> Bool
seged [] = False
seged [x] = x < 0
seged (x:y:xs)
    | x < 0 = True
    | otherwise = seged ((x + y):xs)

wasNegative :: [Transaction] -> Bool
wasNegative x = seged (netGain' x)

foo1 :: ([[a]],([a],String)) -> Int
foo1 ([_],(a:b,"Hello")) = 0
foo1 ([_],(a:b,'H':'e':'l':'l':'o':xs)) = 1
foo1 ([_,_,_],(a:b,'H':'e':'l':'l':'o':_:_:[])) = 2

foo1Solution1 = ([[1,2]],([3],"Hello world!")) 
foo1Solution2 = ([[1],[2],[3]],([3],"Hellooo"))

data Gyumolcs = Alma Int Char | Barack | Cseresznye String

foo2 :: (Gyumolcs, String) -> Int
foo2 (Alma 12 'a', "Piros") = 0
foo2 (Barack, 's':'a':xs) = 1
foo2 (Cseresznye ('p':xs), 'p':[]) = 2

foo2Solution2 = (Cseresznye (['p','q']), ['p'])