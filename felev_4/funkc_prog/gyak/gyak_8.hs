module Gyak8 where

import Data.Maybe

{-- 
ELMÉLET
kövi potenciális röpi: a mintaillesztéses cucc gyakból (péksüti)
--}

-- feladat: definiáljunk fv-et, amely eloallit egy sorozatot
-- paraméterek: sorozat első eleme, lépték
-- ez a végtlene sorra ahol nincs base case (vagyis nem kötelező a base case a rekuzional)

sor :: Int -> Int -> [Int]
sor n d = n : sor (n + d) d

-- [0,5..], most sor 0 5 (ezek ekvivalensek)

-- ilyesmi lesz a plusz minusz kövi órán
data Peksuti = Kifli String | Zsemle String Bool | KakaosCsiga Int

f :: [Peksuti] -> Int
f (_:_:Zsemle _ True:_) = 0
f (_:_:Zsemle [] _:[]) = 1
f (_:Kifli [_]:Zsemle [] _:[xs]) = 2
f (_:Kifli _:Zsemle _ _:xs) = 3

data MaybeInt = MyNothing | MyJust Int 
    deriving (Eq, Show)

-- muvelet nem biztos hogy elvegezeheto pl osztas nullaval
-- ilyenkor lesz a nothing a visszérték

safeDivInt :: Int -> Int -> MaybeInt
safeDivInt x 0 = MyNothing
safeDivInt x y = MyJust (x `div` y)

safeMaximum :: [Int] -> MaybeInt
safeMaximum [] = MyNothing
safeMaximum x = MyJust (maximum x)

-- preludebe van maybe
-- ne másoljuk be fájlba mert megcseszi

-- Tárol egy `a` típusú értéket, vagy semmit
-- Az `a` a típusváltozó

safeDiv :: (Integral a) => a -> a -> Maybe a
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x

-- seged függvények: lambdába (fuggvebyosszefoglalo, aztán maybe-re keresés)
-- Data.Maybe-t m be kell importnálni mert nincs preludebe


maybeAdd :: Num a => Maybe a -> Maybe a -> Maybe a
maybeAdd (Just x) (Just y) = Just (x + y)
maybeAdd _ _ = Nothing

addBefore :: Maybe a -> [a] -> [a]
addBefore (Just x) y = x : y
addBefore Nothing x = x

-- isNothing fv Data.Maybe-bol van

countNothings :: [Maybe a] -> Int
countNothings [] = 0
countNothings (x:xs)
    | isNothing x = 1 + countNothings xs
    | otherwise = countNothings xs

-- orai listagenerátoros
-- countNothings xs = sum [1 | Nothing <- xs]

safeIndex :: [a] -> Int -> Maybe a
safeIndex [] _ = Nothing
safeIndex (x:xs) n 
    | n > 0 = safeIndex xs (n - 1)
    | n == 0 = Just x
    | otherwise = Nothing

data Point = Point Double Double 
    deriving (Eq, Show)

getX :: Point -> Double
getX (Point x y) = x

getY :: Point -> Double
getY (Point x y) = y

displace :: Point -> Point -> Point
displace (Point x1 y1) (Point x2 y2) = Point (x1 + x2) (y1 + y2)

type Radius = Double

data Shape = Circle Point Radius | Rect Point Point
    deriving (Eq, Show)

area :: Shape -> Double
area (Circle (Point x y) r) = (r * r) * 3.1415
area (Rect (Point x1 y1) (Point x2 y2)) = (x1 - x2) * (y1 - y2)

displaceShape :: Shape -> Point -> Shape
displaceShape (Circle (Point x y) r) (Point x2 y2) = (Circle (Point (x + x2) (y + y2)) r)
displaceShape (Rect (Point x1 y1) (Point x2 y2)) (Point x3 y3) = (Rect (Point (x1 + x3) (y1 + y3)) (Point (x2 + x3) (y2 + y3)))