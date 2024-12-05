import Data.List
import Data.Map hiding (map)

tup2 [a, b] = (a, b)

main :: IO ()
main = do
  contents <- readFile "inp.txt"
  let (a,b) = unzip $
       map (tup2 . (map read) . words) $ lines contents
      c = fromListWith (+) $ map (,1) b
  print $
    sum $ map (abs . (uncurry (-))) $ zip (sort a) (sort b)
  print $
    sum $ map (\n -> n * findWithDefault 0 n c) a

