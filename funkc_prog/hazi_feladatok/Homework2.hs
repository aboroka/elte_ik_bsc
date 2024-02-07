module Homework2 where

waterTheFlowers :: Int
waterTheFlowers = ceiling((50*0.25)/1.8)

isLeapYear :: Int -> Bool
isLeapYear x = x `mod` 4 == 0 && not(x `mod` 100 == 0) || x `mod` 4 == 0 && x `mod` 100 == 0 && x `mod` 400 == 0 

equivalent :: Bool -> Bool -> Bool
equivalent True True = True
equivalent True False = False
equivalent False True = False
equivalent False False = True

implies :: Bool -> Bool -> Bool
implies True True = True
implies True False = False
implies False True = True
implies False False = True