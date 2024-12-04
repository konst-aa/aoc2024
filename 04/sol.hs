import Data.Array

inBounds :: Array (Int, Int) t -> (Int, Int) -> Bool
inBounds g (i, j)
  | si <= i && i <= ei && sj <= j && j <= ej = True
  | otherwise = False
    where ((si, sj), (ei, ej)) = bounds g

pred1 :: String -> Int
pred1 "XMAS" = 1
pred1 "SAMX" = 1
pred1 _ = 0

ixList :: Ix i => Array i t -> [i] -> [t]
ixList arr is = map (arr ! ) is

checkRow :: Array (Int, Int) Char -> (Int, Int) -> Int
checkRow grid (i, j)
  | inBounds grid (i, j+3) = pred1 $
      ixList grid [(i, j), (i, j+1), (i, j+2), (i, j+3)]
  | otherwise = 0

checkCol :: Array (Int, Int) Char -> (Int, Int) -> Int
checkCol grid (i, j)
  | inBounds grid (i + 3, j) = pred1 $
      ixList grid [(i, j), (i+1, j), (i+2, j), (i+3, j)]
  | otherwise = 0

checkRightDia :: Array (Int, Int) Char -> (Int, Int) -> Int
checkRightDia grid (i, j)
  | inBounds grid (i + 3, j+3) = pred1 $
      ixList grid [(i, j), (i+1, j+1), (i+2, j+2), (i+3, j+3)]
  | otherwise = 0

checkLeftDia :: Array (Int, Int) Char -> (Int, Int) -> Int
checkLeftDia grid (i, j)
  | inBounds grid (i - 3, j+3) = pred1 $
      ixList grid [(i, j), (i-1, j+1), (i-2, j+2), (i-3, j+3)]
  | otherwise = 0

part1 :: Array (Int, Int) Char -> Int
part1 grid = sum $ map checkAll $ indices grid
  where checkAll p = sum $ map (\f -> f grid p) [checkRow, checkCol, checkRightDia, checkLeftDia]

pred2 :: String -> Bool
pred2 "MS" = True
pred2 "SM" = True
pred2 _ = False

checkX :: Array (Int, Int) Char -> (Int, Int) -> Int
checkX grid (i, j)
  | not $ inBounds grid (i-1, j-1) && inBounds grid (i+1, j+1) = 0
checkX grid (i, j)
  | grid ! (i, j) == 'A' && pred2 p1 && pred2 p2 = 1
  | otherwise = 0
  where p1 = ixList grid [(i-1, j-1), (i+1, j+1)]
        p2 = ixList grid [(i-1, j+1), (i+1, j-1)]


part2 :: Array (Int, Int) Char -> Int
part2 grid = sum $ map (checkX grid) $ indices grid

main :: IO ()
main = do
    -- contents <- readFile "little.txt"
    contents <- readFile "inp.txt"
    let ls = lines contents
        grid = array ((1,1), (length ls, length $ head ls)) $
            [ ((i, j), c) | (i, l) <- zip [1..] ls, (j, c) <- zip [1..] l ]
    print $ part1 grid
    print $ part2 grid
