module Gyak7 where

{-- ELMÉLET

tipusszinonima
összehasonlitas pl "abc" == ['a','b','c'] -> True lesz
eq osztály

olvashatosag növelésére jó, típust nem változtatunk vele
nagybeadandoba majd: int listák listája legyen mátrix

newtype kulcsszó
- egy új típusnevet: `Name`
- egy konstruktornevet: `N` -- adatkonstruktor bármi lehet, lehet Name2 is de teljesen különböző dolgok
- és egy létező típust: `String
Az N konstruktor tesz különbséget a Name és a String típus között.

N "Teszt Elek" == "Kiss Éva" --  nem lesz egyenlő mivel az egyik Name2 a másik string
--}

type Name = String
type Neptun = String
type Student = (Name, Neptun)

getName :: Student -> Name
getName (name, neptun) = name

newtype Name2 = N String deriving (Show, Eq)

getName2 :: Name2 -> String -- mintaillesztés az adatkonsturktorrra
getName2 (N n) = n -- :t N "Teszt Elek" |  getName2 (N "Teszt Elek")

{--
saját adattípusok
data kulcsszó - bármilyen saját adattípust létre lehet hozni
általába ezt használjuk

bool típus paraméter nélküli:

(a fordito automatikuasa is hozzáad derivingot pl eq-t, show-t)

- data kulcsszó
- Bool típuskonstruktor
- adatkonstruktor(ok) elválasztva |-val
- műveletek automatikus hozzáadása (deriving (...))

paraméteres:

data Point2d = P Int Int
deriving (Eq, Ord, Show)
- data kulcsszó
- Point2d típuskonstruktor
- P konstruktor + paraméterek

hogyan tudunk konstruktolni listát (lehetséges + - kérdés)

tipuskonstrkotnak is lehet paramétere


automatikus példányositas az eq meg a show
--}

-- data Bool = False | True deriving (Eq, Show)

-- data Point2d = P Int Int deriving (Eq, Ord, Show)

--type On = Bool
--type Off = Bool

data Binary = On | Off deriving (Eq, Show)

switch :: Binary -> Binary
switch On = Off
switch Off = On

bxor :: [Binary] -> [Binary] -> [Binary]
bxor [] [] = []
bxor _ [] = []
bxor [] _ = []
bxor (a:b) (c:d) 
    | a == c = On : bxor b d
    | otherwise = Off : bxor b d

switchOns :: [Binary] -> Int
switchOns (x:y:xs)
    | x == Off && y == On = 1 + switchOns xs
    | otherwise = switchOns xs
switchOns _ = 0

offPositions :: [Binary] -> [Int]
offPositions xs = indHelp xs 0 where
    indHelp [] _  = []
    indHelp (Off:xs) i = i : indHelp xs (i+1)
    indHelp (On:xs) i = indHelp xs (i+1)

offPositions2 :: [Binary] -> [Int]
offPositions2 xs = [ind | (ind,Off) <- zip [0..] xs]

data Colour = RGB Int Int Int

red :: Colour
red = RGB 255 0 0

green :: Colour
green = RGB 0 255 0

blue :: Colour
blue = RGB 0 0 255

instance Show Colour where
    show (RGB r g b) = "R = " ++ show r ++ " G = " ++ show g ++ " B = " ++ show b
    
instance Eq Colour where
    (==) (RGB r1 g1 b1) (RGB r2 g2 b2) = r1 == r2 && g1 == g2 && b1 == b2

isGray :: Colour -> Bool
isGray (RGB 0 0 0) = False
isGray (RGB 255 255 255) = False
isGray (RGB r g b) = r == g && g == b

isGray2 :: Colour -> Bool
isGray2 (RGB r g b)
    | r == 0 || r == 255 = False
    | r == g && g == b = True
    | otherwise = False

data Weather = Sunny | Cloudy | Rainy Int | Snowy Int 
    deriving (Eq, Show)

niceDayForHiking :: Weather -> Bool
niceDayForHiking Sunny = True
niceDayForHiking Cloudy = True
niceDayForHiking _ = False

weatherForecastInaccuracy :: [Weather] -> [Weather] -> Int
weatherForecastInaccuracy _ [] = 0
weatherForecastInaccuracy [] _ = 0
weatherForecastInaccuracy (Rainy x:xs) (Rainy y:ys) = weatherForecastInaccuracy xs ys
weatherForecastInaccuracy (x:xs) (y:ys)
    | x == y = weatherForecastInaccuracy xs ys
    | otherwise = 1 + weatherForecastInaccuracy xs ys

data Temperature = Night Double | Daytime Double 
    deriving (Eq, Show)

isDaytime :: Temperature -> Bool
isDaytime (Daytime _) = True
isDaytime _ = False

daytimeAvg :: [Temperature] -> Double
daytimeAvg [] = 0
daytimeAvg x = sumDay x / lenDay x
    where 
        sumDay [] = 0
        sumDay (Daytime x:xs) = x + sumDay xs
        sumDay (_:xs) = sumDay xs

        lenDay [] = 0
        lenDay (Daytime x:xs) = 1 + lenDay xs
        lenDay (_:xs) = lenDay xs

--avgList :: [Double] -> Double
--avgList x = sum x / fromIntegral (length x)

