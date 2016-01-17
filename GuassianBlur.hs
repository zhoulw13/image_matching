module GuassianBlur where
import GHC.Word as W
import Data.Array
import ColorHistogram
import Debug.Trace

guassianBlurMode :: [W.Word8] -> [W.Word8] -> W.Word8 -> Int -> Int -> Int -> Int
guassianBlurMode raw par dims raw_width par_width par_height =
  index-(par_width-1)-raw_width*(par_height-1)
  where raw_feature = colorHistogram raw [] dims raw_width
        par_feature = colorHistogram par [] dims par_width
        len = length raw_feature
        raw_arr = listArray (0, len-1) raw_feature :: Array Int [Int]
        par_img = [last par_feature]
        par_arr = listArray (0, 0) par_img :: Array Int [Int]
        index = optimization raw_arr par_arr raw_width par_width par_height (10^10) 0 len (par_width-1) (par_height-1)


optimization :: Array Int [Int] -> Array Int [Int] -> Int -> Int -> Int -> Integer -> Int -> Int -> Int -> Int -> Int
optimization raw par rw pw ph mx re len width height =
  if index >= len then re
  else if simi <= mx then
    optimization raw par rw pw ph simi index len next_w next_h
  else
    optimization raw par rw pw ph mx re len next_w next_h
  where index = width+height*rw
        raw_f =
          if width < pw then
            if height < ph then
              raw!index
            else
              operate (-) (raw!index) (raw!(index-ph*rw))
          else
            if height < ph then
              operate (-) (raw!index) (raw!(index-pw))
            else
              operate (+) (operate (-) (operate (-) (raw!index) (raw!(index-pw))) (raw!(index-ph*rw))) (raw!(index-pw-ph*rw))
        simi = similarity raw_f (par!0)
        next_w =
          if width == (rw-1) then
            0
          else
            width+1
        next_h =
          if width == (rw-1) then
            height+1
          else
            height
