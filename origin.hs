module Origin where
import GHC.Word as W

calculate :: [W.Word8] -> [W.Word8] -> Integer -> Int
calculate raw par index =
  if (take 4 raw) == (take 4 par) then
    if (take 100 raw) == (take 100 par) then
      fromIntegral index
    else
      calculate (drop 4 raw) par (index+1)
  else
    calculate (drop 4 raw) par (index+1)
