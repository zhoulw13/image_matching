module Partial where
import GHC.Word as W

partial :: [W.Word8] -> [W.Word8] -> Integer -> Int
partial raw par index =
  if (take 4 raw) == (take 4 par) then
    if (take 100 raw) == (take 100 par) then
      fromIntegral index
    else
      partial (drop 4 raw) par (index+1)
  else
    partial (drop 4 raw) par (index+1)
