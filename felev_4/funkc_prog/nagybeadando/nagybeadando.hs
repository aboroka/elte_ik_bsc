module Nagybeadando where

import Data.List

type Name = String                 -- kártya vagy játékos neve
type Drachma = Int                 -- a pénz a játékban
type Point = Int                   -- pontszám
type Shield = Int                  -- pajzsok száma
type Cost = ([Product], Drachma)   -- a kártya költsége (a `Product` típus később lesz definiálva)
type Table = [[Maybe Card]]        -- a játék tábla (a `Card` típus később lesz definiálva)
type IsBuilt = Bool                -- meg van-e építve (a csodáknál lesz használva)

data Product = Clay Int | Wood Int | Stone Int | Glass Int | Papyrus Int
    deriving (Show, Eq)

data Symbol = Globe | Wheel | Sundial | Mortar | Pendulum | Quill
    deriving (Show, Eq)

data Effect = Price Product | Money Drachma | MoneyByCard Card Drachma | PointsByCard (Either Card WonderCard) Point
    deriving (Show, Eq)

data Card = Materials Name Cost Product | Civilian Name Cost Point | Scientific Name Cost Point Symbol | Military Name Cost Shield | Commercial Name Cost Point Effect | Guilds Name Cost Effect
    deriving (Show, Eq)

data WonderCard = W Name Cost Point Shield Drachma
    deriving (Show, Eq)

data Player = P Name [Card] [(WonderCard, IsBuilt)] Drachma
    deriving (Show, Eq)

blankMaterialsCard = (Materials "" ([], 0) (Stone 0))
blankMilitaryCard = (Military "" ([], 0) 0)
blankCivilianCard = (Civilian "" ([], 0) 0)
blankScientificCard = (Scientific "" ([], 0) 0 (Quill))
blankCommercialCard = (Commercial "" ([], 0) 0 (Price (Stone 0)))
blankWonderCard = (W "" ([], 0) 0 0 0)

