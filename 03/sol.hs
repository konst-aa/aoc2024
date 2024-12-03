import Data.Char
import Data.List

import Text.Regex.Posix


parsePref :: String -> String -> Maybe String
parsePref p s
    | take l s == p = Just $ drop l s
    | otherwise = Nothing
    where l = length p

parseNum :: String -> Maybe (Int, String)
parseNum s
  | a == [] = Nothing
  | otherwise = Just (read a, b)
  where (a, b) = span isDigit s

parseMul :: String -> Maybe (Int, String)
parseMul s = do
    s1 <- parsePref "mul(" s
    (n1, s2) <- parseNum s1
    s3 <- parsePref "," s2
    (n2, s4) <- parseNum s3
    s5 <- parsePref ")" s4
    pure (n1 * n2, s5)

part1 :: String -> Int -> Int
part1 [] a = a
part1 s a
  | Just (n, s') <- parseMul s = part1 s' (n+a) -- TIL about this syntax
  | otherwise = part1 (drop 1 s) a -- try the next character

part2 :: String -> Bool -> Int -> Int
part2 [] on a = a
part2 s False a
  | Just s' <- parsePref "do()" s = part2 s' True a
part2 s True a
  | Just s' <- parsePref "don't()" s = part2 s' False a
  | Just (n, s') <- parseMul s = part2 s' True (a + n)
part2 s b a = part2 (drop 1 s) b a


-- now with regex
mulString = "(mul\\(([0-9]+),([0-9]+)\\))"
doParens = "(do\\(\\))"
dontParens = "(don't\\(\\))"
allRe = mulString ++ "|" ++ doParens ++ "|" ++ dontParens

-- when the posix regex library makes the code as ugly as bash
part1Re :: String -> Int
part1Re s
  | (_ :: String, _ :: String, after, [_, a, b]) <- s =~ mulString =
      (read a * read b) + part1Re after
  | otherwise = 0

part2Re :: String -> Bool -> Int
part2Re s True
  | match == "don't()" = part2Re after False
  | match == "do()" = part2Re after True
  | isPrefixOf "mul(" match =
      read (head $ drop 1 res) * read (head $ drop 2 res) + part2Re after True
  | otherwise = 0
  where (_ :: String, match, after, res :: [String]) = s =~ allRe
part2Re s False
  | match == "do()" = part2Re after True
  | otherwise = part2Re after False
  where (_ :: String, match, after, res :: [String]) = s =~ allRe


main :: IO ()
main = do
  contents <- readFile "inp.txt"
  putStrLn "Handmade solution"
  print $ part1 contents 0
  print $ part2 contents True 0
  putStrLn "Using POSIX regex"
  print $ part1Re contents
  print $ part2Re contents True

