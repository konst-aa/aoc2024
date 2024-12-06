import Data.Map hiding (drop, take, map, filter, delete)
import qualified Data.Map as M
import Data.Maybe
import Data.List

splitHelp :: String -> String -> String -> Maybe (String, String)
splitHelp sub ori "" = Nothing
splitHelp sub ori s
  | Just new <- stripPrefix sub s = Just (take (length ori - length s) ori, new)
  | otherwise = splitHelp sub ori $ tail s

splitSub :: String -> String -> Maybe (String, String)
splitSub sub s = splitHelp sub s s

fullSplit :: String -> String -> [String]
fullSplit sub s
  | Just (a, b) <- splitSub sub s = [a] ++ fullSplit sub b
  | otherwise = [s]

part1H :: Map Int [Int] -> [Int] -> Int
part1H m en
  | not $ any checkBounds $ assocs t = en !! (length en `div` 2)
  | otherwise = 0
    where t = fromList $ zip en [1..]
          checkAfter i v = (elem v en) && (t ! v) < i
          checkBounds (k, v) = (member k m) && (any (checkAfter v) (m ! k))

part1 :: Map Int [Int] -> [[Int]] -> Int
part1 m ent = sum $ map (part1H m) ent


part2H :: Map Int [Int] -> [Int] -> Int
part2H m en = res !! (length res `div` 2)
    where res = reverse $ helper en
          helper [] = []
          helper en = target:(helper $ delete target en)
              where Just target = (find isFree en)
                    isFree k = all (\n -> not $ elem n en) $ m ! k

part2 :: Map Int [Int] -> [[Int]] -> Int
part2 m ent = sum $ map (part2H m) $ filter ((0 ==) . (part1H m)) ent

main :: IO ()
main = do
    contents <- readFile "inp.txt"
    let [ords, entrs] = fullSplit "\n\n" contents
        m1 = fromListWith (++) $
            [(read a, [read b]) | l <- lines ords, let [a,b] = fullSplit "|" l ]
        l1 = map (\l -> map read $ fullSplit "," l) $ lines entrs
        
    print $ part1 m1 l1
    print $ part2 m1 l1

