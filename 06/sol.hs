import Data.Array
import Data.Array.ST
import qualified Data.Set as S
import Control.Monad.ST
import Data.List
import Data.Maybe

data Direction = N | S | E | W

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

inBounds :: Array (Int, Int) Char -> (Int, Int) -> Bool
inBounds g (i, j) = i >= 1 && i <= rows && j >= 1 && j <= cols
    where ((1, 1), (rows, cols)) = bounds g 

part1 :: Array (Int, Int) Char -> S.Set (Int, Int) -> (Int, Int) -> Direction -> S.Set (Int, Int)
part1 g s p d
  | not $ inBounds g $ p' = s'
  | g ! p' == '#' = part1 g s' p (change d)
  | otherwise = part1 g s' p' d
    where s' = S.insert p s
          p' = move p d

type MySTArr t = STArray t (Int, Int) Char

type Bounds = ((Int, Int), (Int, Int))

inBounds2 :: Bounds -> (Int, Int) -> Bool
inBounds2 ((1,1), (rows, cols)) (i, j) =
    i >= 1 && i <= rows && j >= 1 && j <= cols

weird :: (Int, Int) -> Direction -> (Int, Int)
weird (i, j) N = (i+10000, j)
weird (i, j) S = (i+20000, j)
weird (i, j) E = (i+30000, j)
weird (i, j) W = (i+40000, j)

part2H :: MySTArr s -> Bounds -> S.Set (Int, Int) -> (Int, Int) -> Direction -> ST s Int
part2H g b s p d
  | not $ inBounds2 b p' = pure 0
  | S.member (weird p d) s = pure 1
  | otherwise = do
      c <- g `readArray` p'
      if c == '#' then part2H g b s' p (change d)
                  else part2H g b s' p' d
    where s' = S.insert (weird p d) s
          p' = move p d

part2 :: (Int, Int) -> Int -> MySTArr s -> Bounds -> (Int, Int) -> Direction -> ST s Int
part2 start i g b p d
  | not $ inBounds2 b p' = pure i
  | otherwise = do
      c <- g `readArray` p'
      if c == '#' then part2 start i g b p (change d)
                  else do
                      writeArray g p' '#'
                      toAdd <- part2H g b S.empty start N
                      writeArray g p' '.'
                      part2 start (i + toAdd) g b p' d
    where p' = move p d

main :: IO ()
main = do
    -- contents <- readFile "little.txt"
    contents <- readFile "inp.txt"
    let ls = lines contents
        zls = [ ((i, j), c) | (i, l) <- zip [1..] ls, (j, c) <- zip [1..] l ]
        bounds = ((1,1), (length ls, length $ head ls))
        grid = array bounds $ zls
        start = fst $ fromJust $ find ((=='^'). snd) zls
            
    print $ S.size $ part1 grid S.empty start N
    print $ runST $ do
            mut <- thaw grid
            part2 start 0 mut bounds start N