allCards :: [Card]
allCards = [
   (Materials "Lumber yard" ([], 0) (Wood 1)),
   (Materials "Logging camp" ([], 1) (Wood 1)),
   (Materials "Clay pool" ([], 0) (Clay 1)),
   (Materials "Clay pit" ([], 1) (Clay 1)),
   (Materials "Quarry" ([], 0) (Stone 1)),
   (Materials "Stone pit" ([], 1) (Stone 1)),
   (Materials "Sawmill" ([], 2) (Wood 2)),
   (Materials "Brickyard" ([], 2) (Clay 2)),
   (Materials "Shelf quarry" ([], 2) (Stone 2)),
   (Materials "Glassworks" ([], 1) (Glass 1)),
   (Materials "Glass blowers" ([], 0) (Glass 1)),
   (Materials "Press" ([], 1) (Papyrus 1)),
   (Materials "Dying room" ([], 0) (Papyrus 1)),

   (Civilian "Theater" ([], 0) 3),
   (Civilian "Altar" ([], 0) 3),
   (Civilian "Baths" ([(Stone 1)], 0) 3),
   (Civilian "Tribunal" ([(Wood 2), (Glass 1)], 0) 5),
   (Civilian "Statue" ([(Clay 2)], 0) 4),
   (Civilian "Temple" ([(Wood 1), (Papyrus 1)], 0) 4),
   (Civilian "Aqueduct" ([(Stone 3)], 0) 5),
   (Civilian "Rostrum" ([(Stone 1), (Wood 1)], 0) 4),
   (Civilian "Palace" ([(Clay 1), (Stone 1), (Wood 1), (Glass 2)], 0) 7),
   (Civilian "Town hall" ([(Stone 3), (Wood 2)], 0) 7),
   (Civilian "Obelisk" ([(Stone 2), (Glass 1)], 0) 5),
   (Civilian "Gardens" ([(Clay 2), (Wood 2)], 0) 6),
   (Civilian "Pantheon" ([(Clay 1), (Wood 1), (Papyrus 2)], 0) 6),
   (Civilian "Senate" ([(Clay 2), (Stone 1), (Papyrus 1)], 0) 5),

   (Scientific "Workshop" ([(Papyrus 1)], 0) 1 (Pendulum)),
   (Scientific "Apothecary" ([(Glass 1)], 0) 1 (Wheel)),
   (Scientific "Academy" ([(Stone 1), (Wood 1), (Glass 2)], 0) 3 (Sundial)),
   (Scientific "Study" ([(Papyrus 1), (Glass 1), (Wood 2)], 0) 3 (Sundial)),
   (Scientific "Scriptorium" ([], 2) 0 (Quill)),
   (Scientific "Library" ([(Stone 1), (Wood 1), (Glass 1)], 0) 2 (Quill)),
   (Scientific "Pharmacist" ([], 2) 0 (Mortar)),
   (Scientific "Dispensary" ([(Papyrus 1)], 0) 2 (Mortar)),
   (Scientific "School" ([(Papyrus 1)], 0) 1 (Wheel)),
   (Scientific "University" ([(Papyrus 1)], 0) 2 (Globe)),
   (Scientific "Laboratory" ([(Papyrus 1)], 0) 1 (Pendulum)),
   (Scientific "Observatory" ([(Papyrus 1)], 0) 2 (Globe)),

   (Military "Guard tower" ([], 0) 1),
   (Military "Walls" ([(Stone 2)], 0) 2),
   (Military "Arsenal" ([(Clay 3), (Wood 2)], 0) 3),
   (Military "Courthouse" ([], 8) 3),
   (Military "Stable" ([(Wood 1)], 0) 1),
   (Military "Horse breeders" ([(Wood 1), (Clay 1)], 0) 1),
   (Military "Garrison" ([(Clay 1)], 0) 1),
   (Military "Barracks" ([], 3) 1),
   (Military "Palisade" ([], 2) 1),
   (Military "Fortifications" ([(Stone 2), (Clay 1), (Papyrus 1)], 0) 2),
   (Military "Archery range" ([(Stone 1), (Wood 1), (Papyrus 1)], 0) 2),
   (Military "Siege workshop" ([(Wood 3), (Glass 1)], 0) 2),
   (Military "Parade ground" ([(Clay 2), (Glass 1)], 0) 2),
   (Military "Circus" ([(Stone 2), (Clay 2)], 0) 2),

   (Commercial "Stone reserve" ([], 3) 0 (Price (Stone 0))),
   (Commercial "Clay reserve" ([], 3) 0 (Price (Clay 0))),
   (Commercial "Wood reserve" ([], 3) 0 (Price (Wood 0))),
   (Commercial "Customs house" ([], 3) 0 (Price (Papyrus 0))),
   (Commercial "Brewery" ([], 3) 0 (Price (Glass 0))),
   (Commercial "Tavern" ([], 0) 0 (Money 6)),
   (Commercial "Forum" ([], 0) 0 (Money 4)),
   (Commercial "Caravansery" ([(Glass 1), (Papyrus 1)], 0) 0 (Money 8)),
   (Commercial "Arena" ([(Stone 1), (Wood 1)], 0) 0 (Money 7)),
   (Commercial "Chamber of commerce" ([(Papyrus 2)], 0) 3 (MoneyByCard blankMaterialsCard 3)),
   (Commercial "Port" ([(Wood 1), (Glass 1), (Papyrus 1)], 0) 3 (MoneyByCard blankMaterialsCard 2)),
   (Commercial "Armory" ([(Stone 2), (Glass 1)], 0) 3 (MoneyByCard blankMilitaryCard 1)),
   (Commercial "Lighthouse" ([(Clay 2), (Glass 1)], 0) 3 (MoneyByCard blankCivilianCard 1)),

   (Guilds "Shipowners guild" ([(Clay 1), (Stone 1), (Glass 1), (Papyrus 1)], 0) (PointsByCard (Left blankMaterialsCard) 1)),
   (Guilds "Tacticians guild" ([(Stone 2), (Clay 1), (Papyrus 1)], 0) (PointsByCard (Left blankMilitaryCard) 1)),
   (Guilds "Magistrates guild" ([(Wood 2), (Clay 1), (Papyrus 1)], 0) (PointsByCard (Left blankCivilianCard) 1)),
   (Guilds "Scientists guild" ([(Wood 2), (Clay 2)], 0) (PointsByCard (Left blankScientificCard) 1)),
   (Guilds "Merchants guild" ([(Clay 1), (Wood 1), (Glass 1), (Papyrus 1)], 0) (PointsByCard (Left blankCommercialCard) 1)),
   (Guilds "Builders guild" ([(Stone 2), (Clay 1), (Wood 1), (Glass 1)], 0) (PointsByCard (Right blankWonderCard) 2)),
   (Guilds "Moneylenders guild" ([(Stone 2), (Wood 2)], 0) (PointsByCard (Right blankWonderCard) 3)) ]

