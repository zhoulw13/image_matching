module MedianFilter where
import GHC.Word as W
import Data.List

-- 1 dimension median filter
medianFilter :: [W.Word8] -> Int -> Int -> [W.Word8]
medianFilter [] _ _ = []
medianFilter src width wsize =
  medianFilterLine (take (width*4) src) [] wsize ++ medianFilter (drop (width*4) src) width wsize

medianFilterLine :: [W.Word8] -> [W.Word8] -> Int -> [W.Word8]
medianFilterLine [] _ _ = []
medianFilterLine line prefix wsize =
  if len < half then
    median (prefix ++ (take (half*4+4) line) ++ (concat $ replicate (half - len) (take 4 line))) ++ medianFilterLine (drop 4 line) (prefix ++ take 4 line) wsize
  else
    median (prefix ++ (take (half*4+4) line)) ++ medianFilterLine (drop 4 line) (drop 4 prefix ++ take 4 line) wsize
  where len = div (length prefix) 4
        half = div (wsize - 1) 2

median :: [W.Word8] -> [W.Word8]
median arr = takeInterval 0 arr [] : takeInterval 1 arr [] : takeInterval 2 arr [] : [takeInterval 3 arr []]

takeInterval :: Int -> [W.Word8] -> [W.Word8] -> W.Word8
takeInterval _ [] acc = (sort acc)!!(div (length acc) 2)
takeInterval index arr acc = takeInterval index (drop 4 arr) ((take 4 arr)!!index : acc)
