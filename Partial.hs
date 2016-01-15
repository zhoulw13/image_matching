module Partial where
import GHC.Word as W

partial_o :: [W.Word8] -> [W.Word8] -> Int -> Int
partial_o raw par index =
  if (take 4 raw) == (take 4 par) then
    if (take 100 raw) == (take 100 par) then
      index
    else
      partial_o (drop 4 raw) par (index+1)
  else
    partial_o (drop 4 raw) par (index+1)

partial :: [W.Word8] -> [W.Word8] -> Int -> Int -> Int -> Int
partial raw par rwidth pwidth index =
  if rwidth - (mod index rwidth) < pwidth then
    partial (drop (4*(pwidth-1)) raw) par rwidth pwidth (index+pwidth-1)
  else if (take 4 raw) == (take 4 par) then
    if (take 100 raw) == (take 100 par) then
      index
    else
      partial (drop 4 raw) par rwidth pwidth (index+1)
  else
    partial (drop 4 raw) par rwidth pwidth (index+1)
