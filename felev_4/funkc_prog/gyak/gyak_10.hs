module Gyak10 where

{-- ELMÉLET
magasabb rendű függvények:
egyik paramétere, vagy visszatérési értéke függvény
pl. max fv.
max 1 5 = (max 1) 5
:t (max 1) 
parciális alkalmazás, csak egyik paramétert adjuk neki, visszaad egy fv-t
(max 1) nem fog lefutni mert a fv-eknek nincs show-ja

- Operátorokból képzett (egyparaméteres) függvények
- Pl.: `(+3), (<2), (*10)`
- Magasabb rendű függvények paraméterezésére használhatóak


--}

add3 :: (Int -> (Int -> (Int -> (Int))))
add3 a b c = a + b + c

apply :: (a -> a) -> a -> a
apply f x = f x

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x:xs) = (f x) : map' f xs  

filter' :: (a -> Bool) -> [a] -> [a]
filter' f [] = []
filer' f (x:xs)
    | f x = x : filter' f xs
    | otherwise = filter' f xs

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y) : zipWith' f xs ys 

differences :: Num a => [a] -> [a]
differences xs = zipWith (-) (tail xs) xs

selectiveApply :: (a -> a) -> (a -> Bool) -> [a] -> [a]
selectiveApply f p [] = []
selectiveApply f p (x:xs)
    | p x = f x : selectiveApply f p xs
    | otherwise = x : selectiveApply f p xs

isUniform :: Eq b => (a -> b) -> [a] -> Bool
isUniform f [] = True
isUniform f xs = all (==s) m
    where 
        s = f (head xs) 
        m = map f xs

{-- 
dollár operátor - igazából a zárójelet hagyja el

f $ x = f x

f (g x) = f $ g x

függvénykompozíció??

. operátor

map (even . (div 2) . (+2)) lista = valami ilyesmi xd
dc-n bennt van
--}
