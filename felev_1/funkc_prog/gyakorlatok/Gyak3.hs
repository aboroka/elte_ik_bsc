--isEvenTuple :: Int -> (Int, Bool)
isEvenTuple :: Integral a => a -> (a, Bool)
isEvenTuple n = (n, even n)

isOrigo :: (Double, Double) -> Bool
--isOrigo (x,y) = x == 0 && y == 0
isOrigo (0,0) = True
isOrigo _ = False

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

triplicate :: a -> (a,a,a)
triplicate x = (x,x,x)

addPair :: (Num a, Num b) => (a,b) -> (a,b) -> (a,b)
addPair (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

divisors :: Int -> [Int]
divisors n = [x | x <- [2..n-1], n `mod` x == 0]

isPrime :: Int -> Bool
isPrime 1 = False
--isPrime n = divisors n == []
isPrime n = null (divisors n)