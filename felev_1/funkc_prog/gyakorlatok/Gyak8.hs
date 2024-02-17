module Gyak8 where

--data Bool = True | False

data Direction = L | R 
    deriving (Show, Eq)

numOfLs:: [Direction] -> Int
--numOfLs xs = sum[1 | x <- xs, x == L]
numOfLs xs = sum[1 | L <- xs]

f = [('a',b) | ('a',b) <- zip "asdafsfaggasdasfdafd" [1..10]]

mirror :: Direction -> Direction
mirror L = R
mirror R = L

mirrorList :: [Direction] -> [Direction]
mirrorList xs = [mirror x | x <- xs]

data Colour = RGB Int Int Int 
    deriving (Show, Eq)
    
isGray :: Colour -> Bool
isGray (RGB 0 0 0) = False
isGray (RGB 255 255 255) = False
isGray (RGB r g b) = r == g && g == b 

data Point = Point Double Double 
    deriving(Show, Eq)

getX :: Point -> Double
getX (Point x y) = x

getY :: Point -> Double
getY (Point x y) = y

type Student = (String, String)

getName :: Student -> String
getName s = "Name: " ++ fst s

data Shape = Circle Point Double | Rect Point Point
    deriving (Show, Eq)

area :: Shape -> Double
area (Circle _ r) = r*r*pi 
area(Rect (Point x1 y1) (Point x2 y2)) = (abs (x1-x2)) * (abs (y1-y2))

displace :: Point -> Point -> Point
displace (Point x1 y1) (Point x2 y2) = (Point (x1+x2) (y1+y2))
