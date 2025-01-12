module Homework1 where

intExpr1 :: Int
intExpr1 = 5

inc :: Int -> Int
inc x = x + 1

intExpr2 :: Int
intExpr2 = inc intExpr1

double :: Int -> Int
double x = x + x

intExpr3 :: Int
intExpr3 = intExpr2 + double intExpr1

boolExpr1 :: Bool
boolExpr1 = 10 > 3 -- True

boolExpr2 :: Bool
boolExpr2 = 10 `mod` 2 == 0 && 4 `div` 3 == 0 -- False

boolExpr3 :: Bool
boolExpr3 = not (3 > 2 || 3 < 2) -- False

isLuckyNumber :: Int -> Bool
isLuckyNumber x = x `mod` 13 == 0 && x /= 13 && x `mod` 2 == 1

increasingParams :: Int -> Int -> Int -> Bool
increasingParams x y z = x < y && y < z