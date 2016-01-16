module GuassianBlur where
import GHC.Word as W
import ColorHistogram

guassianBlurMode :: [W.Word8] -> [W.Word8] -> W.Word8 -> Int -> Int -> Int -> Int
guassianBlurMode raw par dims raw_width par_width par_height =
  index-(par_width-1)-raw_width*(par_height-1)
  where par_feature = colorHistogram par [] dims par_width
        raw_feature = colorHistogram raw [] dims raw_width
        x = last raw_feature
        --x = last par_feature
        index = (last x) -- +(last y)
        --index = optimization raw_feature (last par_feature) raw_width par_width par_height 0 0 (par_width-1) (par_height-1)

optimization :: [[Int]] -> [Int] -> Int -> Int -> Int -> Integer -> Int -> Int -> Int -> Int
optimization raw par rw pw ph mx re width height =
  if simi > mx then
    optimization raw par rw pw ph simi (width+height*rw) next_w next_h
  else
    optimization raw par rw pw ph mx re next_w next_h
  where index = width+height*rw
        raw_f =
          if width < pw then
            if height < ph then
              raw!!index
            else
              operate (-) (raw!!index) (raw!!(index-(height-ph)*rw))
          else
            if height < ph then
              operate (-) (raw!!index) (raw!!(index-width))
            else
              operate (+) (operate (-) (operate (-) (raw!!index) (raw!!(index-width))) (raw!!(index-(height-ph)*rw))) (raw!!(index-width-(height-ph)*rw))
        simi = similarity raw_f par
        next_w =
          if width == (rw-1) then
            pw-1
          else
            width+1
        next_h =
          if width == (rw-1) then
            height+1
          else
            height