allWonders :: [WonderCard]
allWonders = [
   (W "The Appian Way" ([(Papyrus 1), (Clay 2), (Stone 2)], 0) 3 0 3),
   (W "Circus Maximus" ([(Glass 1), (Wood 1), (Stone 2)], 0) 3 1 0),
   (W "The Colossus" ([(Glass 1), (Clay 3)], 0) 3 2 0),
   (W "The Great Library" ([(Papyrus 1), (Glass 1), (Wood 3)], 0) 4 0 0),
   (W "The Great Lighthouse" ([(Papyrus 2), (Stone 1), (Wood 1)], 0) 4 0 0),
   (W "The Hanging Gardens" ([(Papyrus 1), (Glass 1), (Wood 2)], 0) 3 0 6),
   (W "The Mausoleum" ([(Papyrus 1), (Glass 2), (Clay 2)], 0) 2 0 0),
   (W "Piraeus" ([(Clay 1), (Stone 1), (Wood 2)], 0) 2 0 0),
   (W "The Pyramids" ([(Papyrus 1), (Stone 3)], 0) 9 0 0),
   (W "The Sphinx" ([(Glass 2), (Clay 1), (Stone 1)], 0) 6 0 0),
   (W "The Statue of Zeus" ([(Papyrus 2), (Clay 1), (Wood 1), (Stone 1)], 0) 3 1 0),
   (W "The Temple of Artemis" ([(Papyrus 1), (Glass 1), (Stone 1), (Wood 1)], 0) 0 0 12) ]

-- 1. feladat

countBasicPoints :: Player -> Point
countBasicPoints (P _ cs ws d) = cardPoints + wonderCardPoints + shieldPoints + guildPoints + drachmaPoints
    where
        cardPoints = countCardPoints cs
        builtWonders = getBuiltWCards ws
        wonderCardPoints = countWCardPoints builtWonders
        shieldPoints = countShieldPoints cs builtWonders
        guildPoints = countGuildCards cs
        drachmaPoints = (d `div` 3)

countGuildCards :: [Card] -> Point
countGuildCards xs = length (filter isGuild xs)
    where 
        isGuild (Guilds _ _ _) = True
        isGuild _ = False

countCardPoints :: [Card] -> Point
countCardPoints xs = sum (map getPointsFromCards xs)
    where
        getPointsFromCards (Civilian _ _ p) = p
        getPointsFromCards (Scientific _ _ p _) = p
        getPointsFromCards _ = 0

getBuiltWCards :: [((WonderCard), IsBuilt)] -> [WonderCard]
getBuiltWCards xs = [u | (u,v) <- xs, v == True]

countWCardPoints :: [WonderCard] -> Point
countWCardPoints [] = 0
countWCardPoints ((W _ _ p _ _):xs) = p + countWCardPoints xs

countShieldPoints :: [Card] -> [WonderCard] -> Point
countShieldPoints [] [] = 0
countShieldPoints cs ws 
    | allShields >= 1 && allShields < 3 = 2
    | allShields >= 3 && allShields < 6 = 5
    | allShields >= 6 = 10
    | otherwise = 0
    where 
        allShields = getMilitaryShields cs + getWCardShields ws

getWCardShields :: [WonderCard] -> Shield
getWCardShields ws = sum [s | (W _ _ _ s _) <- ws]

getMilitaryShields :: [Card] -> Shield
getMilitaryShields cs = sum [s | Military _ _ s <- cs]

-- 2. feladat

militaryVictory :: Player -> Player -> Maybe Player
militaryVictory (P s cs ws d) (P s2 cs2 ws2 d2)
    | (p1shields - 9) >= p2shields = Just (P s cs ws d)
    | (p2shields - 9) >= p1shields = Just (P s2 cs2 ws2 d2)
    | otherwise = Nothing
    where
        p1shields = getWCardShields (getBuiltWCards ws) + getMilitaryShields cs
        p2shields = getWCardShields (getBuiltWCards ws2) + getMilitaryShields cs2

-- 3. fealdat

