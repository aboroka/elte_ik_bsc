module Homework9 where

data Weather = Sunny | Cloudy | Rainy Int | Snowy Int
    deriving (Eq, Show)

summerVacation :: [Weather] -> [Weather]
summerVacation [] = []
summerVacation x = head [u | (v,u) <- zip listOfLengths (splittedWeather), v == maximum listOfLengths]
    where 
        listOfLengths = map length (splittedWeather)
        splittedWeather = splitWeather x

sunOrCloud :: Weather -> Bool
sunOrCloud Sunny = True
sunOrCloud Cloudy = True
sunOrCloud _ = False

splitWeather :: [Weather] -> [[Weather]]
splitWeather [] = []
splitWeather (x:xs)
    | sunOrCloud x = (x : goodW) : splitWeather others
    | otherwise = splitWeather xs
    where 
        goodW = takeWhile sunOrCloud xs
        others = dropWhile sunOrCloud xs

maxPrecipitation :: [Weather] -> Int
maxPrecipitation [] = 0
maxPrecipitation x = head [v | (v,u) <- zip listOfRainSum splittedDays, v == maximum listOfRainSum]
    where 
        listOfRainSum = map addRains splittedDays
        splittedDays = splitRainyDays x

rainyDay :: Weather -> Bool
rainyDay (Rainy s) = True
rainyDay _ = False

splitRainyDays :: [Weather] -> [[Weather]]
splitRainyDays [] = []
splitRainyDays (x:xs)
    | rainyDay x = (x : rainyDs) : splitRainyDays others
    | otherwise = splitRainyDays xs
        where
            rainyDs = takeWhile rainyDay xs
            others = dropWhile rainyDay xs

addRains :: [Weather] -> Int
addRains [] = 0
addRains (Rainy d:xs) = d + addRains xs

data Time = Time Int Int
    deriving (Show, Eq)

timeTable :: [Time] -> Time -> Int -> Maybe Time
timeTable [] (Time _ _) _ = Nothing
timeTable x t2 travTime
    | null mins = Nothing
    | otherwise = Just (head [u | (v,u) <- (zip leastTimes x), v == minTime])
    where
        lastOption = timeConverter ((intConverter t2) - travTime)
        len = length x
        repeatedList = take len (repeat lastOption)
        leastTimes = map timeSubtraction (zip repeatedList x)
        mins = filter (>0) leastTimes
        minTime = minimum mins


timeConverter :: Int -> Time
timeConverter n = Time h m
    where 
        h = n `div` 60
        m = (n - h * 60)

intConverter :: Time -> Int
intConverter (Time h m) = (h * 60) + m

timeSubtraction :: (Time, Time) -> Int
timeSubtraction (t1, t2) = intConverter t1 - intConverter t2

