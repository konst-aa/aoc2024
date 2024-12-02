import Data.List

part1 :: [Int] -> Int
part1 l = part1h comp l
    where comp = if (head l) < (last l) then (<) else (>)

part1h :: (Int -> Int -> Bool) -> [Int] -> Int
part1h comp (a:b:t)
  | (comp a b) && d >= 0 && d <= 3 = part1h comp (b:t)
  | otherwise = 0
  where d = abs (a - b)
part1h comp _ = 1

part2 :: [Int] -> Int
part2 l = fromEnum $ any (== 1) $
    -- lets go negative numbers are chill
    [part1 (a ++ b) | i <- [0..ll], let a = take (i - 1) l, let b = drop i l]
    where ll = length l

main :: IO ()
main = do
  contents <- readFile "inp.txt"
  let reports = map ((map read) . words) $ lines contents
  print $ sum $ map part1 reports
  print $ sum $ map part2 reports