costInMoney :: Cost -> [Card] -> Drachma
costInMoney ([], d) cs = d
costInMoney (costs, d) cs = priceOfThings costs (lowMaterialCosts cs) (playerInventory cs) + d

playerInventory :: [Card] -> [Product]
playerInventory cs = map getProduct (filter isMaterials cs)
    where
        getProduct (Materials _ _ s) = s
        isMaterials (Materials _ _ _) = True
        isMaterials _ = False

lowMaterialCosts :: [Card] -> [Product]
lowMaterialCosts cs = nub $ map getCommercialType (filter isCommercialPrice (filter isCommercial cs))
    where
        isCommercial (Commercial _ _ _ _) = True
        isCommercial _ = False
        getCommercialType (Commercial _ _ _ (Price (Clay n))) = (Clay n)
        getCommercialType (Commercial _ _ _ (Price (Wood n))) = (Wood n)
        getCommercialType (Commercial _ _ _ (Price (Stone n))) = (Stone n)
        getCommercialType (Commercial _ _ _ (Price (Glass n))) = (Glass n)
        getCommercialType (Commercial _ _ _ (Price (Papyrus n))) = (Papyrus n)
        getCommercialType _ = (Papyrus 10)
        isCommercialPrice (Commercial _ _ _ (Price _)) = True
        isCommercialPrice _ = False

priceOfThings :: [Product] -> [Product] -> [Product] -> Drachma
priceOfThings costs sales playerInv = clayPrice + woodPrice + stonePrice + glassPrice + papyrusPrice
    where
        clayPrice = (\x -> if x < 0 then 0 else x) $ priceOfClay (filter isClay costs) (filter isClay playerInv) (filter isClay sales)
            where
                isClay (Clay _) = True
                isClay _ = False
        woodPrice = (\x -> if x < 0 then 0 else x) $ priceOfWood (filter isWood costs) (filter isWood playerInv) (filter isWood sales)
            where
                isWood (Wood _) = True
                isWood _ = False
        stonePrice = (\x -> if x < 0 then 0 else x) $ priceOfStone (filter isStone costs) (filter isStone playerInv) (filter isStone sales)
            where
                isStone (Stone _) = True
                isStone _ = False
        glassPrice = (\x -> if x < 0 then 0 else x) $ priceOfGlass (filter isGlass costs) (filter isGlass playerInv) (filter isGlass sales)
            where
                isGlass (Glass _) = True
                isGlass _ = False
        papyrusPrice = (\x -> if x < 0 then 0 else x) $ priceOfPapyrus (filter isPapyrus costs) (filter isPapyrus playerInv) (filter isPapyrus sales)
            where
                isPapyrus (Papyrus _) = True
                isPapyrus _ = False

-- for clay
priceOfClay :: [Product] -> [Product] -> [Product] -> Drachma
priceOfClay cost playerInv sale
    | null sale = initialPrice
    | otherwise = initialPrice - ((initialPrice `div` 3) * 2)
    where
        initialPrice = (oneCost * 3) - (oneInv * 3)
        oneCost 
            | null cost = 0
            | otherwise = clayToInt (head cost)
        oneInv = countClays playerInv
        clayToInt (Clay n) = n
        countClays xs = sum [n | (Clay n) <- xs]

-- for wood 
priceOfWood :: [Product] -> [Product] -> [Product] -> Drachma
priceOfWood cost playerInv sale
    | null sale = initialPrice
    | otherwise = initialPrice - ((initialPrice `div` 3) * 2)
    where
        initialPrice = (oneCost * 3) - (oneInv * 3)
        oneCost 
            | null cost = 0
            | otherwise = woodToInt (head cost)
        oneInv = countWoods playerInv
        woodToInt (Wood n) = n
        countWoods xs = sum [n | (Wood n) <- xs]

-- for stone
priceOfStone :: [Product] -> [Product] -> [Product] -> Drachma
priceOfStone cost playerInv sale
    | null sale = initialPrice
    | otherwise = initialPrice - ((initialPrice `div` 3) * 2)
    where
        initialPrice = (oneCost * 3) - (oneInv * 3)
        oneCost 
            | null cost = 0
            | otherwise = stoneToInt (head cost)
        oneInv = countStones playerInv
        stoneToInt (Stone n) = n
        countStones xs = sum [n | (Stone n) <- xs]

