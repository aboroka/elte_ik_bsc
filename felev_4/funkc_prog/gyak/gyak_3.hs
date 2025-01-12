module Gyak3 where

{-- [0,3..30]
[10,9..(-10)]

--}
exampleSum :: Int
exampleSum = sum [20,22..30]

powerOfTwo :: [Integer]
powerOfTwo = [2^n | n <- [0..10]]

squareNumbers :: [Integer]
squareNumbers = [2*(n*n) | n <- [1..10]]

dividedBy :: [Integer]
dividedBy = [n | n <- [1..100], n `mod` 3 == 0, n `mod` 5 /= 0]

dividedBySixty :: [Integer]
dividedBySixty = [n | n <- [1..60], 60 `mod` n == 0]

betweenOneAndFifty :: [(Integer,Integer)]
betweenOneAndFifty = [(n, n `mod` 3) | n <- [1..50]]

timeTuples :: [(Int,Int)]
timeTuples = [(n,m) | n <- [0..23], m <- [0..59] ]

{-- nem működik :(( 
isPrime :: Int -> Bool
isPrime n = checkAllFalse [n `mod` m /= 0 | m <- [2..n-1]]


checkAllFalse :: [Bool] -> Bool
checkAllFalse [] = True
checkAllFalse (False:_) = checkAllFalse xs
checkAllFalse _ = False 
--}

isPrime :: Int -> Bool
isPrime n
    | n <= 1 = False
    | n == 2 = True
    | otherwise = checkPrime n 2
    where
        checkPrime n d
            | d > (n `div` 2) = True
            | n `mod` d == 0 = False
            | otherwise = checkPrime n (d + 1)

shift :: (Int,Int) -> Int -> (Int, Int)
shift (x,y) n
    | y + n < 60 = (x,y + n)
    | otherwise = (h, d - (k * 60))
        where 
            d = (x * 60) + (y + n)
            k = d `div` 60
            h = k `mod` 24

{-- | y + n >= 60 && x + 1 < 24 && n < 120 = (x + 1, (y + (n `mod` 60)))
    | y + n >= 60 && x + 1 >= 24  && n < 120= ((x + 1) - 24, (y + (n `mod` 60)))
    | otherwise =  (x - (n `mod` 60), y - (n `mod` 60)) --}
    

areAmicableNumbers :: Integer -> Integer -> Bool
areAmicableNumbers x y = (sum [n | n <- [1..x - 1], x `mod` n == 0] == y) && 
                        (sum [n | n <- [1..y - 1], y `mod` n == 0] == x)


-- primszám lényegesen könnyebben és rövidebben xd:

factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factors n == [1,n]