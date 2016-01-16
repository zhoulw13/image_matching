module ColorHistogram where
import GHC.Word as W

colorHistogram :: [W.Word8] -> [[Int]] -> W.Word8 -> Int -> [[Int]]
colorHistogram [] lst dims width = []
colorHistogram img lst dims width =
  thl ++ colorHistogram (drop (4*width) img) thl dims width
  where thl = colorHistogramLine (take (4*width) img) lst [] dims

colorHistogramLine :: [W.Word8] -> [[Int]] -> [Int] -> W.Word8 -> [[Int]]
colorHistogramLine [] lst pre dims = [pre]

--first line
colorHistogramLine line [] [] dims =
  colorHistogramLine (drop 4 line) [] (insert1 (initiate size) (pixel (take 4 line) dims)) dims
  where size = dims*dims*dims
colorHistogramLine line [] pre dims =
  pre : colorHistogramLine (drop 4 line) [] (insert1 pre (pixel (take 4 line) dims)) dims
  where size = dims*dims*dims


colorHistogramLine line lst [] dims =
  colorHistogramLine (drop 4 line) lst (insert1 (head lst) (pixel (take 4 line) dims)) dims
colorHistogramLine line lst pre dims =
  pre : colorHistogramLine (drop 4 line) (tail lst) (operate (-) (operate (+) (insert1 pre (pixel (take 4 line) dims)) (head $ tail lst)) (head lst)) dims

pixel :: [W.Word8] -> W.Word8 -> W.Word8
pixel  (r:g:b:a) dims =
  div r size + dims * (div g size + dims * div b size)
  where size = div 255 dims + 1

operate f [] [] = []
operate f ls1 ls2 = f (head ls1) (head ls2) : operate f (tail ls1) (tail ls2)

insert1 :: [Int] -> W.Word8 -> [Int]
insert1 feat 0 = (head feat + 1) : tail feat
insert1 feat r = head feat : insert1 (tail feat) (r-1)

initiate :: W.Word8 -> [Int]
initiate 0 = []
initiate d = 0 : initiate (d-1)

similarity :: [Int] -> [Int] -> Integer
similarity [] [] = 0
similarity (x:xs) (y:ys) = ((fromIntegral x :: Integer) * (fromIntegral y :: Integer)) + similarity xs ys