-- for glass
priceOfGlass :: [Product] -> [Product] -> [Product] -> Drachma
priceOfGlass cost playerInv sale
    | null sale = initialPrice
    | otherwise = initialPrice - ((initialPrice `div` 3) * 2)
    where
        initialPrice = (oneCost * 3) - (oneInv * 3)
        oneCost 
            | null cost = 0
            | otherwise = glassToInt (head cost)
        oneInv = countGlasses playerInv
        glassToInt (Glass n) = n
        countGlasses xs = sum [n | (Glass n) <- xs]

-- for glass
priceOfPapyrus :: [Product] -> [Product] -> [Product] -> Drachma
priceOfPapyrus cost playerInv sale
    | null sale = initialPrice
    | otherwise = initialPrice - ((initialPrice `div` 3) * 2)
    where
        initialPrice = (oneCost * 3) - (oneInv * 3)
        oneCost 
            | null cost = 0
            | otherwise = papyrusToInt (head cost)
        oneInv = countPapyruses playerInv
        papyrusToInt (Papyrus n) = n
        countPapyruses xs = sum [n | (Papyrus n) <- xs]
        

-- 4. feladat

guildPoints :: Player -> Player -> Point
guildPoints (P _ cs ws p) (P _ cs2 ws2 p2) = (\x -> if x < 0 then 0 else x) ((\x y -> if x >= y then x else y) p1Points p2Points) + totalWSpoints
    where
        zippedPointWithConvertCard = zip convertedCardsToCount pointsCountedByCard
        zippedPointWithConvertCardWONDER = zip convertedCardsToCount pointsCountedByCard
        cardsToCount = map getFromJust (filter isNothing (map getCardFromEither (map getEffect (filter isGuild cs))))
            where
                isNothing Nothing = False
                isNothing _ = True
                getCardFromEither (Left a) = (Just a) 
                getCardFromEither _ = Nothing
                getFromJust (Just a) = a
        wonderCardsToCount = map getFromJust (filter isNothing (map getWonderCardFromEither (map getEffect (filter isGuild cs))))
            where
                isNothing Nothing = False
                isNothing _ = True
                getWonderCardFromEither (Right a) = (Just a) 
                getWonderCardFromEither _ = Nothing
                getFromJust (Just a) = a
        pointsCountedByCard = map getPointFromPointsByCard (filter filterByCard (filter isGuild cs))
            where
                getPointFromPointsByCard (Guilds _ _ (PointsByCard (Left _) p)) = p
                filterByCard (Guilds _ _ (PointsByCard (Left _) p)) = True
                filterByCard _ = False
        pointsCountedByCardWONDER = map getPointFromPointsByCardWONDER (filter filterByCard (filter isGuild cs))
            where
                getPointFromPointsByCardWONDER (Guilds _ _ (PointsByCard (Right _) p)) = p
                filterByCard (Guilds _ _ (PointsByCard (Right _) p)) = True
                filterByCard _ = False
        convP1cs = convertCards cs
        convP2cs = convertCards cs2
        convertedCardsToCount = map convertOneCard cardsToCount
        cardPoints num playerCards
            | condition = points * extraPoints
            | otherwise = 0
            where
                points = length $ countBy num playerCards
                extraPoints 
                    | condition = head [v | (u,v) <- (filter (\(x,y) -> x == num) zippedPointWithConvertCard)]
                    | otherwise = 1
                condition = any (\(x,y) -> x == num) zippedPointWithConvertCard
        wonderCardPoints ws = points * (sum pointsCountedByCardWONDER)
            where
                isBuilt ((W _ _ _ _ _), True) = True
                isBuilt _ = False
                points = length $ filter isBuilt ws
        p1Points = totalCardPoints
            where
                totalCardPoints = cardPoints 0 convP1cs + cardPoints 1 convP1cs + cardPoints 2 convP1cs + cardPoints 3 convP1cs + cardPoints 4 convP1cs + cardPoints 5 convP1cs
        p2Points = totalCardPoints
            where
                totalCardPoints = cardPoints 0 convP2cs + cardPoints 1 convP2cs + cardPoints 2 convP2cs + cardPoints 3 convP2cs + cardPoints 4 convP2cs + cardPoints 5 convP2cs
        totalWSpoints = (\x y -> if x >= y then x else y) (wonderCardPoints ws) (wonderCardPoints ws2)

