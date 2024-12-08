import qualified Data.Map as M
import qualified Data.Set as S
import Data.List

type Bounds = ((Int, Int), (Int, Int))
type P = (Int, Int)

instance Num P where
    (ai, aj) + (bi, bj) = (ai + bi, aj + bj)
    (ai, aj) - (bi, bj) = (ai - bi, aj - bj)

inBounds :: Bounds -> (Int, Int) -> Bool
inBounds ((1,1), (rows, cols)) (!i, !j) =
    i >= 1 && i <= rows && j >= 1 && j <= cols


part1 :: Bounds-> [(Int, Int)] -> S.Set (Int, Int)
part1 b l = S.fromList $ foldl (++) [] $ map helper pairs
        where pairs = filter ((== 2) . length) $ subsequences l
              helper [(ai, aj), (bi, bj)] = 
                  filter (inBounds b) [(ai, aj) + d, (bi, bj) - d]
                  where d = (ai - bi, aj - bj)

part2 :: Bounds-> [(Int, Int)] -> S.Set (Int, Int)
part2 b l = S.fromList $ foldl (++) [] $ map helper pairs
        where pairs = filter ((== 2) . length) $ subsequences l
              helper [(ai, aj), (bi, bj)] = p1 ++ p2
                  where d = (ai - bi, aj - bj)
                        p1 = takeWhile (inBounds b) $ iterate (+ d) (ai, aj)
                        -- WHY????
                        -- I couldve used a lambda but this is funnier
                        -- I ALSO COULDVE done the partial application thing
                        -- but idk why ((-) d) doesn't work?
                        p2 = takeWhile (inBounds b) $ iterate (flip (-) $ d) (bi, bj)

main :: IO ()
main = do
    contents <- readFile "inp.txt"
    -- contents <- readFile "little.txt"
    let ls = lines contents
        zls = [ (c, [(i, j)]) | (i, l) <- zip [1..] ls, (j, c) <- zip [1..] l, c /= '.' ]
        m = M.fromListWith (++) $ zls
        bounds = ((1,1), (length ls, length $ head ls))
    print $ S.size $ S.unions $ map (part1 bounds) $ M.elems m
    print $ S.size $ S.unions $ map (part2 bounds) $ M.elems m

