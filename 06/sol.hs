import Data.Array
import Data.Array.ST
import qualified Data.Set as S
import Control.Monad.ST
import Data.List
import Data.Maybe

data Direction = N | S | E | W
    deriving (Eq,Ord)

type MySTArr t = STArray t (Int, Int) Char

type Bounds = ((Int, Int), (Int, Int))

move :: (Int, Int) -> Direction -> (Int, Int)
move (i, j) N = (i-1, j)
move (i, j) S = (i+1, j)
move (i, j) E = (i, j+1)
move (i, j) W = (i, j-1)

change :: Direction -> Direction
change N = E
change E = S
change S = W
change W = N


inBounds :: Bounds -> (Int, Int) -> Bool
inBounds ((1,1), (rows, cols)) (i, j) =
    i >= 1 && i <= rows && j >= 1 && j <= cols

part1 :: Array (Int, Int) Char -> Bounds -> S.Set (Int, Int) -> (Int, Int) -> Direction -> S.Set (Int, Int)
part1 g b s p d
  | not $ inBounds b p' = s'
  | g ! p' == '#' = part1 g b s' p (change d)
  | otherwise = part1 g b s' p' d
    where s' = S.insert p s
          p' = move p d

part2H :: MySTArr s -> Bounds -> S.Set ((Int, Int), Direction) -> (Int, Int) -> Direction -> ST s Bool
part2H g b s p d
  | not $ inBounds b p' = pure False
  | S.member (p, d) s = pure True
  | otherwise = do
      c <- g `readArray` p'
      if c == '#' then part2H g b s' p (change d)
                  else part2H g b s' p' d
    where s' = S.insert (p, d) s
          p' = move p d

part2 :: (Int, Int) -> S.Set (Int, Int) -> MySTArr s -> Bounds -> (Int, Int) -> Direction -> ST s (S.Set (Int, Int))
part2 start ds g b p d
  | not $ inBounds b p' = pure ds
  | otherwise = do
      c <- g `readArray` p'
      if c == '#'
         then part2 start ds g b p (change d)
         else tryNew >>= (\ds'-> part2 start ds' g b p' d)
    where p' = move p d
          tryNew = do
              writeArray g p' '#'
              toAdd <- part2H g b S.empty start N
              writeArray g p' '.'
              pure $ if toAdd && p' /= start
                        then S.insert p' ds
                        else ds 


main :: IO ()
main = do
    -- contents <- readFile "little.txt"
    contents <- readFile "inp.txt"
    let ls = lines contents
        zls = [ ((i, j), c) | (i, l) <- zip [1..] ls, (j, c) <- zip [1..] l ]
        bounds = ((1,1), (length ls, length $ head ls))
        grid = array bounds $ zls
        start = fst $ fromJust $ find ((=='^'). snd) zls
            
    print $ S.size $ part1 grid bounds S.empty start N

    print $ S.size $ runST $ do
            mut <- thaw grid
            part2 start S.empty mut bounds start N