countBy :: Int -> [Int] -> [Int]
countBy 0 cs = filter (==0) cs
countBy 1 cs = filter (==1) cs
countBy 2 cs = filter (==2) cs
countBy 3 cs = filter (==3) cs
countBy 4 cs = filter (==4) cs
countBy 5 cs = filter (==5) cs

convertCards :: [Card] -> [Int]
convertCards [] = []
convertCards ((Materials _ _ _):cs) = 0 : convertCards cs
convertCards ((Civilian _ _ _):cs) = 1 : convertCards cs
convertCards ((Scientific _ _ _ _):cs) = 2 : convertCards cs
convertCards ((Military _ _ _):cs) = 3 : convertCards cs
convertCards ((Commercial _ _ _ _):cs) = 4 : convertCards cs
convertCards ((Guilds _ _ _):cs) = 5 : convertCards cs

convertOneCard :: Card -> Int
convertOneCard (Materials _ _ _) = 0
convertOneCard (Civilian _ _ _) = 1
convertOneCard (Scientific _ _ _ _) = 2
convertOneCard (Military _ _ _) = 3
convertOneCard (Commercial _ _ _ _) = 4
convertOneCard (Guilds _ _ _) = 5

isGuild :: Card -> Bool
isGuild (Guilds _ _ _) = True
isGuild _ = False

getEffect :: Card -> (Either Card WonderCard)
getEffect (Guilds _ _ (PointsByCard (Left a) n)) = (Left a)
getEffect (Guilds _ _ (PointsByCard (Right b) n)) = (Right b)

getCardFromEither :: (Either Card WonderCard) -> Maybe Card
getCardFromEither (Left a) = (Just a) 
getCardFromEither _ = Nothing

-- 5. feladat

scientificPlusPoints :: Player -> Point
scientificPlusPoints (P _ cs ws p) = globesPoint + wheelsPoint + sundialsPoint + mortarsPoint + pendulumsPoint + quillsPoint 
    where
        isScientific (Scientific _ _ _ _) = True
        isScientific _ = False
        getSymbol (Scientific _ _ _ s) = s
        getPoint (Scientific _ _ p _) = p
        symbols = map getSymbol $ filter isScientific cs
        points = map getPoint $ filter isScientific cs
        zipped = zip symbols points
        --globes
        globes = [v | (u,v) <- zipped, isGlobe u]
            where
                isGlobe (Globe) = True
                isGlobe _ = False
        globesPoint = if (length globes) == 2 then (sum globes) * 2 else 0
        --wheels
        wheels = [v | (u,v) <- zipped, isWheel u]
            where
                isWheel (Wheel) = True
                isWheel _ = False
        wheelsPoint = if (length wheels) == 2 then (sum wheels) * 2 else 0
        --sundials
        sundials = [v | (u,v) <- zipped, isSundial u]
            where
                isSundial (Sundial) = True
                isSundial _ = False
        sundialsPoint = if (length sundials) == 2 then (sum sundials) * 2 else 0
        --mortars
        mortars = [v | (u,v) <- zipped, isMortar u]
            where
                isMortar (Mortar) = True
                isMortar _ = False
        mortarsPoint = if (length mortars) == 2 then (sum mortars) * 2 else 0
        --pendulums
        pendulums = [v | (u,v) <- zipped, isPendulum u]
            where
                isPendulum (Pendulum) = True
                isPendulum _ = False
        pendulumsPoint = if (length pendulums) == 2 then (sum pendulums) * 2 else 0
        --quills
        quills = [v | (u,v) <- zipped, isQuill u]
            where
                isQuill (Quill) = True
                isQuill _ = False
        quillsPoint = if (length quills) == 2 then (sum quills) * 2 else 0

-- extra feladatok

canBuyCard :: Card -> Player -> Bool
canBuyCard card (P _ cs ws d) 
    | d >= drachmaCost = True
    | otherwise = False
    where
        cardCost = getCost card
        drachmaCost = costInMoney cardCost cs

getCost :: Card -> Cost
getCost (Materials _ c _) = c
getCost (Civilian _ c _) = c
getCost (Scientific _ c _ _) = c
getCost (Military _ c _) = c
getCost (Commercial _ c _ _) = c
getCost (Guilds _ c _) = c 

