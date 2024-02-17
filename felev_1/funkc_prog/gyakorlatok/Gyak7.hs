module Gyak7 where

--type String = [Char]
--type Table = [(Int,Int)]

import Prelude hiding (Maybe(..), lookup, take)

data Color = Red | Green | Blue | White

isWhite :: Color -> Bool
isWhite White = True
--isWhite Red = False
--isWhite Green = False
--isWhite Blue = False
isWhite _ = False

data Colour = RGB Int Int Int --deriving (Show, Eq)

red :: Colour
red = RGB 255 0 0

blue :: Colour
blue = RGB 0 0 255

instance Show Colour where
    show (RGB r g b) = "R = " ++ show r ++ " G = " ++ show g ++ " B = " ++ show b

instance Eq Colour where
    (==) (RGB r1 g1 b1) (RGB r2 g2 b2) = r1 == r2 && g1 == g2 && b1 == b2

data Maybe a = Nothing | Just a 
    deriving (Show, Eq)

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing = False

fromJust :: Maybe a -> a
fromJust (Just x) = x
fromJust Nothing = error "fromJust nem kaphat Nothing értéket"

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs

maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just x) = [x]

safeDiv :: Double -> Double -> Maybe Double
safeDiv _ 0 = Nothing
safeDiv x y = Just (x/y)

lookup ::  Eq a => a -> [(a,b)] -> Maybe b
lookup _ [] = Nothing
lookup y (x:xs) 
   | fst x == y = Just (snd x)
   | otherwise = lookup y xs
{-
lookup y ((a,b):xs)
   | a == y = Just b1
   | otherwise = lookup y xs
-}

lengthOfWords :: String -> [(Int, String)]
lengthOfWords str = [(length x, x) | x <- words str]
{-
   lengthOfWords str = helper (words str)
   where
     helper :: [String] -> [(Int, String)]
	 helper [] = ..
	 helper  (x:xs) = ..
-} 

data List a = Nil | Cons a (List a)
--Cons 5 (Cons 4 (Cons Nil))
--[5,4,2] -> 5 : 4 : 2 : []

instance Show a => Show (List a) where
    show list = "[" ++ showInner list ++ "]"
        where
           showInner Nil = ""
           showInner (Cons x Nil) = show x
           showInner (Cons x y) = show x ++ "," ++ showInner y

fromList :: [a] -> List a
fromList [] = Nil
fromList (x:xs) = Cons x (fromList xs)

toList :: List a -> [a]
toList Nil = []
toList (Cons x y) = x : toList y

data Numbers a = Negative a | Zero | Positive a

mkNumbers :: (Ord a, Num a) => a -> Numbers a
mkNumbers x
   | x < 0 = Negative x
   | x == 0 = Zero
   | otherwise = Positive x

take :: (Ord a, Num a) => Numbers a -> [b] -> [b]
take (Negative _) _ = []
take Zero xs = []
take (Positive x) (y:ys) = y : (take (mkNumbers (x-1)) ys)