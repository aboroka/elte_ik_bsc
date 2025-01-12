module Homework2 where

oneTrue :: Bool -> Bool -> Bool -> Bool
oneTrue True False False = True
oneTrue False True False = True
oneTrue False False True = True
oneTrue _ _ _ = False

isGray :: (Int, Int, Int) -> Bool
isGray (255,255,255) = False
isGray (0,0,0) = False
isGray (x,y,z) = x == y && y == z

splitQuadruple :: (a,b,c,d) -> ((a,b),(c,d))
splitQuadruple (a,b,c,d) = ((a,b),(c,d))