canBuyWonder :: WonderCard -> Player -> Bool
canBuyWonder wCard (P name cs ws d) = canBuyWonderCardWithCost cost (P name cs ws d) && (not (not playerHasWonder || wonderIsBuilt))
    where
        playerHasWonder = any (==wCard) (getWonders ws)
        wonderIsBuilt = any (==wCard) (getBuiltWCards ws)
        cost = getCostOfWonder wCard
        getCostOfWonder (W _ (ps, d) _ _ _) = (ps,d)

canBuyWonderCardWithCost :: Cost -> Player -> Bool
canBuyWonderCardWithCost cost (P _ cs ws d) 
    | d >= drachmaCost = True
    | otherwise = False
    where
        drachmaCost = costInMoney cost cs

getWonders :: [((WonderCard), IsBuilt)] -> [WonderCard]
getWonders xs = [u | (u,v) <- xs]

data Action = DropCard Card | BuildWonder Card WonderCard | BuildCard Card 
    deriving (Show)

dropCard :: Player -> Card -> Player
dropCard (P name cs ws d) card
    | shops /= 0 = (P name cs ws (d + shops + 2)) 
    | otherwise = (P name cs ws (d + 2)) 
    where
        isCommercial (Commercial _ _ _ _) = True
        isCommercial _ = False
        shops = length (filter isCommercial cs)

buildCard :: Player -> Card -> Player
buildCard (P n cs ws d) card = (P n newCards ws (d - costOfCard + moneyFromComms + pointsFromMoneyByCard))
    where
        costOfCard = costInMoney (getCost card) cs
        newCards = card : cs
        moneyFromComms 
            | isCommercialMoney card = getMoneyFromCommercial card
            | otherwise = 0 
            where
                isCommercialMoney (Commercial _ _ _ (Money _)) = True
                isCommercialMoney _ = False 
        getMoneyFromCommercial (Commercial _ _ _ (Money d)) = d
        getCardFromMoneyByCard (Commercial _ _ _ (MoneyByCard e p)) = e
        getPointFromMoneyByCard (Commercial _ _ _ (MoneyByCard e p)) = p
        filterByCard = length (filter (==moneyByCards) convertedCards)
        pointsFromMoneyByCard
            | isCommercialMoneyBY card = pointsMoneyByCard
            | otherwise = 0
            where
                isCommercialMoneyBY (Commercial _ _ _ (MoneyByCard _ _)) = True
                isCommercialMoneyBY _ = False 
        pointsMoneyByCard
            | null mlist = 0
            | otherwise = filterByCard * (head mlist)
            where
                mlist = [v | (u,v) <- zipped]
        convertedCards = convertCards cs
        moneyByCards
            | null mlist = 0
            | otherwise = (head mlist)
            where
                mlist = [u | (u,v) <- zipped]
        zipped = zip moneyCards pointCards
            where
                moneyCards = map convertOneCard (map getCardFromMoneyByCard (filter isCommercialMoneyBY cs))
                pointCards = map getPointFromMoneyByCard (filter isCommercialMoneyBY cs)
                isCommercialMoneyBY (Commercial _ _ _ (MoneyByCard _ _)) = True
                isCommercialMoneyBY _ = False 

buildWonder :: Player -> WonderCard -> Player
buildWonder (P name cs ws d) (W wName cost p shield wd)
    | isInPlayerHand && not isItBuilt = (P name cs newWonderCards (d - costOfCard + drachmaOfNewCard (W wName cost p shield wd)))
    | otherwise = (P name cs ws d)
    where
        isInPlayerHand = any (==wName) (map getWName ws)
        isItBuilt = head [v | ((W name c pp s wwd),v) <- ws, name == wName]
        newWonderCards = beingBuilt ws wName
        costOfCard = costInMoney (getCost (W wName cost p shield wd)) cs
        getCost (W _ cost _ _ _) = cost
        drachmaOfNewCard (W _ _ p _ d) = d

getWName :: (WonderCard, IsBuilt) -> Name
getWName ((W wName _ _ _ _), _) = wName

beingBuilt :: [(WonderCard, IsBuilt)] -> Name ->[(WonderCard, IsBuilt)]
beingBuilt [] _ = []
beingBuilt (((W wname cost p shield d),built):ws) name
    | name == wname = ((W wname cost p shield d),True) : beingBuilt ws name
    | otherwise = ((W wname cost p shield d),built) : beingBuilt ws name
